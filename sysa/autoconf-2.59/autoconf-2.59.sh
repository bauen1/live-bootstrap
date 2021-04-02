# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    rm bin/autoconf.in
    rm doc/standards.info

    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.57" autoreconf-2.57 -f

    # Install autoconf data files into versioned directory
    for file in */*/Makefile.in */Makefile.in Makefile.in; do
        sed -i '/^pkgdatadir/s:$:-@VERSION@:' $file
    done
}

src_configure() {
    AUTOMAKE="automake-1.7" ACLOCAL="aclocal-1.7" AUTOCONF="autoconf-2.57" ./configure --prefix="${PREFIX}" --program-suffix=-2.59 --infodir="${PREFIX}/info/autoconf-2.59"
}

src_compile() {
    # Workaround for racy make dependencies
    make -C bin autom4te
    make -C lib
    make MAKEINFO=true
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
