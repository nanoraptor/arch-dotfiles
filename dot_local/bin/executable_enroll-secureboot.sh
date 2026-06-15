#!/usr/bin/env bash
set -e

if [[ $EUID -ne 0 ]]; then
  echo "Error: Run as root."
  exit 1
fi

if ! command -v sbctl &>/dev/null; then
  echo "Error: sbctl is not installed. Run: pacman -S sbctl"
  exit 1
fi

if ! sbctl status | grep -qi "Setup Mode:.*Enabled"; then
  echo "Error: System is NOT in Setup Mode. Reboot to UEFI, disable Secure Boot, and clear keys first."
  exit 1
fi

echo "=> Generating Secure Boot keys..."
sbctl create-keys

echo "=> Enrolling keys to EFI variables (preserving Microsoft keys)..."
sbctl enroll-keys -m

echo "=> Signing systemd-boot and Linux kernel..."
sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sbctl sign -s /boot/vmlinuz-linux

echo "=> Verifying signatures..."
sbctl verify || true

echo "=> Success. Reboot and ENABLE Secure Boot in UEFI."
