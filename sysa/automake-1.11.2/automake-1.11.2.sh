# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default

    AUTOMAKE="automake-1.10" \
        ACLOCAL="aclocal-1.10" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.65" \
        AUTOM4TE="autom4te-2.65" \
    ./bootstrap
}

src_configure() {
    AUTOMAKE="automake-1.10" \
        ACLOCAL="aclocal-1.10" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.65" \
        AUTOM4TE="autom4te-2.65" \
    ./configure --prefix="${PREFIX}" --program-suffix="-1.11" --infodir="${PREFIX}/infodir/automake-1.11" --docdir="${PREFIX}/share/doc/automake-1.11"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
