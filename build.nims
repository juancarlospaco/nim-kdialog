#!/usr/bin/env nim
import strutils  # nim e build.nims file.nim
let binary_file = paramStr(3).replace(".nim", "")
exec "nim c -d:release --app:console --opt:size " & paramStr(3)
exec "strip --verbose -ss -R .comment " & binary_file
exec "upx --best --ultra-brute " & binary_file
exec "sha1sum " & binary_file & " > " & paramStr(3).replace(".nim", ".sha1")
exec "keybase sign --infile " & binary_file & " --outfile " & paramStr(3).replace(".nim", ".asc")
