# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.59" autoreconf-2.59 -f
}

src_configure() {
    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.59" ./configure --prefix="${PREFIX}" --program-suffix="-1.8" --infodir="${PREFIX}/info/automake-1.8"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
