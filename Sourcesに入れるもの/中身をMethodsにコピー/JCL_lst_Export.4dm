//%attributes = {"shared":true}
  //JCL_Export_fromListBox
  //zz_Export
  //20140921 wat yabe
  // 汎用のリストボックス　書き出し

C_POINTER:C301($1;$lstbxPtr)
$lstbxPtr:=$1
C_TEXT:C284($2;$name)
$name:=$2
C_BOOLEAN:C305($0;$done)
$done:=False:C215
C_TEXT:C284($buf)
$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
C_TEXT:C284($tabChar;$crChar)
$tabChar:=Char:C90(Tab:K15:37)
$crChar:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
$crChar:=Char:C90(Line feed:K15:40)  //20170222
C_TEXT:C284($folderPath;$filePath)
C_LONGINT:C283($numOfCols;$numOfRows;$col;$row)
C_LONGINT:C283($open_ok;$dlg_ok)

$name:=$name+JCL_str_Datemark (Current date:C33;Current time:C178)+".txt"
$dlg_ok:=JCL_dlg_InputOne ("出力先のファイル名：";"フィル名を入力してください。";"OK";"Cancel";->$name)

If ($dlg_ok=1)
	
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
	
	$folderPath:=System folder:C487(Desktop:K41:16)
	$filePath:=JCL_file_MakeFilePath ($folderPath;$name)
	$open_ok:=JCL_file_OpenForWrite ($filePath;->$FileRef)
	If ($open_ok=1)
		
		  //ファイルに書き出す
		JCL_file_WriteSJIS ($FileRef;$buf)
		
		  //ファイルを閉じる
		CLOSE DOCUMENT:C267($FileRef)
		
		$done:=True:C214
		
	End if 
	
End if 

$0:=$done
