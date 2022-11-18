//%attributes = {"shared":true}
  //JCL_lst_Sort_HeaderName
  //20160503 wat
  // リストボックスの列名を渡して、列番号をエル
  // リストボックスの列順（列番号）はユーザ操作によって変化する可能性があるため、列番号ではなく名前を配列に保持


C_TEXT:C284($1;$lstboxName)
$lstboxName:=$1
C_LONGINT:C283($2;$nr)
$nr:=$2
C_TEXT:C284($0;$headerName)
$headerName:=""
C_LONGINT:C283($sizeOfAry)

ARRAY TEXT:C222($arrColNames;0)
ARRAY TEXT:C222($arrHeaderNames;0)
ARRAY POINTER:C280($arrColVars;0)
ARRAY POINTER:C280($arrHeaderVars;0)
ARRAY BOOLEAN:C223($arrColsVisible;0)
ARRAY POINTER:C280($arrStyles;0)
LISTBOX GET ARRAYS:C832(*;$lstboxName;$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrColsVisible;$arrStyles)

$sizeOfAry:=Size of array:C274($arrHeaderNames)
If ($sizeOfAry>=$nr)
	
	$headerName:=$arrHeaderNames{$nr}
	
End if 

$0:=$headerName

