//%attributes = {"shared":true}
  //JCL_lst_ColNumber
  //20160503 wat yabe
  // リストボックスの列名を渡して、現在の列番号を取得　列番号はユーザ操作で変化している可能性有り
  // ソートコマンドは列番号で指定するため、このコマンドが必要

C_TEXT:C284($1;$lstboxName)
$lstboxName:=$1
C_TEXT:C284($2;$colName)
$colName:=$2
C_LONGINT:C283($0;$nr)
$nr:=0
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
	
	If ($arrHeaderNames{$i}=$colName)
		
		$nr:=$i
		
	End if 
	
End for 

$0:=$nr
