//%attributes = {"shared":true}
//JCL_dlg_YesNo
//20101206 wat new
//確認用yes/noダイアログ
//デフォルトがOKの確認ダイアログ

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str; $4; $cancel_str)
$title:=$1
$msg:=$2
$ok_str:=$3
$cancel_str:=$4

D80_DefInit($title; $msg; $ok_str; $cancel_str)

$dialog_ok:=D80_Display

$0:=$dialog_ok

