#!/usr/bin/env bash
set -e

if [[ $EUID -ne 0 ]]; then
  echo "Error: Run as root."
  exit 1
fi

if [[ -z "$1" ]]; then
  echo "Error: LUKS partition argument required."
  echo "Usage: $0 <device> (e.g., $0 /dev/nvme0n1p7)"
  exit 1
fi

LUKS_DEV="$1"

# Validate it is a physical block device
if [[ ! -b "$LUKS_DEV" ]]; then
  echo "Error: '$LUKS_DEV' is not a valid block device."
  exit 1
fi

# Validate it is actually a LUKS container before attempting cryptenroll
if ! cryptsetup isLuks "$LUKS_DEV"; then
  echo "Error: '$LUKS_DEV' is not a valid LUKS device. Did your NVMe enumeration shift again?"
  exit 1
fi

echo "=> Wiping old TPM enrollment (if any)..."
systemd-cryptenroll --wipe-slot=tpm2 "$LUKS_DEV" || true

echo "=> Enrolling new TPM measurements (PCRs 0, 2, 7)..."
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7 "$LUKS_DEV"

echo "=> Regenerating initramfs..."
mkinitcpio -P

echo "=> Success."
