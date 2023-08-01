#!/bin/sh

clear
sudo pacman -Syyu
sudo pacman -S archlinux-keyring pacman-contrib
sudo timedatectl set-local-rtc 1 --adjust-system-clock

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay --editmenu --nodiffmenu --save

PKGS=(
  # Gpu drivers
  'amd-ucode'                     # Microcode updates for AMD processors
  'xf86-video-amdgpu'             # AMDGPU video driver for Xorg
  'lib32-mesa'                    # 32-bit Mesa graphics library
  'vulkan-radeon'                 # Vulkan driver for AMD Radeon GPUs
  'lib32-vulkan-radeon'           # 32-bit Vulkan driver for AMD Radeon GPUs
  'vulkan-icd-loader'             # Vulkan Installable Client Driver (ICD) loader
  'lib32-vulkan-icd-loader'       # 32-bit Vulkan ICD loader

  # WM & base packages
  'ly'                            # A lightweight TUI display manager
  'git'                           # Version control system CLI
  'xorg-xinput'                   # X.Org input driver utility
  'xorg-xsetroot'                 # X.Org server resource modification tool
  'curl'                          # Command-line tool for transferring data with URLs
  'wget'                          # Command-line utility for downloading files
  'wmname'                        # Set the window manager name
  'yad'                           # Display dialogs from shell scripts
  'tlp'                           # Power management tool for Linux
  'tlp-rdw'                       # Radio Device Wizard for TLP
  'alsa-utils'                    # Utilities for configuring and using ALSA
  'bluez'                         # Bluetooth protocol stack for Linux
  'bluez-utils'                   # Utilities for the Bluetooth protocol stack
  'pulseaudio-bluetooth'          # Bluetooth support for PulseAudio
  'blueberry'                     # Bluetooth configuration tool
  'brightnessctl'                 # Control backlight brightness
  'pavucontrol'                   # PulseAudio Volume Control
  'micro'                         # Terminal-based text editor
  'kitty'                         # Fast, feature-rich, GPU-based terminal emulator
  'fish'                          # User-friendly shell
  'starship'                      # Minimalist, fast shell prompt
  'feh'                           # Image viewer and wallpaper setter
  'autorandr'                     # Auto-detect RandR script

  # WM 
  'awesome'                       # Highly configurable tiling and floating WM
  'unclutter'                     # Hides the mouse cursor after a period of inactivity
  'xbanish'                       # Hides the mouse cursor when typing
  'polybar'                       # Fast and easy-to-use status bar
  'rofi'                          # Window switcher, application launcher, and dmenu replacement
  'dunst'                         # Lightweight notification daemon
  'ksuperkey'                     # Maps a key to the "Super" (Windows) key
  'picom-jonaburg-git'            # Compositor for X11
  'wedder-git'                    # Wallpaper setter for X11
  'xsettingsd'                    # Provides settings to X11 applications
  'i3lock-color'                  # Improved screen locker for X

  'redshift-minimal'              # Adjusts the color temperature of the screen at night
  'safeeyes'                      # Eye protection tool
  'copyq'                         # Clipboard manager with advanced features
  'ufw'                           # Uncomplicated Firewall
  'iptables'                      # Userspace command-line tool for IPv4 and IPv6 packet filtering and NAT

  # Fonts, icons, cursors, themes
  'ttf-jetbrains-mono-nerd'       # JetBrains Mono Nerd Font
  'ttf-iosevka-nerd'              # Iosevka Nerd Font
  'ttf-ms-win11-auto'             # Microsoft Windows 11 font family
  'papirus-icon-theme'            # Papirus icon theme
  'papirus-folders'               # Papirus folder icons
  'capitaine-cursors'             # Capitaine Cursors
  'whitesur-gtk-theme'            # WhiteSur GTK Theme

  # File manager & utils
  'thunar'                        # Modern file manager for Xfce
  'thunar-archive-plugin'         # Archive plugin for Thunar
  'xarchiver'                     # GTK+ frontend for most used compression formats
  'gvfs'                          # Virtual filesystem implementation for GIO
  'gvfs-mtp'                      # MTP backend for GVfs
  'tumbler'                       # D-Bus service for applications to request thumbnails
  'ffmpegthumbnailer'             # Lightweight video thumbnailer
  'tumbler-folder-thumbnailer'    # Thumbnailer for folders
  'webp-pixbuf-loader'            # WebP loader for GdkPixbuf
  'unrar'                         # Unarchiver for .rar files
  'unzip'                         # Extractor for .zip files
  'zip'                           # Compressor/archiver for .zip files
  'p7zip-gui'                     # 7-Zip GUI
  'ranger'                        # TUI file manager with VI key bindings
  'ueberzug'                      # TUI image viewer with fast preloading
  'ntfs-3g'                       # NTFS filesystem driver and utilities
  'gksu'                          # GTK+ frontend for su and sudo

  # Media
  'mpv'                           # Command-line media player
  'mpd'                           # Music player daemon
  'ncmpcpp'                       # Ncmpcpp MPD client
  'cava'                          # Console-based audio visualizer
  'glava'                         # OpenGL audio spectrum visualizer

  # Browsers
  'qutebrowser'                   # Keyboard-driven web browser
  'librewolf-bin'                 # LibreWolf browser (binary version)
  'brave-bin'                     # Brave browser (binary version)

  # Social
  'telegram-desktop'              # Official Telegram Desktop client
  'discord'                       # All-in-one voice, video, and text chat for gamers
  'skypeforlinux-stable-bin'      # Skype for Linux (binary version)
  'zoom'                          # Video conferencing and messaging

  # Dev apps
  'neovim'                        # Fork of Vim focused on extensibility and usability
  'visual-studio-code-bin'        # Visual Studio Code (binary version)
  'phpstorm'                      # PHP integrated development environment
  'docker'                        # Platform for building, shipping, and running applications in containers
  'docker-compose'                # Docker Compose
  'git'                           # Version control system CLI
  'diff-so-fancy'                 # Good-looking git diffs
  'jre-openjdk'                   # Java Runtime Environment based on OpenJDK
  'nodejs-lts-fermium'            # JavaScript runtime based on Chrome's V8 engine (LTS)
  'npm'                           # Node package manager
  'nvm'                           # Node Version Manager
  'yarn'                          # Fast and reliable package manager for Node.js
  'php'                           # General-purpose scripting language for web development
  'phpstan'                       # PHP Static Analysis Tool
  'phpmd'                         # PHP Mess Detector
  'composer'                      # Dependency manager for PHP
  'mycli'                         # CLI client for MySQL and MariaDB
  'mariadb'                       # Fast, multi-threaded, and robust SQL database server
  'pgcli'                         # CLI client for PostgreSQL
  'postgresql'                    # Object-relational database system
  'litecli'                       # CLI client for SQLite

  # VM
  'qemu-full'                     # QEMU full virtualization on x86 hardware
  'virt-manager'                  # Virtual machine manager
  'virt-viewer'                   # Virtual Machine Viewer (VNC and SPICE client)
  'dnsmasq'                       # Lightweight, easy-to-configure DNS forwarder and DHCP server
  'vde2'                          # Ethernet bridge emulator
  'bridge-utils'                  # Utilities for configuring the Linux Ethernet bridge
  'openbsd-netcat'                # OpenBSD variant of the netcat network utility
  'ebtables'                      # Ethernet bridge frame table administration
  'iptables'                      # Userspace command-line tool for IPv4 and IPv6 packet filtering and NAT
  'libguestfs'                    # Tools for accessing and modifying VM disk images

  # Gaming
  # 'wine'                        # Compatibility layer for running Windows applications on Linux
  # 'wine-mono'                   # Mono .NET implementation for Wine
  # 'wine-gecko'                  # Mozilla's layout engine for Wine
  'portproton'                    # Proton, a compatibility layer for running Windows games on Linux

  # Graphics Utilities
  'gimp'                          # GNU Image Manipulation Program
  'kdenlive'                      # Non-linear video editing suite
  'shotcut'                       # Cross-platform video editor
  'handbrake'                     # Open-source video transcoder
  'upscayl-bin'                   # Upscaling super-resolution program

  # Other
  'yt-dlp'                        # YouTube-DL with additional features
  'timer'                         # Simple countdown timer
  'fzf'                           # Command-line fuzzy finder
  'scrcpy'                        # Display and control Android devices
  'gparted'                       # GNOME Partition Editor
  'timeshift'                     # Backup and restore tool
  'neofetch'                      # CLI system information tool
  'acpi'                          # Client for Advanced Configuration and Power Interface
  'ncdu'                          # NCurses Disk Usage
  'flameshot'                     # Screenshot tool
  'obs-studio'                    # Open Broadcaster Software for video recording and live streaming
  'qbittorrent'                   # BitTorrent client
  'gotop-bin'                     # Terminal-based graphical activity monitor
  'espanso-bin'                   # Cross-platform text expander
  'figma-linux-bin'               # Figma design tool (binary version)
  'obsidian'                      # Knowledge base and note-taking app
  'koreader-bin'                  # eBook reader application
  'peaclock'                      # Timer, alarm, and clock utility
  'syncthing'                     # Continuous file synchronization program
  'veracrypt'                     # Disk encryption utility
  'libreoffice-fresh'             # LibreOffice fresh version
  'ventoy-bin'                    # Bootable USB drive creator
  'stacer-bin'                    # Linux system optimizer and monitoring tool (binary version)
  'bleachbit'                     # System cleaner
  'asciiquarium'                  # Animated aquarium in ASCII art
  'megasync-git'                  # Cloud storage and file synchronization client (Git version)
  'keepassxc-git'                 # Cross-platform password manager (Git version)
)

for PKG in "${PKGS[@]}"; do
  echo "Installing: ${PKG}"
  yay -S "$PKG" --noconfirm --needed
done

papirus-folders -C bluegrey

sudo systemctl enable ly.service
sudo ufw enable
sudo systemctl enable ufw.service
sudo ufw allow ssh
sudo systemctl enable paccache.timer
sudo systemctl enable tlp.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo systemctl enable --now bluetooth
sudo systemctl enable --now libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo systemctl restart libvirtd.service
systemctl --user enable --now mpd.service

chsh -s /usr/bin/fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

sudo npm install --global gulp webpack

# Give execution permission for all scripts in the directory
chmod -R +x ~/.config

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Tool for optimizing battery life
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

sudo yay -Yc


