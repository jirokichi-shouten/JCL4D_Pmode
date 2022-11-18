//%attributes = {}
// JCL_pop_Init
// 20221115 hisa wat
// ポップアップメニュー　初期化

C_TEXT:C284($1; $items)
$items:=$1
C_LONGINT:C283($0; $numOfLines)

C_LONGINT:C283(vPOP_varSelected)
vPOP_varSelected:=0
ARRAY TEXT:C222(vPOP_aryItems; 0)

$numOfLines:=JCL_str_Extract($items; ";"; ->vPOP_aryItems)

$0:=$numOfLines
