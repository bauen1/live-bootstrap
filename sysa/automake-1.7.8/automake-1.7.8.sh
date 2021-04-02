# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm configure Makefile.in */Makefile.in */*/Makefile.in aclocal.m4 automake.info*

    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.55" autoreconf-2.55
}

src_configure() {
    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.55" ./configure --prefix="${PREFIX}" --program-suffix="-1.7" --infodir="${PREFIX}/info/automake-1.7.8"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
