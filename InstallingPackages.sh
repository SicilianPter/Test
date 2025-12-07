#!/bin/bash
#for Key
pacman-key --init
pacman-key --populate archlinux
#Installing
pacstrap /mnt \
base \
base-devel \
sof-firmware \
pipewire \
linux \
linux-firmware \
linux-headers
zsh-completion \
zsh \
neovim \
grub \
efibootmgr \
btrfs-progs \
snapper \
grub-btrfs\
git \
fastfetch \
networkmanager \
network-manager-applet \
wpa_supplicent \
#KDE
xorg \
plasma \
sddm \
konsole \
ark
spectacle
dolphin \
okular \
kate 
kdeconnect \ 
klipper \
fwupdmgr \
libreoffice \
firefox \
bluez \
bluez-utils \
alsa-utils \
pulseaudio \
pulseaudio-bluetooth
xdg-utils \
xdg-user-dirs \
reflector \
cups \
hplip \
genfstab -U /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab

echo -e "Setting up Region and Language\n"
	arch-chroot /mnt bash -c "ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && hwclock --systohc && sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen && echo 'LANG=en_US.UTF-8' > /etc/locale.conf && exit"

echo "Set Root password"
	arch-chroot /mnt bash -c "passwd && useradd -mG wheel -s /bin/zsh elliot && passwd elliot && EDITOR=nvim visudo && exit"

echo -e "Setting up Hostname\n"
	arch-chroot /mnt bash -c "echo localhost > /etc/hostname && echo 127.0.0.1	localhost > /etc/hosts && echo ::1	localhost >> /etc/hosts && echo 127.0.1.1	Arch-Linux.localdomain	Arch-Linux >> /etc/hosts && exit"

echo "Setting Keymap"
    arch-chroot /mnt bash -c "echo 'KEYMAP=us > /etc/vconsole.conf' && exit"

echo "Setting BTRFS Hooks (Modules)"
    arch-chroot /mnt bash -c "nvim /etc/mkinitcpio.conf && mkinitcpio -p linux && exit"

echo -e "Installing GRUB.."
	arch-chroot /mnt bash -c "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch-Linux && grub-mkconfig -o /boot/grub/grub.cfg && exit"

