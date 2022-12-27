//%attributes = {"shared":true}
//JCL_tbl_import
//JCL_import_tables
//20111005 wat
//20121001 wat rename, 20130429 wat mod
//外部テキストファイルのフィールド定義を読み込んでテーブル作成
//20150826 yabe フォーム作成フラグ追加
//20210811 ike wat 改行コードをCRに統一する、全角文字を置き換える
//20221227 ike wat 改行コード統一をLFに変更、GitでテンプレートがLFにされてしまったため

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
ARRAY TEXT:C222($aryTableName; 0)  //テーブル名の配列
ARRAY LONGINT:C221($aryStartLineNr; 0)  //テーブル定義始まりの行番号の配列
ARRAY TEXT:C222($aryPrefix; 0)  //フィールド名のプリフィックスの配列
ARRAY TEXT:C222($aryFormsFlag; 0)  //20150826 フォームを作るかどうかのフラグの配列「フォーム作る」なら作成
C_LONGINT:C283($i; $numOfTables)

//定義ファイルを選択
$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)
If ($dlg_ok=1)
	//読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227
	$fileText:=Replace string:C233($fileText; "　"; " ")  //全角文字を置き換える
	$fileText:=Replace string:C233($fileText; "＿"; "_")  //全角文字を置き換える
	If ($fileText#"")
		//読み込んだファイルが空でなければ
		//テーブル名の配列を得る
		$numOfTables:=JCL_tbl_Names_fromFile($fileText; ->$aryTableName; ->$aryStartLineNr; ->$aryPrefix; ->$aryFormsFlag)
		For ($i; 1; $numOfTables)
			//テーブルを作成
			JCL_tbl_Create_bySQL($fileText; $aryTableName{$i}; $aryStartLineNr{$i}; $aryPrefix{$i})
			
			//インデックスを作成
			JCL_tbl_Index_create($fileText; $aryTableName{$i}; $aryStartLineNr{$i}; $aryPrefix{$i})
			
			//モデルメソッド群をテンプレートから作成 20211228
			JCL_tbl_Create_method($aryTableName{$i}; $aryPrefix{$i})
			
		End for 
		
		C_TEXT:C284($msg)
		$msg:="完了"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+String:C10($numOfTables)+"個のテーブルを作成しました。"
		ALERT:C41($msg)
		
	End if 
End if 
