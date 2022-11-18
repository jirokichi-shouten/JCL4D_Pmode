//%attributes = {}
// JCL_pop_Check
// 20221115 hisa wat
// ポップアップメニュー　チェックする

C_LONGINT:C283($1; $checkIndex)
$checkIndex:=$1
C_TEXT:C284($0; $contents)
C_LONGINT:C283($sizeOfAry)

$sizeOfAry:=Size of array:C274(vPOP_aryItems)
If ($checkIndex<=$sizeOfAry)
	vPOP_aryItems{$checkIndex}:="!-"+vPOP_aryItems{$checkIndex}
	vPOP_varSelected:=$checkIndex
	
End if 

$contents:=JCL_pop_Make
$0:=$contents
