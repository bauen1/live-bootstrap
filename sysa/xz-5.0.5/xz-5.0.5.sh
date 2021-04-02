# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default

    AUTOMAKE=automake-1.10 ACLOCAL=aclocal-1.10 AUTOM4TE=autom4te-2.65 autoreconf-2.65 -f
}

src_configure() {
    ./configure \
        --prefix="${PREFIX}" \
        --disable-shared \
        --target=i386-unknown-linux-gnu \
        --host=i386-unknown-linux-gnu \
        --build=i386-unknown-linux-gnu \
        --libdir="${PREFIX}/lib/musl"
}
