PARTUUID_ROOT="12175c45-1c64-4038-b212-fe3f6ce2766c";
CRYPTO_DISK="/dev/disk/by-partuuid/$PARTUUID_ROOT"

if [ -e "$CRYPTO_DISK" ]; then
    if [ -e "/dev/mapper/lvm" ]; then
        exit 0;
    fi

    echo "Unlocking encrypted FS";
    cryptsetup luksOpen --header /keys/header.img --key-file /keys/lvm.key "$CRYPTO_DISK" lvm || emergency_shell;
    echo "Activating LVM"
    lvm vgchange -ay || emergency_shell;
else
    exit 1;
fi

exit 0;
