//%attributes = {}
//JCL_wait_Open
//プログレスバー表示プロセス
//$1:メッセージ
//20080605　矢部　新規作成

C_TEXT:C284($1; vD50_Title)
vD50_Title:=$1

//ウィンドウ表示
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675("D50_Wait"; \
Modal dialog box:K34:2; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("D50_Wait")
CLOSE WINDOW:C154
