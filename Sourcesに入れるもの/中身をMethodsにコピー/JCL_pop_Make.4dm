//%attributes = {}
// JCL_pop_Make
// 20221115 hisa wat
// ポップアップメニュー　配列から項目を作成

C_TEXT:C284($0; $contents)
$contents:=""
C_LONGINT:C283($i; $sizeOfAry)

$sizeOfAry:=Size of array:C274(vPOP_aryItems)
For ($i; 1; $sizeOfAry)
	$contents:=$contents+vPOP_aryItems{$i}+";"
	
End for 

$0:=$contents
