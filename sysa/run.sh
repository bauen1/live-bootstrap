#!/bin/bash

# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
# SPDX-FileCopyrightText: 2021 fosslinux <fosslinux@aussies.space>
# SPDX-FileCopyrightText: 2021 Paul Dersey <pdersey@gmail.com>
# SPDX-FileCopyrightText: 2021 Jonathan Hettwer (bauen1) <j2468h@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e
set -x
# shellcheck source=sysa/helpers.sh
. helpers.sh

populate_device_nodes() {
    # http://www.linuxfromscratch.org/lfs/view/6.1/chapter06/devices.html
    test -c /dev/null || mknod -m 666 /dev/null c 1 3
    test -c /dev/zero || mknod -m 666 /dev/zero c 1 5
    test -c /dev/ptmx || mknod -m 666 /dev/ptmx c 5 2
    test -c /dev/tty || mknod -m 666 /dev/tty c 5 0
    test -c /dev/random || mknod -m 444 /dev/random c 1 8
    test -c /dev/urandom || mknod -m 444 /dev/urandom c 1 9
}

export PREFIX=/after
export UPKG_ROOT=/
export UPKG_PKGSTORE=/upkgs

mkdir "${UPKG_PKGSTORE}"

upkg_simple_build1 flex-2.5.11
ln --verbose --symbolic "../../upkgs/flex-2.5.11/after/bin/flex" "/after/bin/"
ln --verbose --symbolic "../../upkgs/flex-2.5.11/after/bin/lex" "/after/bin/"

# Patch meslibc to support > 255 command line arguments
build mes-0.23 mes-libc-0.23.sh

build tcc-0.9.27 tcc-meslibc-rebuild.sh checksums/tcc-meslibc-rebuild

build musl-1.1.24 musl-1.1.24.sh checksums/pass1

# Rebuild tcc using musl
build tcc-0.9.27 tcc-musl-pass1.sh checksums/tcc-musl-pass1

# Rebuild musl using tcc-musl
build musl-1.1.24 musl-1.1.24.sh checksums/pass2

# Rebuild tcc-musl using new musl
DESTDIR="${UPKG_PKGSTORE}/tcc-0.9.27-pass2" build tcc-0.9.27 tcc-musl-pass2.sh checksums/tcc-musl-pass2
mv "/after/bin/tcc-musl" "/after/bin/tcc-musl.pass1"
ln --verbose --symbolic "../../upkgs/tcc-0.9.27-pass2/after/bin/tcc-musl" "/after/bin/"
ln --verbose --symbolic "../../upkgs/tcc-0.9.27-pass2/after/lib/libtcc1.a" "/after/lib/"

# Rebuild sed using musl
DESTDIR="${UPKG_PKGSTORE}/sed-4.0.9-pass2" build sed-4.0.9 sed-4.0.9.sh checksums/pass2
mv "/after/bin/sed" "/after/bin/sed.pass1"
ln --verbose --symbolic "../../upkgs/sed-4.0.9-pass2/after/bin/sed" "/after/bin/"

# Rebuild bzip2 using musl
DESTDIR="${UPKG_PKGSTORE}/bzip2-1.0.8-pass2" build bzip2-1.0.8 bzip2-1.0.8.sh checksums/bzip2-pass2
mv "/after/bin/bzip2" "/after/bin/bzip2.pass1"
mv "/after/bin/bunzip2" "/after/bin/bunzip2.pass1"
ln --verbose --symbolic "../../upkgs/bzip2-1.0.8-pass2/after/bin/bzip2" "/after/bin/"
ln --verbose --symbolic "../../upkgs/bzip2-1.0.8-pass2/after/bin/bunzip2" "/after/bin/"
ln --verbose --symbolic "../../upkgs/bzip2-1.0.8-pass2/after/bin/bzcat" "/after/bin/"

upkg_simple_build1 m4-1.4.7
ln --verbose --symbolic "../../upkgs/m4-1.4.7/after/bin/m4" "/after/bin/"

upkg_simple_build1 flex-2.6.4
rm "/after/bin/flex" "/after/bin/lex"
ln --verbose --symbolic "../../upkgs/flex-2.6.4/after/bin/flex" "/after/bin/"
ln --verbose --symbolic "../../upkgs/flex-2.6.4/after/bin/lex" "/after/bin/"

build bison-3.4.1 stage1.sh checksums/stage1
build bison-3.4.1 stage2.sh checksums/stage2
build bison-3.4.1 stage3.sh checksums/stage3

upkg_simple_build1 grep-2.4
ln --verbose --symbolic "../../upkgs/grep-2.4/after/bin/grep" "/after/bin/"
ln --verbose --symbolic "../../upkgs/grep-2.4/after/bin/egrep" "/after/bin/"
ln --verbose --symbolic "../../upkgs/grep-2.4/after/bin/fgrep" "/after/bin/"

upkg_simple_build1 diffutils-2.7
ln --verbose --symbolic "../../upkgs/diffutils-2.7/after/bin/cmp" "/after/bin/"
ln --verbose --symbolic "../../upkgs/diffutils-2.7/after/bin/diff" "/after/bin/"

# Rebuild coreutils using musl
# Additionally builds chroot
build coreutils-5.0 coreutils-5.0.sh checksums/pass2

# Build only date, mktemp and sha256sum
build coreutils-6.10

upkg_simple_build1 gawk-3.0.4
ln --verbose --symbolic "../../upkgs/gawk-3.0.4/after/bin/gawk" "/after/bin/"
ln --verbose --symbolic "../../upkgs/gawk-3.0.4/after/bin/awk" "/after/bin/"
ln --verbose --symbolic "../../upkgs/gawk-3.0.4/after/share/awk" "/after/share/"

upkg_simple_build1 perl-5.000
ln --verbose --symbolic "../../upkgs/perl-5.000/after/bin/perl" "/after/bin/"

upkg_simple_build1 perl-5.003
rm "/after/bin/perl" # remove perl-5.000
install --directory "/after/lib/perl5"
ln --verbose --symbolic "../../upkgs/perl-5.003/after/bin/perl" "/after/bin/"
ln --verbose --symbolic "../../../upkgs/perl-5.003/after/lib/perl5/5.003" "/after/lib/perl5/" # TODO: does stow recognise this ?

upkg_simple_build1 perl5.004_05
# remove perl-5.003
rm "/after/bin/perl"
rm "/after/lib/perl5/5.003"
# link perl5.004_05
ln --verbose --symbolic "../../upkgs/perl5.004_05/after/bin/perl" "/after/bin/"
ln --verbose --symbolic "../../../upkgs/perl5.004_05/after/lib/perl5/5.004_05" "/after/lib/perl5/"

upkg_simple_build1 perl5.005_03
# remove perl5.004_05
rm "/after/bin/perl"
rm "/after/lib/perl5/5.004_05"
# link perl5.005_03
ln --verbose --symbolic "../../upkgs/perl5.005_03/after/bin/perl" "/after/bin/"
ln --verbose --symbolic "../../../upkgs/perl5.005_03/after/lib/perl5/5.005_03" "/after/lib/perl5/"

upkg_simple_build1 perl-5.6.2
# remove perl5.005_03
rm "/after/bin/perl"
rm "/after/lib/perl5/5.005_03"
# link perl-5.6.2
ln --verbose --symbolic "../../upkgs/perl-5.6.2/after/bin/perl" "/after/bin/"
ln --verbose --symbolic "../../../upkgs/perl-5.6.2/after/lib/perl5/5.6.2" "/after/lib/perl5/" # FIXME: stow will be copied into the perl directory

# Stow is used to symlink pseudo packages from ${UPKG_PKGSTORE}/$pkgname/$pkgversion into /after
# It could be replaced by hand crafted shell script, but that would likely be buggier and isn't
# as easy as just building stow for now
build stow-2.2.2

populate_device_nodes

upkg_simple_build1 autoconf-2.52 stage1.sh
upkg_link_pkg "autoconf-2.52-stage1"

upkg_simple_build1 automake-1.6.3 stage1.sh
upkg_link_pkg "automake-1.6.3-stage1"

upkg_simple_build1 automake-1.6.3 stage2.sh
upkg_unlink_pkg "automake-1.6.3-stage1"
upkg_link_pkg "automake-1.6.3-stage2"

upkg_simple_build1 automake-1.6.3 stage3.sh
upkg_unlink_pkg "automake-1.6.3-stage2"
upkg_link_pkg "automake-1.6.3-stage3"

upkg_simple_build1 automake-1.4-p6
upkg_link_pkg "automake-1.4-p6"

upkg_simple_build1 autoconf-2.52 stage2.sh
upkg_unlink_pkg "autoconf-2.52-stage1"
upkg_link_pkg "autoconf-2.52-stage2"

upkg_simple_build1 autoconf-2.13
upkg_link_pkg "autoconf-2.13"

upkg_simple_build1 autoconf-2.12
upkg_link_pkg "autoconf-2.12"

upkg_simple_build1 libtool-1.4
upkg_link_pkg "libtool-1.4"

upkg_simple_build1 binutils-2.14
upkg_link_pkg "binutils-2.14"

# Build musl with fewer patches
DESTDIR="${UPKG_PKGSTORE}/musl-1.1.24-patches-pass3" build musl-1.1.24 binutils-rebuild.sh checksums/pass3 patches-pass3
for file in crt1.o crti.o crtn.o libc.a libcrypt.a libdl.a libm.a libpthread.a libresolv.a librt.a libutil.a libxnet.a rcrt1.o Scrt1.o; do
    mv "/after/lib/musl/$file" "/after/lib/musl/$file.old"
done
upkg_link_pkg "musl-1.1.24-patches-pass3"
populate_device_nodes

## Rebuild tcc-musl using new musl
DESTDIR="${UPKG_PKGSTORE}/tcc-0.9.27-pass3" build tcc-0.9.27 tcc-musl-pass3.sh checksums/tcc-musl-pass3 patches-musl-pass3
upkg_unlink_pkg "tcc-0.9.27-pass2"
upkg_link_pkg "tcc-0.9.27-pass3"

upkg_simple_build1 autoconf-2.53 stage1.sh
upkg_link_pkg "autoconf-2.53-stage1"

upkg_simple_build1 autoconf-2.53 stage2.sh
upkg_unlink_pkg "autoconf-2.53-stage1"
upkg_link_pkg "autoconf-2.53-stage2"

upkg_simple_build1 automake-1.7 stage1.sh
upkg_link_pkg "automake-1.7-stage1"

upkg_simple_build1 autoconf-2.54 stage1.sh
upkg_link_pkg "autoconf-2.54-stage1"

upkg_simple_build1 autoconf-2.54 stage2.sh
upkg_unlink_pkg "autoconf-2.54-stage1"
upkg_link_pkg "autoconf-2.54-stage2"

upkg_simple_build1 automake-1.7 stage2.sh
upkg_unlink_pkg "automake-1.7-stage1"
upkg_link_pkg "automake-1.7-stage2"

upkg_simple_build1 autoconf-2.55
upkg_link_pkg "autoconf-2.55"

upkg_simple_build1 automake-1.7.8
upkg_unlink_pkg "automake-1.7-stage2"
upkg_link_pkg "automake-1.7.8"

upkg_simple_build1 autoconf-2.57
upkg_link_pkg "autoconf-2.57"

upkg_simple_build1 autoconf-2.59
upkg_link_pkg "autoconf-2.59"

upkg_simple_build1 automake-1.8.5
upkg_link_pkg "automake-1.8.5"

upkg_simple_build1 help2man-1.36.4
upkg_link_pkg "help2man-1.36.4"

upkg_simple_build1 autoconf-2.61 stage1.sh
upkg_link_pkg "autoconf-2.61-stage1"

upkg_simple_build1 autoconf-2.61 stage2.sh
upkg_unlink_pkg "autoconf-2.61-stage1"
upkg_link_pkg "autoconf-2.61-stage2"

upkg_simple_build1 automake-1.9.6 stage1.sh
upkg_link_pkg "automake-1.9.6-stage1"

upkg_simple_build1 automake-1.9.6 stage2.sh
upkg_unlink_pkg "automake-1.9.6-stage1"
upkg_link_pkg "automake-1.9.6-stage2"

upkg_simple_build1 findutils-4.2.33
upkg_link_pkg "findutils-4.2.33"

upkg_simple_build1 libtool-2.2.4
upkg_unlink_pkg "libtool-1.4"
upkg_link_pkg "libtool-2.2.4"

upkg_simple_build1 automake-1.10.3
upkg_link_pkg "automake-1.10.3"

upkg_simple_build1 autoconf-2.65
upkg_link_pkg "autoconf-2.65"

upkg_simple_build1 gcc-4.0.4 pass1.sh checksums/pass1
upkg_link_pkg "gcc-4.0.4-pass1"

upkg_simple_build1 musl-1.2.2
upkg_unlink_pkg "musl-1.1.24-patches-pass3"
upkg_link_pkg "musl-1.2.2"

upkg_simple_build1 gcc-4.0.4 pass2.sh checksums/pass2
upkg_unlink_pkg "gcc-4.0.4-pass1"
upkg_link_pkg "gcc-4.0.4-pass1"

upkg_simple_build1 bash-5.1
mv "/after/bin/bash" "/after/bin/bash.old"
upkg_link_pkg "bash-5.1"

exec env -i PATH=/after/bin PREFIX=/after UPKG_PKGSTORE="${UPKG_PKGSTORE}" bash run2.sh
