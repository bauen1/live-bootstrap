#!/bin/bash

# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
# SPDX-FileCopyrightText: 2021 fosslinux <fosslinux@aussies.space>
# SPDX-FileCopyrightText: 2021 Paul Dersey <pdersey@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e
set -x

. helpers.sh

DESTDIR="${UPKG_PKGSTORE}/xz-5.0.5" build xz-5.0.5
upkg_link_pkg "xz-5.0.5"

DESTDIR="${UPKG_PKGSTORE}/automake-1.11.2" build automake-1.11.2
upkg_link_pkg "automake-1.11.2"

DESTDIR="${UPKG_PKGSTORE}/autoconf-2.69" build autoconf-2.69
upkg_link_pkg "autoconf-2.69"

DESTDIR="${UPKG_PKGSTORE}/automake-1.15.1" build automake-1.15.1
upkg_link_pkg "automake-1.15.1"

DESTDIR="${UPKG_PKGSTORE}/tar-1.34" build tar-1.34
upkg_link_pkg "tar-1.34"

DESTDIR="${UPKG_PKGSTORE}/gmp-6.2.1" build gmp-6.2.1
upkg_link_pkg "gmp-6.2.1"

DESTDIR="${UPKG_PKGSTORE}/autoconf-archive-2021.02.19" build autoconf-archive-2021.02.19
upkg_link_pkg "autoconf-archive-2021.02.19"

DESTDIR="${UPKG_PKGSTORE}/mpfr-4.1.0" build mpfr-4.1.0
upkg_link_pkg "mpfr-4.1.0"

DESTDIR="${UPKG_PKGSTORE}/mpc-1.2.1" build mpc-1.2.1
upkg_link_pkg "mpc-1.2.1"

echo "Bootstrapping completed."

exec env - PATH=/after/bin PS1="\w # " bash -i
