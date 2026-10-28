#!/usr/bin/env bash

# Installs the theme and hooks it up to Omarchy's theming:
#  - installs the firefox.css template, so `omarchy theme set` renders the
#    current theme's colors to ~/.local/state/omarchy/current/theme/firefox.css
#  - renders that file once for the current theme
#  - links it into every profile as theme/omarchy/generated.css
#
# Takes the same options as install.sh. Firefox reads its CSS at startup, so
# restart it after switching Omarchy themes.

set -e

THEMEDIRECTORY=$(cd "$(dirname "$0")" && cd .. && pwd)
FIREFOXFOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/mozilla/firefox"
TEMPLATE="$THEMEDIRECTORY/omarchy/firefox.css.tpl"
USER_TEMPLATES_DIR="$HOME/.config/omarchy/themed"
CURRENT_THEME_DIR="$HOME/.local/state/omarchy/current/theme"
GENERATED="$CURRENT_THEME_DIR/firefox.css"

while getopts 'f:p:' flag; do
	case "${flag}" in
	f) FIREFOXFOLDER="${OPTARG}" ;;
	p) ;;
	*) exec "$THEMEDIRECTORY/scripts/install.sh" -h ;;
	esac
done

"$THEMEDIRECTORY/scripts/install.sh" "$@"

echo "Installing Omarchy template in $USER_TEMPLATES_DIR"
mkdir -p "$USER_TEMPLATES_DIR"
cp -f "$TEMPLATE" "$USER_TEMPLATES_DIR/firefox.css.tpl"

# Render the template for the current theme, the same way
# omarchy-theme-set-templates does, so it's there before the next theme switch.
if [ -f "$CURRENT_THEME_DIR/colors.toml" ] && command -v omarchy-theme-color >/dev/null; then
	echo "Rendering $GENERATED"
	sed_script=$(mktemp)
	while IFS=$'\t' read -r key value; do
		printf 's|{{ %s }}|%s|g\n' "$key" "$value" >>"$sed_script"
	done < <(omarchy-theme-color --file "$CURRENT_THEME_DIR/colors.toml" --all)
	sed -f "$sed_script" "$TEMPLATE" >"$GENERATED"
	rm "$sed_script"
else
	echo "No Omarchy theme found, the Gruvbox fallback palette will be used." >&2
fi

for theme_dir in "$FIREFOXFOLDER"/*/chrome/firefox-gnome-theme; do
	[ -d "$theme_dir" ] || continue
	echo "Linking Omarchy colors into $theme_dir"
	ln -sfn "$GENERATED" "$theme_dir/theme/omarchy/generated.css"
done

echo "Done. Restart Firefox to apply."
