# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm doc/standards.info
    AUTOMAKE="automake-1.10" \
        ACLOCAL="aclocal-1.10" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        autoreconf-2.61 -f

    # Install autoconf data files into versioned directory
    for file in */*/Makefile.in */Makefile.in Makefile.in; do
        sed -i '/^pkgdatadir/s:$:-@VERSION@:' $file
    done
}

src_configure() {
    AUTOMAKE="automake-1.10" \
        ACLOCAL="aclocal-1.10" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        ./configure --prefix="${PREFIX}" --program-suffix=-2.65
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
