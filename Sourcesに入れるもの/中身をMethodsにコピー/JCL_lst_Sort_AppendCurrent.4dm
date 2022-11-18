//%attributes = {"shared":true}
  //JCL_lst_Sort_AppendCurrent
  //20160503 wat
  //ソート順を覚える、ソート履歴に現状を追加
  //XX リストボックス メソッドのOn After Sortで実行する
  // JCL_lst_Sort_AppendCurrent (->vMR01_lstMR;->vMR01_lstMR_HeaderNames;->vMR01_lstMR_SortOrders)
  // 関連メソッド：xx_frmOnLoad, xx_frmDefInit, xx_lstXX_OnAfgterSort, xx_lstXX_make

C_POINTER:C301($1;$lstboxPtr)
$lstboxPtr:=$1
C_POINTER:C301($2;$aryHeaderNamesPtr)
$aryHeaderNamesPtr:=$2
C_POINTER:C301($3;$arySortOrdersPtr)
$arySortOrdersPtr:=$3
C_LONGINT:C283($i;$sizeOfAry)

ARRAY TEXT:C222($arrColNames;0)
ARRAY TEXT:C222($arrHeaderNames;0)
ARRAY POINTER:C280($arrColVars;0)
ARRAY POINTER:C280($arrHeaderVars;0)
ARRAY BOOLEAN:C223($arrColsVisible;0)
ARRAY POINTER:C280($arrStyles;0)
LISTBOX GET ARRAYS:C832($lstboxPtr->;$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrColsVisible;$arrStyles)

$sizeOfAry:=Size of array:C274($arrHeaderNames)
For ($i;1;$sizeOfAry)
	
	If ($arrHeaderVars{$i}->#0)
		
		APPEND TO ARRAY:C911($aryHeaderNamesPtr->;$arrHeaderNames{$i})
		APPEND TO ARRAY:C911($arySortOrdersPtr->;$arrHeaderVars{$i}->)
		
		$i:=$sizeOfAry
		
	End if 
	
End for 
