# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm doc/standards.info
    AUTOMAKE="automake-1.11" \
        ACLOCAL="aclocal-1.11" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.65" \
        AUTOM4TE="autom4te-2.65" \
    autoreconf-2.65 -f

    # Install autoconf data files into versioned directory
    for file in */*/Makefile.in */Makefile.in Makefile.in; do
        sed -i '/^pkgdatadir/s:$:-@VERSION@:' $file
    done
}

src_configure() {
    AUTOMAKE="automake-1.11" \
        ACLOCAL="aclocal-1.11" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.65" \
        AUTOM4TE="autom4te-2.65" \
    ./configure --prefix="${PREFIX}" --program-suffix=-2.69
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
