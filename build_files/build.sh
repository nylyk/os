#!/bin/bash

set -ouex pipefail

# Enable RPM Fusion
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install packages from official repos and RPM Fusion
dnf install -y $(grep -vE '^\s*(#|$)' /build_files/packages/packages.txt | sort -u)

# Install packages from COPR
dnf copr -y enable sdegler/hyprland
dnf install -y $(grep -vE '^\s*(#|$)' /build_files/packages/copr_packages.txt | sort -u)
dnf copr -y disable sdegler/hyprland

systemctl enable podman.socket
systemctl mask systemd-remount-fs.service
