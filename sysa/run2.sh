#!/bin/bash

# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
# SPDX-FileCopyrightText: 2021 fosslinux <fosslinux@aussies.space>
# SPDX-FileCopyrightText: 2021 Paul Dersey <pdersey@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e
set -x

. helpers.sh

upkg_simple_build1 xz-5.0.5
upkg_link_pkg "xz-5.0.5"

upkg_simple_build1 automake-1.11.2
upkg_link_pkg "automake-1.11.2"

upkg_simple_build1 autoconf-2.69
upkg_link_pkg "autoconf-2.69"

upkg_simple_build1 automake-1.15.1
upkg_link_pkg "automake-1.15.1"

upkg_simple_build1 tar-1.34
mv "/after/bin/tar" "/after/bin/tar.old"
upkg_link_pkg "tar-1.34"

upkg_simple_build1 gmp-6.2.1
upkg_link_pkg "gmp-6.2.1"

upkg_simple_build1 autoconf-archive-2021.02.19
upkg_link_pkg "autoconf-archive-2021.02.19"

upkg_simple_build1 mpfr-4.1.0
upkg_link_pkg "mpfr-4.1.0"

upkg_simple_build1 mpc-1.2.1
upkg_link_pkg "mpc-1.2.1"

echo "Bootstrapping completed."

exec env - PATH=/after/bin PS1="\w # " bash -i
