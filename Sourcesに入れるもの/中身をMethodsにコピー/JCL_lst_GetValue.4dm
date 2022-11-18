//%attributes = {"shared":true}
  //JCL_lst_GetValue
  //20170306 wat
  // 汎用のリストボックス　書き出し

C_POINTER:C301($1;$lstbxPtr)
$lstbxPtr:=$1
C_TEXT:C284($0;$buf)
$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
C_TEXT:C284($tabChar;$crChar)
$tabChar:=Char:C90(Tab:K15:37)
$crChar:=Char:C90(Line feed:K15:40)  //20170222
C_TEXT:C284($folderPath;$filePath)
C_LONGINT:C283($numOfCols;$numOfRows;$col;$row)

  // 列数を求める
$numOfCols:=LISTBOX Get number of columns:C831($lstbxPtr->)
$numOfRows:=LISTBOX Get number of rows:C915($lstbxPtr->)

ARRAY TEXT:C222($aryColNames;0)
ARRAY TEXT:C222($aryHeaderNames;0)
ARRAY POINTER:C280($aryColVars;0)
ARRAY POINTER:C280($aryHeaderVers;0)
ARRAY BOOLEAN:C223($aryColsVisible;0)
ARRAY POINTER:C280($aryStyles;0)

LISTBOX GET ARRAYS:C832($lstbxPtr->;$aryColNames;$aryHeaderNames;$aryColVars;$aryHeaderVers;$aryColsVisible;$aryStyles)

  // ヘッダを出力
For ($col;1;$numOfCols)
	
	If ($col<$numOfCols)
		
		$str:=OBJECT Get title:C1068(*;$aryHeaderNames{$col})
		$buf:=$buf+$str+$tabChar
		
	Else 
		
		$str:=OBJECT Get title:C1068(*;$aryHeaderNames{$col})
		$buf:=$buf+$str+$tabChar+$crChar
		
	End if 
End for 

  // ボディを出力
For ($row;1;$numOfRows)
	
	For ($col;1;$numOfCols)
		
		If ($col<$numOfCols)
			
			$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある
			
			$buf:=$buf+$str+$tabChar
			
		Else 
			
			$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある
			$buf:=$buf+$str+$crChar
			
		End if 
	End for 
End for 

$0:=$buf
