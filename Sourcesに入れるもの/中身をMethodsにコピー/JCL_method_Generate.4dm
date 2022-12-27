//%attributes = {"shared":true}
//JCL_method_Generate
//20130318 yabe
//外部テキストファイルのフィールド定義を読み込んでメソッド作成
//メソッドが既にある場合削除しない。
//20150826 yabe フォーム作成フラグ追加

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル
ARRAY TEXT:C222($aryTableName; 0)  //テーブル名の配列
ARRAY LONGINT:C221($aryStartLineNr; 0)  //テーブル定義始まりの行番号の配列
ARRAY TEXT:C222($aryPrefix; 0)  //フィールド名のプリフィックスの配列
ARRAY TEXT:C222($aryFormsFlag; 0)  //20150826 フォームを作るかどうかのフラグの配列「フォーム作る」なら作成
C_LONGINT:C283($i; $numOfTables)
C_TEXT:C284($dir)
ARRAY TEXT:C222($aryFileName; 0)  //の配列
ARRAY TEXT:C222($aryFileContents; 0)  //の配列
C_TEXT:C284($buf)
C_BLOB:C604($blob)
C_LONGINT:C283($tableCount)
$tableCount:=0

//定義ファイル「fields」を選択
//ファイルオープンダイアログ
$dlg_ok:=JCL_file_SelectFileDlg(->$fileBlob)

If ($dlg_ok=1)
	
	//読み込んだファイルの内容を4Dの文字セットにエンコード
	$fileText:=Convert to text:C1012($fileBlob; "UTF-8")
	
	////改行コードをCRに統一する 20130318 add yabe
	//$fileText:=Replace string($fileText; Char(Line feed); Char(Carriage return))  //ラインフィードをキャリッジリターンに置き換える
	//$fileText:=Replace string($fileText; Char(Carriage return)+Char(Carriage return); Char(Carriage return))  //２つのキャリッジリターンを１つのキャリッジリターンに置き換える
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221227//LFに統一するようにした
	
	//テンプレートファイルフォルダを選択
	$dir:=Select folder:C670("")
	DOCUMENT LIST:C474($dir; $aryFileName)
	For ($i; 1; Size of array:C274($aryFileName))
		
		//v14
		DOCUMENT TO BLOB:C525($dir+$aryFileName{$i}; $blob)
		$buf:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
		
		APPEND TO ARRAY:C911($aryFileContents; $buf)
		
	End for 
	
	//テーブル名の配列を得る
	$numOfTables:=JCL_tbl_Names_fromFile($fileText; ->$aryTableName; ->$aryStartLineNr; ->$aryPrefix; ->$aryFormsFlag)
	
	For ($i; 1; $numOfTables)
		If ($aryFormsFlag{$i}#"NoForm")  // フォーム作らない, NoForm 
			//If ($aryFormsFlag{$i}="フォーム作る")
			//メソッドを作成
			JCL_method_GenerateOne($fileText; $aryTableName{$i}; $aryStartLineNr{$i}; $aryPrefix{$i}; ->$aryFileName; ->$aryFileContents)
		End if 
	End for 
	
	//２回メソッドを作成することで、4Dの自動認識機能をオンにする。
	For ($i; 1; $numOfTables)
		If ($aryFormsFlag{$i}#"NoForm")
			//If ($aryFormsFlag{$i}="フォーム作る")
			$tableCount:=$tableCount+1
			//メソッドを作成
			JCL_method_GenerateOne($fileText; $aryTableName{$i}; $aryStartLineNr{$i}; $aryPrefix{$i}; ->$aryFileName; ->$aryFileContents)
		End if 
	End for 
	
	C_TEXT:C284($msg)
	$msg:="完了"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+String:C10($tableCount)+"/"+String:C10($numOfTables)+"個のテーブル分のメソッドを作成しました。"
	ALERT:C41($msg)
	
End if 
