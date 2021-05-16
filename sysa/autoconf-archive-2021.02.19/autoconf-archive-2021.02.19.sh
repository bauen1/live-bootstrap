# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    AUTOMAKE=automake-1.15 ACLOCAL=aclocal-1.15 AUTOM4TE=autom4te-2.69 autoreconf-2.69 -f -i
}

src_configure() {
    ./configure --prefix="${PREFIX}" --program-suffix="-2021-02.19"
}

src_compile() {
    make MAKEINFO=true DESTDIR="${DESTDIR}"
}

src_install() {
    make MAKEINFO=true DESTDIR="${DESTDIR}" install
}
