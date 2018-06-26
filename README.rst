Nim-KDialog
===========

..image:: kdialog.png


Why not X?
----------

Based on http://www.linux-magazine.com/Issues/2009/99/Zenity-and-KDialog
KDialog has more features and its ported to Qt5. UX is overall superior.
KDE / Kdialog runs on MS Windows, while Gnome does not.

Why not a proper GUI Toolkit?
-----------------------------

- This is oriented to newbiews, teaching programming classes, hackattons, etc.
- KISS principle, easy to use, simple API, Nim need GUI, this is ~32Kb compiled.
- KDEs Documentation works for this module since its 1:1 clone. Qt5 is cute.
- The idea is to help people move from procedural Bash to Nim with GUI.

Requisites
----------

- KDialog and Qt5.
- Nim and Nimble.

Install
-------

- ``nimble install kdialog``
