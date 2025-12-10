#!/bin/bash

set -ouex pipefail

# Enable RPM Fusion
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y $(grep -vE '^\s*(#|$)' /repo_files/packages | sort -u)

systemctl enable podman.socket
systemctl mask systemd-remount-fs.service
