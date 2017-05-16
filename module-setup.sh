#!/bin/bash

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {
    inst_dir /keys
    inst /boot/header.img /keys/header.img
    inst /boot/lvm.key /keys/lvm.key
    inst_hook 'initqueue/finished' 00 "$moddir/mount.sh"
}

