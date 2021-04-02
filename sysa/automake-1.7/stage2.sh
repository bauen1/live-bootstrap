# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm configure Makefile.in */Makefile.in */*/Makefile.in aclocal.m4 automake.info*

    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.54" autoreconf-2.54
}

src_configure() {
    ACLOCAL="aclocal-1.7" \
        AUTOCONF="autoconf-2.54" \
        AUTOMAKE="automake-1.7" \
        AUTOHEADER="autoheader-2.54" \
        ./configure \
        --prefix="${PREFIX}" \
        --program-suffix="-1.7" \
        --infodir="${PREFIX}/info/automake-1.7"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
