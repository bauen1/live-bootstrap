# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm doc/standards.info
    sed -i -e '/AC_PROG_GREP/d' -e '/AC_PROG_SED/d' configure.ac
    AUTOMAKE="automake-1.8" ACLOCAL="aclocal-1.8" AUTOCONF="autoconf-2.59" AUTOM4TE="autom4te-2.59" autoreconf-2.59 -f

    # Install autoconf data files into versioned directory
    for file in */*/Makefile.in */Makefile.in Makefile.in; do
        sed -i '/^pkgdatadir/s:$:-@VERSION@:' $file
    done
}

src_configure() {
    AUTOMAKE="automake-1.8" \
        ACLOCAL="aclocal-1.8" \
        AUTOCONF="autoconf-2.59" \
        AUTOM4TE="autom4te-2.59" ./configure --prefix="${PREFIX}" --program-suffix=-2.61 --infodir="${PREFIX}/info/autoconf-2.61"
}

src_compile() {
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
