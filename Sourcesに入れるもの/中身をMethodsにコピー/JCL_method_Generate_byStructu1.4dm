//%attributes = {}
  //JCL_method_Generate_byStructure
  //20210106 - 20210107 ike wat
  //手入力のテーブル名を元に、テーブル定義から、メソッド群を作成、フォームプリフィックスは手入力
  //外部テキストファイルのフィールド定義を読み込んでメソッド作成
  //メソッドが既にある場合上書きになる。
  //usage
  // 1) リストボックスを作成、たとえばTA01のリストボックスTA01_lstTAをコピーして持ってきて、PM03_lstTAを作成
  // 2) オンロードメソッドPM03_frmOnloadに、PM03_frmDefInit_TA, PM03_lstTA_Make, PM03_lstTA_SetControlsValuesを追記
  // 3) リストボックスのオブジェクトメソッドを変更
  // 4) 選択行の$ta_idについてセッターゲッターを用意
  // 5) PM03_lstPM_Makeに$ta_idをゲッターで取得してクエリーに渡して絞り込む


C_LONGINT:C283($i;$sizeOfAry)
C_TEXT:C284($dir)
ARRAY TEXT:C222($aryFileName;0)  //の配列
ARRAY TEXT:C222($aryFileContents;0)  //の配列
C_TEXT:C284($buf)
C_BLOB:C604($blob)  //読み込んだテンプレートのブロブ
C_TEXT:C284($inputTblName;$inputFrmPrefix;$tablePrefix)

$inputFrmPrefix:=Request:C163("フォームのプリフィックスを入力：PM03とか")  //フィールド名のプリフィックス
$inputTblName:=Request:C163("PM03にTAのリストを作る時、テーブル名を入力：taikaiとか")  //テーブル名

$tablePrefix:=JCL_tbl_GetPrefix_fromStructure ($inputTblName)
If (OK=1)
	  //テンプレートファイルフォルダを選択
	$dir:=Select folder:C670("")
	DOCUMENT LIST:C474($dir;$aryFileName;Ignore invisible:K24:16)  //.DS_Storeを除く
	$sizeOfAry:=Size of array:C274($aryFileName)
	For ($i;1;$sizeOfAry)
		  //v14
		DOCUMENT TO BLOB:C525($dir+$aryFileName{$i};$blob)
		$buf:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
		
		APPEND TO ARRAY:C911($aryFileContents;$buf)
		
	End for 
	
	  //メソッドを作成
	JCL_method_GenerateOne_byStruct ($inputFrmPrefix;$inputTblName;$tablePrefix;->$aryFileName;->$aryFileContents)
	
	  //２回メソッドを作成することで、4Dの自動認識機能をオンにする。  //メソッドを作成
	JCL_method_GenerateOne_byStruct ($inputFrmPrefix;$inputTblName;$tablePrefix;->$aryFileName;->$aryFileContents)
	
	C_TEXT:C284($msg)
	$msg:="完了"+Char:C90(Carriage return:K15:38)
	$msg:=$msg+String:C10($sizeOfAry)+"個のメソッドを作成しました。"
	ALERT:C41($msg)
	
End if 
