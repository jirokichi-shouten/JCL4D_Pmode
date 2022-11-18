//%attributes = {"shared":true}
  //JCL_lst_Sort
  //20160503 wat yabe
  // ソート履歴を実行 XX01_lstXX_makeで実行してください
  // 呼び元に「ソート履歴」配列が用意されていることが前提
  // ソート履歴は、オンロード時とオンアフターソート時に配列に記録します。
  // 配列の順番に　ソートコマンドを実行します。
  // 関連メソッド：xx_frmOnLoad, xx_frmDefInit, xx_lstXX_OnAfgterSort, xx_lstXX_make

C_TEXT:C284($1;$lstboxName)
$lstboxName:=$1
  //C_POINTER($1;$lstboxPtr)
  //$lstboxPtr:=$1
C_POINTER:C301($2;$aryHeaderNamesPtr)
$aryHeaderNamesPtr:=$2
C_POINTER:C301($3;$arySortOrdersPtr)
$arySortOrdersPtr:=$3
C_LONGINT:C283($i;$sizeOfAry)

$sizeOfAry:=Size of array:C274($aryHeaderNamesPtr->)
If ($sizeOfAry#0)
	
	For ($i;1;$sizeOfAry)
		
		$nr:=JCL_lst_ColNumber ($lstboxName;$aryHeaderNamesPtr->{$i})
		
		If ($arySortOrdersPtr->{$i}=1)
			  //昇順
			LISTBOX SORT COLUMNS:C916(*;$lstboxName;$nr;>)
			
		Else 
			  //降順
			LISTBOX SORT COLUMNS:C916(*;$lstboxName;$nr;<)
			
		End if 
		
	End for 
	
End if 
