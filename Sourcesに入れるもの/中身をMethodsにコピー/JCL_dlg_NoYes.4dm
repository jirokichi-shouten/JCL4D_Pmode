//%attributes = {"shared":true}
//JCL_dlg_NoYes
//20100830 wat new
//デフォルトがキャンセルの確認ダイアログ

//元は、zz_Dialog_NoYes
//20090528 wat new
//確認用yes/noダイアログ

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str; $4; $cancel_str)
$title:=$1
$msg:=$2
$ok_str:=$3
$cancel_str:=$4

D81_DefInit($title; $msg; $ok_str; $cancel_str)

$dialog_ok:=D81_Display

$0:=$dialog_ok

