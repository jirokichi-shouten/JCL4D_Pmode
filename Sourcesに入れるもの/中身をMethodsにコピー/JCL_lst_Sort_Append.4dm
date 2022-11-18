//%attributes = {"shared":true}
  //JCL_lst_Sort_Append
  //20160503 wat yabe
  //リストボックスのソート順を、配列に追加
  // OnLoadで呼び出す
  // デフォルトの並び順を指定、配列にプッシュしておく
  // 関連メソッド：xx_frmOnLoad, xx_frmDefInit, xx_lstXX_OnAfgterSort, xx_lstXX_make

C_TEXT:C284($1;$lstboxName)
$lstboxName:=$1
C_POINTER:C301($2;$aryHeaderNamesPtr)
$aryHeaderNamesPtr:=$2
C_POINTER:C301($3;$arySortOrdersPtr)
$arySortOrdersPtr:=$3
C_LONGINT:C283($4;$nr)
$nr:=$4
C_LONGINT:C283($5;$order)
$order:=$5
C_TEXT:C284($headerName)


  //デフォルト指定があれば
$headerName:=JCL_lst_Sort_HeaderName ($lstboxName;$nr)
  // ユーザ操作によって列番号が変化する可能性があるため、列番号ではなく名前を配列に保持

If ($headerName#"")
	
	APPEND TO ARRAY:C911($aryHeaderNamesPtr->;$headerName)
	APPEND TO ARRAY:C911($arySortOrdersPtr->;$order)
	
End if 

