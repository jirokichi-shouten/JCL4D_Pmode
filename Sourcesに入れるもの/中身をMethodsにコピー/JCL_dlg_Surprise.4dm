//%attributes = {"shared":true}
//JCL_dlg_Surprise
//20100918 wat new
//驚きのサープライズダイアログ

C_LONGINT:C283($0; $dialog_ok)
C_TEXT:C284($1; $title; $2; $msg; $3; $ok_str)
$title:=$1
$msg:=$2
$ok_str:=$3

D83_DefInit($title; $msg; $ok_str)


$dialog_ok:=D83_Display

$0:=$dialog_ok
