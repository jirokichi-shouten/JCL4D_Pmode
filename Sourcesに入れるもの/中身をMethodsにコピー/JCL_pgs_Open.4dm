//%attributes = {"shared":true}
//JCL_pgs_Open
//プログレスバー表示プロセス
//$1:メッセージ
//20080605　矢部　新規作成

C_TEXT:C284($1; vP01_Title)
vP01_Title:=$1

//ウィンドウ表示
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("P01_Bar"; \
Modal dialog box:K34:2; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("P01_Bar")
CLOSE WINDOW:C154
