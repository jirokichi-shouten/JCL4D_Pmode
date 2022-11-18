//%attributes = {}
//JCL_lst_Export_pgs2
//JCL_lst_Export_pgs2
//JCL_lst_Export_pgs
//20200310 wat
// 汎用のリストボックス　書き出し  //JCL_lst_Exportの集大成
//コンテンツ内の改行をストリップ  戻り値にファイル名を返す　 改行はＬＦ、
//20200310 wat text to Documentはバッファが大きくなると遅い、send packetに戻したら早い。
//20200310 wat プログレスバー表示
//20200328 wat 失敗したりキャンセルされたら戻り値は０、成功したら１、ファイル名はポインタに変更

C_POINTER:C301($1; $lstbxPtr)
$lstbxPtr:=$1
C_POINTER:C301($2; $namePtr)
$namePtr:=$2
C_LONGINT:C283($3; $pgs_interval)
$pgs_interval:=$3
C_LONGINT:C283($0; $success)  //20200328 wat
$success:=0
C_TEXT:C284($buf; $str)
C_TEXT:C284($tabChar; $crlf; $cr; $lf)
$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
$tabChar:=Char:C90(Tab:K15:37)
$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
$cr:=Char:C90(Carriage return:K15:38)
$lf:=Char:C90(Line feed:K15:40)
C_TEXT:C284($folderPath; $filePath)
C_LONGINT:C283($numOfCols; $numOfRows; $col; $row)
C_BOOLEAN:C305($done)
$done:=False:C215
C_TEXT:C284($msg)
C_TIME:C306($time)

$namePtr->:=$namePtr->+JCL_str_Datemark(Current date:C33; Current time:C178)+".txt"
$dlg_ok:=JCL_dlg_InputOne("出力先のファイル名："; "フィル名を入力してください。"; "OK"; "Cancel"; $namePtr)
If ($dlg_ok=1)
	$success:=1
	//ファイルに書き出す
	$folderPath:=System folder:C487(Desktop:K41:16)
	$filePath:=JCL_file_MakeFilePath($folderPath; $namePtr->)
	$time:=Create document:C266($filePath)
	
	//プログレスバー
	JCL_pgs_DefInit
	$msg:="「"+$namePtr->+"」に書き出しています..."
	JCL_pgs_Show($msg)
	
	// 列数を求める
	$numOfCols:=LISTBOX Get number of columns:C831($lstbxPtr->)
	$numOfRows:=LISTBOX Get number of rows:C915($lstbxPtr->)
	
	ARRAY TEXT:C222($aryColNames; 0)
	ARRAY TEXT:C222($aryHeaderNames; 0)
	ARRAY POINTER:C280($aryColVars; 0)
	ARRAY POINTER:C280($aryHeaderVers; 0)
	ARRAY BOOLEAN:C223($aryColsVisible; 0)
	ARRAY POINTER:C280($aryStyles; 0)
	
	LISTBOX GET ARRAYS:C832($lstbxPtr->; $aryColNames; $aryHeaderNames; $aryColVars; $aryHeaderVers; $aryColsVisible; $aryStyles)
	
	$msg:="タイトル行を書き出しています..."
	JCL_pgs_SetValue(1; $msg; 1; 1)
	// ヘッダを出力
	For ($col; 1; $numOfCols)
		If ($col<$numOfCols)
			$str:=OBJECT Get title:C1068(*; $aryHeaderNames{$col})
			$buf:=$buf+$str+$tabChar
			
		Else 
			$str:=OBJECT Get title:C1068(*; $aryHeaderNames{$col})
			$buf:=$buf+$str+$tabChar+$crlf
			
		End if 
	End for 
	SEND PACKET:C103($time; $buf)  //逐次ファイルに書き出して、バッファクリア、サイズを一定に保つことで高速化
	$buf:=""
	
	// ボディを出力
	For ($row; 1; $numOfRows)
		//プログレスバー
		If (Mod:C98($row; $pgs_interval)=0)
			$msg:="行を書き出しています..."
			JCL_pgs_SetValue(($row/$numOfRows)*100; $msg+String:C10($row); $row; $numOfRows)
			DELAY PROCESS:C323(Current process:C322; 1)
		End if 
		
		For ($col; 1; $numOfCols)
			//途中はタブ区切り、最後の列のあとに改行
			If ($col<$numOfCols)
				$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある、pictとか？
				//改行をストリップ
				$str:=Replace string:C233($str; $crlf; " ")
				$str:=Replace string:C233($str; $cr; " ")
				$str:=Replace string:C233($str; $lf; " ")
				
				$buf:=$buf+$str+$tabChar
				
			Else 
				$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある
				$buf:=$buf+$str+$crlf
				
			End if 
		End for 
		SEND PACKET:C103($time; $buf)  //逐次ファイルに書き出して、バッファクリア、サイズを一定に保つことで高速化
		$buf:=""
		
		$done:=JCL_pgs_IsCancel
		If ($done=True:C214)
			$row:=$numOfRows
			$success:=0
		End if 
	End for 
	JCL_pgs_Cancel
	
	//ファイルを閉じる
	CLOSE DOCUMENT:C267($time)
	If (OK#1)
		$success:=0
	End if 
End if 

$0:=$success
