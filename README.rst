Nim-KDialog
===========

.. image:: kdialog.png


Why not a proper GUI Toolkit?
-----------------------------

- This is oriented to newbiews, teaching programming classes, hackattons, etc.
- KISS principle, easy to use, simple API, Nim need GUI, this is **~32Kb compiled**.
- KDEs Documentation works for this module since its 1:1 clone. Has builtin Examples.
- The idea is to help people move from procedural Bash to Nim with GUI.

Return Types
------------

All Dialogs are pre-parsed into proper Nim Types!.

- The Color Picker returns a ``Color`` type from ``colors`` module.
- The Date Picker returns a ``DateTime`` type from ``times`` module.
- Boolean, integer or string are returned when fits.

Requisites
----------

- KDialog and Qt5.
- Nim and Nimble.

Install
-------

- ``nimble install https://github.com/juancarlospaco/nim-kdialog.git``
