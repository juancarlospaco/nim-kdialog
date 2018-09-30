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

import os, osproc, strformat, strutils, times, colors

const
  version* = staticExec("kdialog --version") ## KDialog version that this Nim module was using when compiled.
  authors* = staticExec("kdialog --author")  ## KDialog authors.
var default_title* = "Nim KDialog"           ## Default Title string for the GUI windows.
when defined(posix):
  const stderrs* = " 2> /dev/null"           ## Unixes can redirect STDERR to /dev/null
else:
  const stderrs* = ""                        # Windows?.

template kdialogizer(widget, text_or_html, title: string): untyped =
  let
    titleq = quoteShell(title.strip)
    textoq = quoteShell(text_or_html.strip)
    comand = execCmdEx("kdialog --title " & titleq & widget & textoq & stderrs)
  (output: comand.exitCode == 0, exitCode: comand.exitCode.int8)

proc yesno*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --yesno ", text_or_html, title)

proc yesnocancel*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --yesnocancel ", text_or_html, title)

proc warningyesno*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --warningyesno ", text_or_html, title)

proc warningcontinuecancel*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --warningcontinuecancel ", text_or_html, title)

proc warningyesnocancel*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --warningyesnocancel ", text_or_html, title)

proc sorry*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --sorry ", text_or_html, title)

proc detailedsorry*(text_or_html: string, details: string, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --detailedsorry '{text_or_html}' '{details}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc error*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --error ", text_or_html, title)

proc detailederror*(text_or_html, details: string, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --detailederror '{text_or_html}' '{details}'{stderrs}")
  (output: comand.exitCode == 0, exitCode: comand.exitCode)

proc msgbox*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --msgbox ", text_or_html, title)

proc inputbox*(text_or_html: string, init = "", title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --inputbox '{text_or_html}' '{init}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc password*(text_or_html: string, init = "", title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --password '{text_or_html}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc newpassword*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --newpassword '{text_or_html}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc textbox*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  kdialogizer(" --textbox ", text_or_html, title)

proc textinputbox*(text_or_html: string, init = "", stderr2output = false, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --textinputbox '{text_or_html}' '{init}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc passivepopup*(text_or_html: string, timeout: int8, title = default_title, stderrs = stderrs): int =
  execCmdEx(fmt"kdialog --title '{title}' --passivepopup '{text_or_html}' {timeout}{stderrs}").exitCode

proc getopenfilename*(startDir = getCurrentDir(), filter = "*.*", multiple =false, title = default_title, stderrs = stderrs): tuple =
  let multi = if multiple: "--multiple" else: ""
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getopenfilename '{startDir}' '{filter}' {multi}{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getsavefilename*(startDir = getCurrentDir(), filter = "*.*", title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getsavefilename '{startDir}' '{filter}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getexistingdirectory*(startDir = getCurrentDir(), title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getexistingdirectory '{startDir}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getopenurl*(startDir = getCurrentDir(), filter = "*.*", multiple = false, title = default_title, stderrs = stderrs): tuple =
  let multi = if multiple: "--multiple" else: ""
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getopenurl '{startDir}' '{filter}' {multi}{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc getsaveurl*(startDir = getCurrentDir(), filter = "*.*", title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getsaveurl '{startDir}' '{filter}'{stderrs}")
  (output: $comand.output.strip, exitCode: comand.exitCode)

proc geticon*(title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --geticon{stderrs}")
  (output: comand.output.strip, exitCode: comand.exitCode)

proc getcolor*(title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --getcolor{stderrs}")
  (output: parseColor(comand.output.strip), exitCode: comand.exitCode)

proc slider*(text_or_html: string, minimum: int, maximum: int, steps: int8, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --slider '{text_or_html}' {minimum} {maximum} {steps}{stderrs}")
  (output: comand.output.strip.parseInt, exitCode: comand.exitCode)

proc calendar*(text_or_html: string, title = default_title, stderrs = stderrs): tuple =
  let comand = execCmdEx(fmt"kdialog --title '{title}' --calendar '{text_or_html}'{stderrs}")
  (output: parse(comand.output.strip, "ddd MMM d yyyy"), exitCode: comand.exitCode)

proc checklist*(text_or_html: string, items: array, title = default_title, stderrs = stderrs): tuple =
  var itemz = ""
  for indx, item in items.pairs:
    let state = if item[1]: "on" else: "off"
    itemz.add(fmt"{indx + 1} '{item[0]}' {state} ")
  let comand = execCmdEx(fmt"kdialog --title '{title}' --checklist '{text_or_html}' {itemz} {stderrs}")
  (output: comand.output.strip.split(" "), exitCode: comand.exitCode)

proc radiolist*(text_or_html: string, items: array, title = default_title, stderrs = stderrs): tuple =
  var itemz = ""
  for indx, item in items.pairs:
    let state = if item[1]: "on" else: "off"
    itemz.add(fmt"{indx + 1} '{item[0]}' {state} ")
  let comand = execCmdEx(fmt"kdialog --title '{title}' --radiolist '{text_or_html}' {itemz} {stderrs}")
  (output: parseInt(comand.output.strip), exitCode: comand.exitCode)

proc menu*(text_or_html: string, items: array, title = default_title, stderrs = stderrs): tuple =
  var itemz = ""
  for indx, item in items:
    echo indx, item
    itemz.add(fmt"{indx + 1} '{item}' ")
  echo itemz
  let comand = execCmdEx(fmt"kdialog --title '{title}' --menu '{text_or_html}' {itemz} {stderrs}")
  (output: parseInt(comand.output.strip), exitCode: comand.exitCode)

proc combobox*(text_or_html: string, items: array, title = default_title, stderrs = stderrs): tuple =
  var itemz = ""
  for item in items:
    itemz.add(fmt"'{item}' ")
  let comand = execCmdEx(fmt"kdialog --title '{title}' --combobox '{text_or_html}' {itemz} {stderrs}")
  (output: comand.output.strip, exitCode: comand.exitCode)


runnableExamples:
  import strutils
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
