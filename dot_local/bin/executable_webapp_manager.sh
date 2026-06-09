#!/usr/bin/env bash
set -euo pipefail

# Config
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/webapps"
META_TAG="# created-by: Webapp Installer"

mkdir -p "$DESKTOP_DIR" "$ICON_DIR"

# Handle clean exit on Ctrl+C / kill / normal finish
cleanup() {
  echo "Exiting WebApp Installer."
  exit
}
trap cleanup INT TERM EXIT

# Detect Chrome binary
if command -v google-chrome-stable >/dev/null 2>&1; then
  CHROME_BIN="google-chrome-stable"
elif command -v google-chrome >/dev/null 2>&1; then
  CHROME_BIN="google-chrome"
else
  echo "Error: Google Chrome not found (tried google-chrome-stable and google-chrome)."
  exit 1
fi

while true; do
  echo
  echo "== WebApp Installer =="
  echo "1) Install WebApp"
  echo "2) Uninstall WebApp"
  echo "3) Quit"
  read -rp "Choose: " ACTION

  case "${ACTION,,}" in
  1 | "i" | "install")
    read -rp "App Name: " NAME
    read -rp "App URL: " URL

    # slugify name
    SLUG=$(printf '%s' "$NAME" |
      tr '[:upper:]' '[:lower:]' |
      tr -cs 'a-z0-9' '-' |
      sed 's/^-//;s/-$//')

    [[ -z "$SLUG" ]] && {
      echo "Invalid name."
      continue
    }

    ICON_PATH="$ICON_DIR/$SLUG.png"
    DESKTOP_PATH="$DESKTOP_DIR/$SLUG.desktop"

    # extract domain
    DOMAIN=$(printf '%s' "$URL" | sed -E 's#^[a-zA-Z]+://##' | cut -d/ -f1)

    echo "Fetching icon for $DOMAIN ..."
    # try Google's favicon service first; fallback to /favicon.ico
    if ! curl -fsL "https://www.google.com/s2/favicons?sz=256&domain=$DOMAIN" -o "$ICON_PATH"; then
      curl -fsL "https://$DOMAIN/favicon.ico" -o "$ICON_PATH" || true
    fi
    # fallback to Chrome icon if fetch failed/empty
    if [[ ! -s "$ICON_PATH" ]]; then
      if [[ -f "/usr/share/icons/hicolor/48x48/apps/google-chrome.png" ]]; then
        ICON_PATH="/usr/share/icons/hicolor/48x48/apps/google-chrome.png"
      else
        ICON_PATH=""
      fi
    fi

    echo "Creating desktop entry ..."
    {
      echo "[Desktop Entry]"
      echo "Type=Application"
      echo "Name=$NAME"
      echo "Exec=$CHROME_BIN --app=\"$URL\""
      [[ -n "$ICON_PATH" ]] && echo "Icon=$ICON_PATH"
      echo "Terminal=false"
      echo "Categories=Network;WebBrowser;"
      echo "$META_TAG"
    } >"$DESKTOP_PATH"

    chmod +x "$DESKTOP_PATH"
    echo "Installed: $DESKTOP_PATH"
    [[ -f "$ICON_PATH" ]] && echo "Icon saved to: $ICON_PATH"
    ;;

  2 | "u" | "uninstall")
    shopt -s nullglob
    mapfile -t CANDIDATES < <(grep -lF "$META_TAG" "$DESKTOP_DIR"/*.desktop 2>/dev/null || true)

    if ((${#CANDIDATES[@]} == 0)); then
      echo "No Web Apps found in $DESKTOP_DIR."
      continue
    fi

    echo "Select an app to remove:"
    i=1
    declare -A NAME_BY_INDEX=()
    for f in "${CANDIDATES[@]}"; do
      APPNAME=$(grep -m1 '^Name=' "$f" | cut -d= -f2- || basename "$f")
      echo "  $i) $APPNAME  ($f)"
      NAME_BY_INDEX[$i]="$f"
      ((i++))
    done

    read -rp "Enter number: " PICK
    FILE="${NAME_BY_INDEX[$PICK]:-}"
    if [[ -z "$FILE" ]]; then
      echo "Invalid selection."
      continue
    fi

    ICON_LINE=$(grep -m1 '^Icon=' "$FILE" | cut -d= -f2- || true)
    if [[ -n "$ICON_LINE" && "$ICON_LINE" == "$ICON_DIR/"* && -f "$ICON_LINE" ]]; then
      rm -f -- "$ICON_LINE" && echo "Removed icon: $ICON_LINE"
    fi

    rm -f -- "$FILE"
    echo "Removed: $FILE"
    ;;

  3 | "q" | "quit")
    echo "Bye!"
    exit 0
    ;;

  *)
    echo "Please choose 1/2/3 (install/uninstall/quit)."
    ;;
  esac
done
