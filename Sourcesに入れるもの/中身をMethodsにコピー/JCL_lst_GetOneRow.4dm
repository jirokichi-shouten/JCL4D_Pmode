//%attributes = {"shared":true}
  //JCL_lst_GetOneRow
  //20170311 wat
  //JCL_lst_GetValue
  // 汎用のリストボックス　書き出し

C_POINTER:C301($1;$lstbxPtr)
$lstbxPtr:=$1
C_LONGINT:C283($2;$lstbx_row_nr)
$lstbx_row_nr:=$2
C_POINTER:C301($3;$objPtr)
$objPtr:=$3
C_LONGINT:C283($0;$retValue)
$retValue:=0  // 配列要素がなければゼロを返す
C_TEXT:C284($str)

ARRAY TEXT:C222($aryColNames;0)
ARRAY TEXT:C222($aryHeaderNames;0)
ARRAY POINTER:C280($aryColVars;0)
ARRAY POINTER:C280($aryHeaderVers;0)
ARRAY BOOLEAN:C223($aryColsVisible;0)
ARRAY POINTER:C280($aryStyles;0)

LISTBOX GET ARRAYS:C832($lstbxPtr->;$aryColNames;$aryHeaderNames;$aryColVars;$aryHeaderVers;$aryColsVisible;$aryStyles)

  // 列数を求める
$numOfCols:=LISTBOX Get number of columns:C831($lstbxPtr->)
$numOfRows:=LISTBOX Get number of rows:C915($lstbxPtr->)
If ($numOfRows>$lstbx_row_nr)
	
	  // 指定された行の値をオブジェクトに取得
	For ($col;1;$numOfCols)
		
		$str:=String:C10($aryColVars{$col}->{$lstbx_row_nr})  // データ型によってはエラーになる可能性がある
		
		OB SET:C1220($objPtr->;String:C10($col);$str)
		
	End for 
	
	$retValue:=1  // 配列要素があった
	
End if 

$0:=$retValue
