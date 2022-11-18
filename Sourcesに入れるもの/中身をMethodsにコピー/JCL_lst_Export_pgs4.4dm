//JCL_lst_Export_pgs4
//JCL_lst_Export_pgs3
//JCL_lst_Export_pgs2
//JCL_lst_Export_pgs
//20200310 wat
// 汎用のリストボックス　書き出し //JCL_lst_Exportの集大成、高速化、プログレスバー
//20140921 wat yabe
//20180522 wat ファイル書き出し方法を変更, 改行をストリップ
//20181030 wat 戻り値にファイル名を返す
//20190107 wat ike 改行はＬＦ、BLOB経由しない
//20200310 wat text to Documentはバッファが大きくなると遅い、send packetに戻したら早い。
//20200310 wat プログレスバー表示
//20220917 hisa wat 選択フォルダ ->  JCL_dlg_Inform_ShowOnDisk の流れ
//.        $filePath:=JCL_lst_Export_pgs4(->vPA01_lstPA; ->$name; 1)
//.        改行コードをヘッダー、ボディ、フッターと合わせる
//.        非表示列は出力しない
//.        フッター非表示ならフッター出力しない
//.        一番右側が非表示の場合、改行されない問題を修正

C_POINTER($1; $lstbxPtr)
$lstbxPtr:=$1
C_POINTER($2; $namePtr)
$namePtr:=$2
C_LONGINT($3; $pgs_interval)
$pgs_interval:=$3
C_TEXT($0; $filePath)  //20181030 wat
C_TEXT($buf; $str)
C_TEXT($tabChar; $crlf; $cr; $lf)

$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
$tabChar:=Char(Tab)
$crlf:=Char(Carriage return)+Char(Line feed)
$cr:=Char(Carriage return)
$lf:=Char(Line feed)
C_TEXT($folderPath)
C_LONGINT($numOfCols; $numOfRows; $col; $row)
C_BOOLEAN($done)
$done:=False

// フォルダ選択ダイアログを表示　// 20220917
C_TEXT($msg)
$msg:=$namePtr->+"の出力先のフォルダを選択してください。"
$namePtr->:=$namePtr->+JCL_str_Datemark(Current date; Current time)+".txt"  // デイトマークを文字連結
$folderPath:=Select folder($msg)
$dlg_ok:=OK
If ($dlg_ok=1)
	//ファイルに書き出す
	$filePath:=JCL_file_MakeFilePath($folderPath; $namePtr->)
	$time:=Create document($filePath)
	//プログレスバー
	JCL_pgs_DefInit
	$msg:="テキストファイル「"+$namePtr->+"」に書き出しています..."
	JCL_pgs_Show($msg)
	// 列数を求める
	$numOfCols:=LISTBOX Get number of columns($lstbxPtr->)
	$numOfRows:=LISTBOX Get number of rows($lstbxPtr->)
	ARRAY TEXT($aryColNames; 0)
	ARRAY TEXT($aryHeaderNames; 0)
	ARRAY POINTER($aryColVars; 0)
	ARRAY POINTER($aryHeaderVers; 0)
	ARRAY BOOLEAN($aryColsVisible; 0)
	ARRAY POINTER($aryStyles; 0)
	ARRAY TEXT($aryFooterNames; 0)
	ARRAY POINTER($aryFooterVers; 0)
	C_LONGINT($footer_visible)
	
	LISTBOX GET ARRAYS($lstbxPtr->; $aryColNames; $aryHeaderNames; $aryColVars; $aryHeaderVers; $aryColsVisible; \
	$aryStyles; $aryFooterNames; $aryFooterVers)
	$msg:="タイトル行を書き出しています..."
	JCL_pgs_SetValue(1; $msg; 1; 1)
	// ヘッダを出力
	For ($col; 1; $numOfCols)
		//非表示列は出力しない // 20220917
		If ($aryColsVisible{$col}=True)
			$str:=OBJECT Get title(*; $aryHeaderNames{$col})
			$buf:=$buf+$str+$tabChar
		End if 
		
		//最後の列は最後のタブ文字を取り除いて改行を追加
		If ($col=$numOfCols)
			$buf:=$buf+$crlf
			
		End if 
	End for 
	SEND PACKET($time; $buf)
	$buf:=""  //センドしたらバフをクリア
	
	// ボディを出力
	For ($row; 1; $numOfRows)
		//プログレスバー
		If (Mod($row; $pgs_interval)=0)
			$msg:="行を書き出しています..."
			JCL_pgs_SetValue(($row/$numOfRows)*100; $msg+String($row); $row; $numOfRows)
			DELAY PROCESS(Current process; 1)
			
		End if 
		For ($col; 1; $numOfCols)
			//途中はタブ区切り、最後の列のあとに改行
			//非表示列は出力しない // 20220917
			If ($col<$numOfCols)
				If ($aryColsVisible{$col}=True)
					$str:=String($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある、pictとか？
					//改行をストリップ
					$str:=Replace string($str; $crlf; " ")
					$str:=Replace string($str; $cr; " ")
					$str:=Replace string($str; $lf; " ")
					$buf:=$buf+$str+$tabChar
					
				End if 
				
			Else 
				$buf:=$buf+$crlf  // 20220917 hisa 一番右側が非表示の場合、改行されない問題を修正
				
			End if 
			
		End for 
		SEND PACKET($time; $buf)
		$buf:=""  //センドしたらバフをクリア
		
		$done:=JCL_pgs_IsCancel
		If ($done=True)
			$row:=$numOfRows
		End if 
		
	End for 
	
	// フッターを出力 // 20220917 非表示なら出力しない
	$footer_visible:=LISTBOX Get property($lstbxPtr->; lk display footer)
	If ($footer_visible=1)
		For ($col; 1; $numOfCols)
			//非表示列は出力しない // 20220917
			If ($aryColsVisible{$col}=True)
				$str:=String($aryFooterVers{$col}->)  // データ型によってはエラーになる可能性がある 20210923
				$buf:=$buf+$str+$tabChar
			End if 
			
			//最後の列は最後のタブ文字を取り除いて改行を追加
			If ($col=$numOfCols)
				$buf:=$buf+$crlf
				
			End if 
		End for 
		SEND PACKET($time; $buf)
		$buf:=""  //センドしたらバフをクリア
		
	End if 
	
	JCL_pgs_Cancel
	//ファイルを閉じる
	CLOSE DOCUMENT($time)
	
End if 

$0:=$filePath
