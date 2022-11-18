//%attributes = {"shared":true}
  //JCL_tbl_GenerateSQL
  //20130109 wat
  //フィールド定義の外部テキストファイルを読んで、SQL文を書き出す
  //20150826 yabe フォーム作成フラグ追加

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
ARRAY TEXT:C222($aryTableName;0)  //テーブル名の配列
ARRAY LONGINT:C221($aryStartLineNr;0)  //テーブル定義始まりの行番号の配列
ARRAY TEXT:C222($aryPrefix;0)  //フィールド名のプリフィックスの配列
ARRAY TEXT:C222($aryFormsFlag;0)  //20150826 フォームを作るかどうかのフラグの配列「フォーム作る」なら作成
C_LONGINT:C283($i;$numOfTables)

  //定義ファイルを選択
  //ファイルオープンダイアログ
$dlg_ok:=JCL_file_SelectFileDlg (->$fileBlob)
If ($dlg_ok=1)
	
	  //読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob;"UTF-8")
	
	  //テーブル名の配列を得る
	$numOfTables:=JCL_tbl_Names_fromFile ($fileText;->$aryTableName;->$aryStartLineNr;->$aryPrefix;->$aryFormsFlag)
	For ($i;1;$numOfTables)
		
		  //テーブルを作成
		JCL_tbl_ExportOneSQL ($fileText;$aryTableName{$i};$aryStartLineNr{$i};$aryPrefix{$i})
		
	End for 
	
	C_TEXT:C284($msg)
	$msg:=String:C10($numOfTables)+"個のテーブルについてSQL文を作成しました。"
	JCL_dlg_Inform ("完了";$msg;"OK")
	
End if 

