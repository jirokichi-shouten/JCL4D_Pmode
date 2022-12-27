//%attributes = {}
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
//.        $filePath:=JCL_lst_Export_pgs4(->vBO01_lstPA; ->$name; 1)
//.        改行コードをヘッダー、ボディ、フッターと合わせる
//.        非表示列は出力しない
//.        フッター非表示ならフッター出力しない
//.        一番右側が非表示の場合、改行されない問題を修正
// 20221129 hisa wat 最後の列が出力されていなかった不具合を修正

C_POINTER:C301($1; $lstbxPtr)
$lstbxPtr:=$1
C_POINTER:C301($2; $namePtr)
$namePtr:=$2
C_LONGINT:C283($3; $pgs_interval)
$pgs_interval:=$3
C_TEXT:C284($0; $filePath)  //20181030 wat
C_TEXT:C284($buf; $str)
C_TEXT:C284($tabChar; $crlf; $cr; $lf)

$buf:=" "  // 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
$tabChar:=Char:C90(Tab:K15:37)
$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
$cr:=Char:C90(Carriage return:K15:38)
$lf:=Char:C90(Line feed:K15:40)
C_TEXT:C284($folderPath)
C_LONGINT:C283($numOfCols; $numOfRows; $col; $row)
C_BOOLEAN:C305($done)
$done:=False:C215

// フォルダ選択ダイアログを表示　// 20220917
C_TEXT:C284($msg)
$msg:=$namePtr->+"の出力先のフォルダを選択してください。"
$namePtr->:=$namePtr->+JCL_str_Datemark(Current date:C33; Current time:C178)+".txt"  // デイトマークを文字連結
$folderPath:=Select folder:C670($msg)
$dlg_ok:=OK
If ($dlg_ok=1)
	//ファイルに書き出す
	$filePath:=JCL_file_MakeFilePath($folderPath; $namePtr->)
	$time:=Create document:C266($filePath)
	//プログレスバー
	JCL_pgs_DefInit
	$msg:="テキストファイル「"+$namePtr->+"」に書き出しています..."
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
	ARRAY TEXT:C222($aryFooterNames; 0)
	ARRAY POINTER:C280($aryFooterVers; 0)
	C_LONGINT:C283($footer_visible)
	
	LISTBOX GET ARRAYS:C832($lstbxPtr->; $aryColNames; $aryHeaderNames; $aryColVars; $aryHeaderVers; $aryColsVisible; \
		$aryStyles; $aryFooterNames; $aryFooterVers)
	$msg:="タイトル行を書き出しています..."
	JCL_pgs_SetValue(1; $msg; 1; 1)
	// ヘッダを出力
	For ($col; 1; $numOfCols)
		//非表示列は出力しない // 20220917
		If ($aryColsVisible{$col}=True:C214)
			$str:=OBJECT Get title:C1068(*; $aryHeaderNames{$col})
			$buf:=$buf+$str+$tabChar
		End if 
		
		//最後の列は最後のタブ文字を取り除いて改行を追加
		If ($col=$numOfCols)
			$buf:=$buf+$crlf
			
		End if 
	End for 
	SEND PACKET:C103($time; $buf)
	$buf:=""  //センドしたらバフをクリア
	
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
			//非表示列は出力しない // 20220917
			If ($aryColsVisible{$col}=True:C214)
				$str:=String:C10($aryColVars{$col}->{$row})  // データ型によってはエラーになる可能性がある、pictとか？
				//改行をストリップ
				$str:=Replace string:C233($str; $crlf; " ")
				$str:=Replace string:C233($str; $cr; " ")
				$str:=Replace string:C233($str; $lf; " ")
				$buf:=$buf+$str+$tabChar
				
			End if 
			If ($col=$numOfCols)
				$buf:=Substring:C12($buf; 1; Length:C16($buf)-1)  // 最後のタブを取る
				$buf:=$buf+$crlf  // 20221129 hisa wat 一番右側が非表示の場合、改行されない問題を修正
				
			End if 
			
		End for 
		SEND PACKET:C103($time; $buf)
		$buf:=""  //センドしたらバフをクリア
		
		$done:=JCL_pgs_IsCancel
		If ($done=True:C214)
			$row:=$numOfRows
		End if 
		
	End for 
	
	// フッターを出力 // 20220917 非表示なら出力しない
	$footer_visible:=LISTBOX Get property:C917($lstbxPtr->; lk display footer:K53:20)
	If ($footer_visible=1)
		For ($col; 1; $numOfCols)
			//非表示列は出力しない // 20220917
			If ($aryColsVisible{$col}=True:C214)
				$str:=String:C10($aryFooterVers{$col}->)  // データ型によってはエラーになる可能性がある 20210923
				$buf:=$buf+$str+$tabChar
			End if 
			
			//最後の列は最後のタブ文字を取り除いて改行を追加
			If ($col=$numOfCols)
				$buf:=$buf+$crlf
				
			End if 
		End for 
		SEND PACKET:C103($time; $buf)
		$buf:=""  //センドしたらバフをクリア
		
	End if 
	
	JCL_pgs_Cancel
	//ファイルを閉じる
	CLOSE DOCUMENT:C267($time)
	
End if 

$0:=$filePath
