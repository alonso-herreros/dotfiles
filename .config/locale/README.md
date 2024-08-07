# Custom i18n locale

Getting this to work may require tweaking system files

## Getting files in place

Custom locale files can be added to the `/usr/share/i18n/locales` folder.

## Making the config usable

### Arch

These files must be enabled by editing `/etc/locale.gen` before they can be even selected.
Add the name of the files that are to be enabled in the the visible format. As of writing this,
that's simply a line with `<localename>.UTF-8 UTF-8`.

## Selecting the config

Locale files can be loaded partially by setting only the relevant `LC_*` variable to point to the
desired locale. The list of current `LC_*` variables can be obtained by using `locale`. More info
on the meanings at [locale(7)](https://man.archlinux.org/man/locale.7).

The `LC_*` variables, along with `LANG` and `LANGUAGE` can be set system-wide at
`/etc/locale.conf`, and can be overriden per-user at `$XDG_CONFIG_HOME/locale.conf`.

## Customizing more stuff

Locale file specifications can be found at [locale(5)](https://man.archlinux.org/man/locale.5).

