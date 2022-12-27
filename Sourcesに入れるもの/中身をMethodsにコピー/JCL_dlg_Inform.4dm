//%attributes = {"shared":true}
//%attributes = {"lang":"en"} comment added and reserved by 4D.
//JCL_dlg_Inform
//20100918 wat new
//インフォームダイアログ、OKボタンしかない

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str)
$title:=$1
$msg:=$2
$ok_str:=$3

D82_DefInit($title; $msg; $ok_str)


$dialog_ok:=D82_Display

$0:=$dialog_ok
