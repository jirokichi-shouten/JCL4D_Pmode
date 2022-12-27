//%attributes = {"shared":true}
//JCL_dlg_InputOne
//20110112 wat new
//入力フィールドが一個のダイアログ

C_LONGINT:C283($0; $d_ok)
C_TEXT:C284($1; $title; $2; $prompt; $3; $ok_str; $4; $cancel_str)
$title:=$1
$prompt:=$2
$ok_str:=$3
$cancel_str:=$4
C_POINTER:C301($5; $strPtr)
$strPtr:=$5

D84_DefInit($title; $prompt; $strPtr->; $ok_str; $cancel_str)

$d_ok:=D84_Display
If ($d_ok=1)
	
	//入力された文字列を得る
	$strPtr->:=vD84_fldInput
	
End if 

$0:=$d_ok
