tzbar
=====

A hacky "Desk Band" (or, "taskbar toolbar") that shows times in different timezones, for Windows.

![Screenshot](/screenshot.png?raw=true)

The code was written in an "as quick as possible" way so the code quality is bad:

- No proper naming
- No proper architecture
- Not implementing the "Desk Band" via the formal COM+ interface
- Requires the "Touch Keyboard" icon to be visible, to calculate the position
- Requires certain color themes to look good
- Timezones are hardcoded

License
-------
GPLv2

Third party
-----------
* PascalTZ: https://github.com/dezlov/PascalTZ (LGPL)
* Gnome Icons: https://download.gnome.org/teams/art.gnome.org/themes/icon/ (GPL)
* Timezone Database: https://www.iana.org/time-zones
