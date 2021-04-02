# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    sed -i 's/1.8a/1.8.5/; s/ filename-length-max=99//' configure.ac
    AUTOMAKE="automake-1.8" ACLOCAL="aclocal-1.8" AUTOCONF="autoconf-2.61" AUTOM4TE="autom4te-2.61" autoreconf-2.61 -f
}

src_configure() {
    AUTOMAKE="automake-1.8" ACLOCAL="aclocal-1.8" AUTOCONF="autoconf-2.61" AUTOM4TE="autom4te-2.61" ./configure --prefix="${PREFIX}" --program-suffix="-1.9" --infodir="${PREFIX}/info/automake-1.9"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
