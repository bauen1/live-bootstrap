# SPDX-FileCopyrightText: 2021 Jonathan Hettwer (bauen1) <j2468h@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

src_prepare() {
    default_src_prepare

    # Remove pregenerated files and tests, as they won't work anyway.
    rm -r configure doc/stow.8 Makefile.in automake t

    # Patch out incompatibilities with our version of perl:

    # And I don't know what the :+ in the option string means, but things
    # still work
    sed -i -e 's/verbose|v:\+/verbose|v/' bin/stow.in

    # longmess will only be used incase of an internal error
    sed -i -e 's/confess longmess/confess/' lib/Stow.pm.in
}

src_configure() {
    echo "Skipping configure"
}

src_compile() {
    # taken from stows Makefile
    sed -e 's|[@]PERL[@]|/after/bin/perl|g' \
        -e 's|[@]VERSION[@]|2.3.1-bootstrap|g' \
        -e 's|[@]USE_LIB_PMDIR[@]|# USE_LIB_PMDIR not necessary|g' < bin/stow.in > bin/stow
    sed -e 's|[@]PERL[@]|/after/bin/perl|g' \
        -e 's|[@]VERSION[@]|2.3.1-bootstrap|g' \
        -e 's|[@]USE_LIB_PMDIR[@]|# USE_LIB_PMDIR not necessary|g' < bin/chkstow.in > bin/chkstow
    sed -e 's|[@]PERL[@]|/after/bin/perl|g' \
        -e 's|[@]VERSION[@]|2.3.1-bootstrap|g' \
        -e 's|[@]USE_LIB_PMDIR[@]|# USE_LIB_PMDIR not necessary|g' < lib/Stow.pm.in > lib/Stow.pm
    sed -e 's|[@]PERL[@]|/after/bin/perl|g' \
        -e 's|[@]VERSION[@]|2.3.1-bootstrap|g' \
        -e 's|[@]USE_LIB_PMDIR[@]|# USE_LIB_PMDIR not necessary|g' < lib/Stow/Util.pm.in > lib/Stow/Util.pm
}

src_install() {
    install --directory "${DESTDIR}${PREFIX}"/bin
    install --mode=0755 bin/stow "${DESTDIR}${PREFIX}"/bin/stow
    install --mode=0755 bin/chkstow "${DESTDIR}${PREFIX}"/bin/chkstow
    install --mode=0644 lib/Stow.pm "${DESTDIR}${PREFIX}"/lib/perl5/5.6.2/
    install --mode=0755 --directory "${DESTDIR}${PREFIX}"/lib/perl5/5.6.2/Stow
    install --mode=0644 lib/Stow/Util.pm "${DESTDIR}${PREFIX}"/lib/perl5/5.6.2/Stow/
}
