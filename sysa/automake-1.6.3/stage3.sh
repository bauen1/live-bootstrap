# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm configure Makefile.in */Makefile.in */*/Makefile.in aclocal.m4 automake.info*
    aclocal-1.6
    autoconf-2.52
    automake-1.6
}

src_configure() {
    ./configure --prefix="${PREFIX}" --program-suffix="-1.6" --infodir="${PREFIX}/info/automake-1.6.3-stage3"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    # cleanup old manual install
    #rm "${PREFIX}"/bin/automake-1.6
    #rm "${PREFIX}"/bin/aclocal-1.6
    #rm -rf "${PREFIX}"/share/automake-1.6
    #rm -rf "${PREFIX}"/share/aclocal-1.6

    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
