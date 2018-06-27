## Nim-KDialog
## ===========
##
## Why not X?
## ----------
##
## Based on http://www.linux-magazine.com/Issues/2009/99/Zenity-and-KDialog
## KDialog has more features and its ported to Qt5. UX is overall superior.
## KDE / Kdialog runs on MS Windows, while Gnome does not.
##
## Why not a proper GUI Toolkit?
## -----------------------------
##
## - This is oriented to newbiews, teaching programming classes, hackattons, etc.
## - KISS principle, easy to use, simple API, Nim need GUI, this is ~32Kb compiled.
## - KDEs Documentation works for this module since its 1:1 clone. Qt5 is cute.
## - The idea is to help people move from procedural Bash to Nim with GUI.
##
## Requisites
## ----------
##
## - KDialog and Qt5.
## - Nim and Nimble.
##
# Based on examples from:
# https://techbase.kde.org/Development/Tutorials/Shell_Scripting_with_KDE_Dialogs
# https://mostlylinux.wordpress.com/bashscripting/kdialog

import os, osproc, strformat, strutils, times


const
  version* = staticExec("kdialog --version") ## KDialog version that this Nim module was using when compiled.
  authors* = staticExec("kdialog --author")  ## KDialog authors.
var default_title* = "Nim KDialog"           ## Default Title string for the GUI windows.
when defined(posix):
  const stderrs* = " 2> /dev/null"           ## Unixes can redirect STDERR to /dev/null
else:
  const stderrs* = ""                        # Windows?.


proc yesno*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --yesno '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc yesnocancel*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --yesnocancel '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc warningyesno*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --warningyesno '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc warningcontinuecancel*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --warningcontinuecancel '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc warningyesnocancel*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --warningyesnocancel '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc sorry*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --sorry '{text_or_html}'")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc detailedsorry*(text_or_html: string, details: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --detailedsorry '{text_or_html}' '{details}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc error*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --error '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc detailederror*(text_or_html: string, details: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --detailederror '{text_or_html}' '{details}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc msgbox*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --msgbox '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc inputbox*(text_or_html: string, init: string = "", title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --inputbox '{text_or_html}' '{init}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc password*(text_or_html: string, init: string = "", title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --password '{text_or_html}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc newpassword*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --newpassword '{text_or_html}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc textbox*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --textbox '{text_or_html}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc textinputbox*(text_or_html: string, init: string = "", stderr2output: bool= false, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --textinputbox '{text_or_html}' '{init}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc passivepopup*(text_or_html: string, timeout: int8, title: string= default_title, stderrs: string= stderrs): int =
  execCmdEx(fmt"kdialog --title '{title}' --passivepopup '{text_or_html}' {timeout}{stderrs}").exitCode

proc getopenfilename*(startDir: string= getCurrentDir(), filter: string= "*.*", multiple: bool=false, title: string= default_title, stderrs: string= stderrs): tuple =
  let multi = if multiple: "--multiple" else: ""
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getopenfilename '{startDir}' '{filter}' {multi}{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getsavefilename*(startDir: string= getCurrentDir(), filter: string= "*.*", title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getsavefilename '{startDir}' '{filter}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getexistingdirectory*(startDir: string= getCurrentDir(), title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getexistingdirectory '{startDir}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getopenurl*(startDir: string= getCurrentDir(), filter: string= "*.*", multiple: bool= false, title: string= default_title, stderrs: string= stderrs): tuple =
  let multi = if multiple: "--multiple" else: ""
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getopenurl '{startDir}' '{filter}' {multi}{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getsaveurl*(startDir: string= getCurrentDir(), filter: string= "*.*", title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getsaveurl '{startDir}' '{filter}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc geticon*(title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --geticon{stderrs}")
  (output: comand.output.strip, exitCode: comand.exitCode)

proc getcolor*(title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getcolor{stderrs}")
  (output: comand.output.strip, exitCode: comand.exitCode)

proc slider*(text_or_html: string, minimum: int, maximum: int, steps: int8, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --slider '{text_or_html}' {minimum} {maximum} {steps}{stderrs}")
  (output: comand.output.strip.parseInt, exitCode: comand.exitCode)

proc calendar*(text_or_html: string, title: string= default_title, stderrs: string= stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --calendar '{text_or_html}'{stderrs}")
  (output: parse(comand.output.strip, "ddd MMM d yyyy"), exitCode: comand.exitCode)


################################################################################
# TODO: These ones needs more work to allow flexible parameters, they are WIP.
#
# proc checklist*(text_or_html: string, separate_output: bool=false, title: string= default_title): tuple =
#   let sepa = if separate_output: "--separate-output" else: ""
#   execCmdEx(fmt"kdialog --title '{title}' --checklist '{text_or_html}' {sepa}")
#
# proc combobox*(text_or_html: string, title: string= default_title): tuple =
#   execCmdEx(fmt"kdialog --title '{title}' --combobox '{text_or_html}'")
#
# proc menu*(text_or_html: string, title: string= default_title): tuple =
#   execCmdEx(fmt"kdialog --title '{title}' --menu '{text_or_html}'")
#
# proc progressbar*(text_or_html: string, value: int8, title: string= default_title): tuple =
#   execCmdEx(fmt"kdialog --title '{title}' --progressbar '{text_or_html}' {value}")
#
# proc radiolist*(text_or_html: string, title: string= default_title): tuple =
#   execCmdEx(fmt"kdialog --title '{title}' --radiolist '{text_or_html}'")


when not defined(release):
  if is_main_module:
    echo version, authors, default_title
    echo yesno "Love Nim?"
    echo yesnocancel "Is Nim Awesome?"
    echo warningyesno "Update Nimble index!"
    echo warningcontinuecancel "Nimble is Up-to-date!"
    echo warningyesnocancel "Contribute to Nim today?"
    echo sorry "We got no Interfaces..."
    echo error "Your Nim does not compile!"
    echo newpassword "Enter some Password here"
    echo getcolor "Which is the best color?"
    echo calendar "When is the next eclipse?"
    echo msgbox "<h1>Nim KDialog!</h1><hr>You can use:<ul><li>HTML (no CSS, no JS)</li><li>Images (full path)</li><li>Custom icons (registered)</li></ul>"
    echo getopenfilename()
    echo getsavefilename()
    echo getexistingdirectory()
    echo getopenurl()
    echo getsaveurl()
    echo geticon()
