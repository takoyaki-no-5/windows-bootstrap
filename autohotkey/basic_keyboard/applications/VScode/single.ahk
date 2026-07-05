#Requires AutoHotkey v2.0
#Include ../../Funk.ahk
#Include utils.ahk

#HotIf win_is_held() and ide_is_active()
;タブ移動
h::Send("^{PgUp}")
l::Send("^{PgDn}")
#HotIf

#HotIf ctrl_is_held() and ide_is_active()
p::^+p ;コマンドパレット
s::^F5 ;実行
x::^p  ;ファイルに移動
/::^/  ;複数行コメントアウト
#HotIf

