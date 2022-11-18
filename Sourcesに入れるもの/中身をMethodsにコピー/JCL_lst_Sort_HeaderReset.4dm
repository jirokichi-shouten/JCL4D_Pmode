//%attributes = {"shared":true}
  //JCL_lst_Sort_HeaderReset
  //20160503 wat yabe
  // リストボックスのヘッダーのソートマークをクリア
  // OnLoadで呼び出す

C_TEXT:C284($1;$lstboxName)
$lstboxName:=$1
C_LONGINT:C283($i;$sizeOfAry)

ARRAY TEXT:C222($arrColNames;0)
ARRAY TEXT:C222($arrHeaderNames;0)
ARRAY POINTER:C280($arrColVars;0)
ARRAY POINTER:C280($arrHeaderVars;0)
ARRAY BOOLEAN:C223($arrColsVisible;0)
ARRAY POINTER:C280($arrStyles;0)
LISTBOX GET ARRAYS:C832(*;$lstboxName;$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrColsVisible;$arrStyles)

$sizeOfAry:=Size of array:C274($arrHeaderNames)
For ($i;1;$sizeOfAry)
	
	
	$arrHeaderVars{$i}->:=0
	
	
End for 

