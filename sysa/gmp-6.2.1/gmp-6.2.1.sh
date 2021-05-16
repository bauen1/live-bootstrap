# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default

    # Remove bison and flex generated files
    rm demos/calc/calc.{c,h} demos/calc/calclex.c

    AUTOMAKE=automake-1.15 ACLOCAL=aclocal-1.15 AUTOM4TE=autom4te-2.65 autoreconf-2.65 -f -i

    # Pre-build texinfo files
    find . -name '*.info*' -delete
}

src_configure() {
    ./configure \
	--prefix="${PREFIX}" \
	--build=i386-unknown-linux-gnu \
	--host=i386-unknown-linux-gnu \
	--target=i386-unknown-linux-gnu \
	--libdir="${PREFIX}/lib/musl"
}

src_compile() {
    make MAKEINFO=true DESTDIR="${DESTDIR}"
}

src_install() {
    make MAKEINFO=true DESTDIR="${DESTDIR}" install
}
