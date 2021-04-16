#!/bin/sh

tmp="$1"
init="$2"

mkdir -p "${tmp}/dev"
for f in null zero random urandom ptmx tty; do
    touch "${tmp}/dev/$f"
    chmod -rwx "${tmp}/dev/$f"
    mount -o bind "/dev/$f" "${tmp}/dev/$f"
done

env --ignore-environment PATH="/bin" /usr/sbin/chroot "${tmp}" "${init}"
