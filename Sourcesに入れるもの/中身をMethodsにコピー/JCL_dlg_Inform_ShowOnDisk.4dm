//%attributes = {"shared":true}
//%attributes = {"lang":"en"} comment added and reserved by 4D.
//JCL_dlg_Inform_ShowOnDisk
//20220223 wat new
//インフォームダイアログ、書き出しの後で使う

C_TEXT:C284($1; $title)
$title:=$1
C_TEXT:C284($2; $msg)
$msg:=$2
C_TEXT:C284($3; $ok_str)
$ok_str:=$3
C_TEXT:C284($4; $filePath)
$filePath:=$4
C_LONGINT:C283($0; $dialog_ok)

D85_DefInit($title; $msg; $ok_str; $filePath)


$dialog_ok:=D85_Display

$0:=$dialog_ok
