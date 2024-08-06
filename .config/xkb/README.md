# XKB custom keyboard layout

Getting this to work may be kind of tricky.

## Getting the files in place

First, we'll have to get the layout information somewhere the system can recognize. All work
will be done in here: `/usr/share/X11/xkb/`. The following table describes the files that can
be copied as-is into their locations (or symlinked as long as the permissions are right).

| File             | Where it goes                     |
| ---------------- | --------------------------------- |
| ./symbols/custom | /usr/share/X11/xkb/symbols/custom |

## Making the config usable

Even though the files might be where they need to be, they still need to be indexed so they can
be loaded properly. The main files describing this behavior are actually `rules/evdev` and
`rules/base`. The last time I set this up, it was only `rules/evdev`. Specifically, these files
contain specific information about what the different settings mean. This is, when you choose a
layout, model, or option, *where to find the configuration*. The format can be observed in the
file: `<config id> = +<filename>(<section>)`.

There are other files with similar information in the `rules` directory, such as `base.lst`.
These files serve mostly to provide info about what settings are available and valid, but they
are were not technically needed in my experience. In my experiments, `base.lst` and `evdev.lst`
were identical. The same was the case for `base.xml` and `evdev.xml`, so when changing any of
those files, the other was replaced by a copy.

### Custom symbol options

Options come in a variety of flavors, and not all of them are the same. In order to get keys to
do stuff, the options will have to be listed under the `! option = symbols` section. Trying to
place these options at the end of the file will result in unwanted behavior.

## Customizing more stuff

### 'Symbols' files

A list of valid character names can be found in `/usr/include/X11/keysymdef.h`

