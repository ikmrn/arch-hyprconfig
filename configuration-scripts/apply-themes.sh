#!/bin/bash

###########################
### Theme Configuration ###
###########################

# This script applies various themes and configurations to the system.
# It sets the Papirus-Dark theme for folder icons, applies the sddm-astronaut-theme
# to SDDM, updates the SDDM configuration, and sets Kitty as the default terminal in Dolphin.


script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
main_dir="$(dirname "$script_dir")"
source "$main_dir/install-scripts/functions.sh"


echo "Applying themes"
papirus-folders --theme Papirus-Dark -C cat-mocha-teal

# Apply sddm theme
THEME="/usr/share/sddm/themes/sddm-astronaut-theme"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git "$THEME"
sudo cp /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

sudo cp -r "$main_dir/configs/.config/wallpapers" "$THEME/wallpapers/"
echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

sudo sed -i 's/FormPosition="center"/FormPosition="right"/' "$THEME/theme.conf"

# Use sed to replace the Background line with the new wallpaper path
sudo sed -i 's|^Background=.*|Background="wallpapers/oxxaca-TNdTGcexUNY-unsplash.jpg"|' "$THEME/theme.conf"


# Make kitty default terminal in dolphin
FILE="$HOME/.config/kdeglobals"
echo -e "[General]\nTerminalApplication=kitty" | tee -a "$FILE"

# Apply gnome themes
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

echo
print_green "########################################"
print_green "Themes are applied"
