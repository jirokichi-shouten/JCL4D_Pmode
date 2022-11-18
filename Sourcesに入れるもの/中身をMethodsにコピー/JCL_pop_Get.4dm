//%attributes = {}
// JCL_pop_Get
// 20221115 hisa
// ポップアップメニュー　選択されている項目を取得

C_LONGINT:C283($1; $selected)
$selected:=$1
C_TEXT:C284($0; $selectedItem)
$selectedItem:=""
C_LONGINT:C283($sizeOfAry)

$sizeOfAry:=Size of array:C274(vPOP_aryItems)
If ($selected<=$sizeOfAry)
	$selectedItem:=vPOP_aryItems{$selected}
	$pos:=Position:C15("!-"; $selectedItem)
	If ($pos=1)
		$selectedItem:=Replace string:C233($selectedItem; "!-"; ""; 1)
		
	End if 
	
End if 

$0:=$selectedItem

