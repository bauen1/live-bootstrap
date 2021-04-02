# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default

    # thank you autohell tools for nothing
    sed -i 's|autoreconf -vfi|$(AUTORECONF)|' doc/Makefile.am

    AUTOMAKE="automake-1.9" \
        ACLOCAL="aclocal-1.9" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        ./bootstrap
}

src_configure() {
    AUTOMAKE="automake-1.9" \
        ACLOCAL="aclocal-1.9" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        ./configure CC=tcc --prefix="${PREFIX}" --program-suffix="-1.10" --infodir="${PREFIX}/infodir/automake-1.10"
}

src_compile() {
    # also supply autohell env vars for the AUTORECONF invokation in doc/Makefile
    AUTOMAKE="automake-1.9" \
        ACLOCAL="aclocal-1.9" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.61" \
        AUTOM4TE="autom4te-2.61" \
        make MAKEINFO=true CC=tcc
}

src_install() {
    make install MAKEINFO=true DESTDIR="${DESTDIR}"
}
