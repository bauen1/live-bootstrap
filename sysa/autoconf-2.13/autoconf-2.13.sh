# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm configure standards.info autoconf.info
    touch autoconf.info
    autoconf-2.52

    sed -i '/^acdatadir/s:$:-2.13:' Makefile.in
}

src_configure() {
    ./configure --prefix="${PREFIX}" --program-suffix=-2.13 --infodir="${PREFIX}/info/autoconf-2.13"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    # This Makefile does *not* support DESTDIR so we need to trick it into doing the right
    # thing
    make install MAKEINFO=true prefix="${DESTDIR}${PREFIX}"
}
