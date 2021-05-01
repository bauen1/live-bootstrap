# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default

    . ../../import-gnulib.sh

    # We don't have autopoint from gettext yet
    AUTOMAKE="automake-1.15" \
        ACLOCAL="aclocal-1.15" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.69" \
        AUTOM4TE="autom4te-2.69" \
        AUTOPOINT=true \
        autoreconf-2.61 -fi

    # Remove bison pregenerated file
    rm gnu/parse-datetime.c
}

src_configure() {
    AUTOMAKE="automake-1.15" \
        ACLOCAL="aclocal-1.15" \
        AUTORECONF="autoreconf-2.61" \
        AUTOCONF="autoconf-2.69" \
        AUTOM4TE="autom4te-2.69" \
        FORCE_UNSAFE_CONFIGURE=1 \
        ./configure \
        --prefix="${PREFIX}" \
        --disable-nls \
        --target=i386-unknown-linux-gnu \
        --host=i386-unknown-linux-gnu \
        --build=i386-unknown-linux-gnu
}

src_compile() {
    make PREFIX="${PREFIX}" MAKEINFO="true"
}

src_install() {
    make install PREFIX="${PREFIX}" MAKEINFO="true" DESTDIR="${DESTDIR}"
}
