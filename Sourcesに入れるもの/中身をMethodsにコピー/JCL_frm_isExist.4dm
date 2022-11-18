//%attributes = {}
//JCL_frm_isExist
//20220425 hisa wat
//フォームがあるかどうか、確認する

C_POINTER:C301($1; $tblPtr)  //テーブルポインタ
$tblPtr:=$1
C_TEXT:C284($2; $form_name)  //フォーム名
$form_name:=$2
C_BOOLEAN:C305($0; $exist)
$exist:=False:C215
C_LONGINT:C283($index)
ARRAY TEXT:C222($arynames; 0)

FORM GET NAMES:C1167($tblPtr->; $arynames)

$index:=Find in array:C230($arynames; $form_name)
If ($index#-1)
	$exist:=True:C214
	
End if 

$0:=$exist