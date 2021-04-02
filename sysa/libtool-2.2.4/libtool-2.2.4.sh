# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    AUTOMAKE="automake-1.9" \
        ACLOCAL="aclocal-1.9" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        ./bootstrap
}

src_configure() {
    AUTOMAKE="automake-1.9" \
        ACLOCAL="aclocal-1.9" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        CC=tcc \
        ./configure \
        --prefix="${PREFIX}" \
        --libdir="${PREFIX}/lib/musl" \
        --disable-shared \
        --host=i386-unknown-linux \
        --target=i386-unknown-linux \
        --build=i386-unknown-linux
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
