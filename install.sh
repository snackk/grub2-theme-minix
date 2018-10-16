#!/bin/bash

ROOT_UID=0

# check command availability
function has_command() {
    command -v $1 > /dev/null
}

if [ "$UID" -eq "$ROOT_UID" ]; then

  echo -e "Installing Minix grub2 theme."

  # Copy Mimix
  cp -a Minix /boot/grub/themes

  # Set Mimix
  grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
  echo "GRUB_THEME=\"/boot/grub/themes/Vimix/theme.txt\"" >> /etc/default/grub

  # update grub
  if has_command update-grub; then
    update-grub
  elif has_command grub-mkconfig; then
    grub-mkconfig -o /boot/grub/grub.cfg
  fi

  echo -e "\n All done!"

else
  echo -e "\n Please run this script with root."
fi