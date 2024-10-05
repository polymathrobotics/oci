#!/bin/bash

set -eu
set -o pipefail
set -x

SOURCE_ISO="ubuntu-22.04.5-live-server-amd64.iso"
DESTINATION_ISO="ubuntu-autoinstall.iso"
AUTOINSTALL_CONFIG_FILE="autoinstall.example"
ISOLINUX_BOOTLOADER=0

error() {
  echo "ERROR $*" >&2
}

die() {
  error "$@"
  exit 1
}

usage() {
  cat <<EOF
Usage:  $0 [-s source-iso-file]

Replace grub.cfg on Ubuntu ISO

  -h    Print help
  -s    Source ISO path
  -d    Destination ISO path
  -g    Grub.cfg file
  -l    Loopback.cfg file
  -i    Use legacy isolinux bootloader (for Ubuntu 20.04)
EOF
}

args() {
  while [ "$#" -gt 0 ]; do
    case "${1}" in
      (-s|--source)
        SOURCE_ISO="${2-}"
	[[ ! -f "$SOURCE_ISO" ]] && die "Source ISO file could not be found."
	shift
        ;;
      (-d | --destination)
        DESTINATION_ISO="${2-}"
	shift
	;;
      (-g | --grub)
        GRUB_CONFIG_FILE="${2-}"
        shift
        ;;
      (-l | --loopback)
        LOOPBACK_CONFIG_FILE="${2-}"
        shift
        ;;
      (-h | --help)
        usage
        exit 0
        ;; 
      (-i | --isolinux)
        ISOLINUX_BOOTLOADER=1
        ;;
    esac
    shift
  done
}

create_tmp_dirs() {
  ISO_FILESYSTEM_DIR=$(mktemp -d)
  if [[ ! "${ISO_FILESYSTEM_DIR}" || ! -d "${ISO_FILESYSTEM_DIR}" ]]; then
    echo "Could not create temporary ISO filesystem directory."
  else
    echo "Created temporary ISO filesystem directory ${ISO_FILESYSTEM_DIR}"
  fi

  BOOT_IMAGE_DIR=$(mktemp -d)
  if [[ ! "${BOOT_IMAGE_DIR}" || ! -d "${BOOT_IMAGE_DIR}" ]]; then
    echo "Could not create boot image directory."
  else
    echo "Created temporary boot image directory ${BOOT_IMAGE_DIR}"
  fi

}

extract_iso() {
  if [ ! -f "${SOURCE_ISO}" ]; then
    die "Source ISO could not be found."
  fi

  echo "Extracting ISO image..."
  xorriso -osirrox on -indev "${SOURCE_ISO}" -extract / "${ISO_FILESYSTEM_DIR}"
  
  TODAY=$(date +"%Y-%m-%d")

  if [ ${ISOLINUX_BOOTLOADER} -eq 0 ]; then
    MBR_IMAGE="ubuntu-original-$TODAY.mbr"
    EFI_IMAGE="ubuntu-original-$TODAY.efi"
    dd if="${SOURCE_ISO}" bs=1 count=446 of="${BOOT_IMAGE_DIR}/${MBR_IMAGE}"

    START_BLOCK=$(fdisk -l "${SOURCE_ISO}" | fgrep '.iso2 ' | awk '{print $2}')
    SECTORS=$(fdisk -l "${SOURCE_ISO}" | fgrep '.iso2 ' | awk '{print $4}')
    dd if="${SOURCE_ISO}" bs=512 skip="${START_BLOCK}" count="${SECTORS}" of="${BOOT_IMAGE_DIR}/${EFI_IMAGE}"
  fi
}

configure_grub() {
  if [ -f "${GRUB_CONFIG_FILE-}" ]; then
    echo "copying custom grub.cfg ${GRUB_CONFIG_FILE}"
    cp "${GRUB_CONFIG_FILE}" "${ISO_FILESYSTEM_DIR}/boot/grub/grub.cfg"
  fi

  if [ -f "${LOOPBACK_CONFIG_FILE-}" ]; then
    echo "copying custom loopback.cfg ${LOOPBACK_CONFIG_FILE}"
    cp "${LOOPBACK_CONFIG_FILE}" "${ISO_FILESYSTEM_DIR}/boot/grub/loopback.cfg"
  fi
}

reassemble_iso() {
  if [ ${ISOLINUX_BOOTLOADER} -eq 0 ]; then
    xorriso -as mkisofs \
      -r -V "ubuntu-autoinstall-${TODAY}" -J -joliet-long -l \
      -iso-level 3 \
      -partition_offset 16 \
      --grub2-mbr "${BOOT_IMAGE_DIR}/${MBR_IMAGE}" \
      --mbr-force-bootable \
      -append_partition 2 0xEF "${BOOT_IMAGE_DIR}/${EFI_IMAGE}" \
      -appended_part_as_gpt \
      -c boot.catalog \
      -b boot/grub/i386-pc/eltorito.img \
      -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info \
      -eltorito-alt-boot \
      -e '--interval:appended_partition_2:all::' \
      -no-emul-boot \
      -o "${DESTINATION_ISO}" "${ISO_FILESYSTEM_DIR}"
  else
    xorriso -as mkisofs \
      -r -V "ubuntu-autoinstall-${TODAY}" -J \
      -b isolinux/isolinux.bin \
      -c isolinux/boot.cat \
      -no-emul-boot \
      -boot-load-size 4 \
      -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
      -boot-info-table \
      -input-charset utf-8 \
      -eltorito-alt-boot \
      -e boot/grub/efi.img \
      -no-emul-boot \
      -isohybrid-gpt-basdat -o "${DESTINATION_ISO}" "${ISO_FILESYSTEM_DIR}"
  fi
}

args "$@"
create_tmp_dirs
extract_iso
configure_grub
reassemble_iso
