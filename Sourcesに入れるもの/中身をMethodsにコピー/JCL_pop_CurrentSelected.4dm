//%attributes = {}
// JCL_pop_CurrentSelected
// 20221115 hisa wat
// ポップアップメニュー　デフォルトチェック

C_TEXT:C284($1; $selectedItem)
$selectedItem:=$1
C_TEXT:C284($0; $contents)
$contents:=""

$index:=Find in array:C230(vPOP_aryItems; $selectedItem)
If (0<=$index)
	$contents:=JCL_pop_Check($index)
	
End if 

$0:=$contents

