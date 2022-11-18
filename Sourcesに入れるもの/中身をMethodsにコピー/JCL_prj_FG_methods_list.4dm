//%attributes = {}
  //JCL_prj_FG_methods_list
  //20210224 ike wat
  //FormGenerator, リスト用メソッドテンプレートから一連のメソッドを作成
  //20210510 wat テンプレートの場所を固定

C_TEXT:C284($1;$prefix)
$prefix:=$1
C_TEXT:C284($2;$inputFrmName)
$inputFrmName:=$2
C_TEXT:C284($3;$inputTblName)
$inputTblName:=$3
C_POINTER:C301($4;$aryFieldNamePtr)
$aryFieldNamePtr:=$4
C_POINTER:C301($5;$aryFieldTypePtr)
$aryFieldTypePtr:=$5
C_TEXT:C284($templateFolderPath;$filePath)
C_BLOB:C604($blob)
C_TEXT:C284($body)
ARRAY TEXT:C222($aryFileName;0)  //の配列
C_TEXT:C284($templateFileName;$templateFilePath)

  //テンプレートフォルダの場所
$templateFolderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Resources")
$templateFolderPath:=JCL_file_MakeFilePath ($templateFolderPath;"JCL4D_Resources")
$templateFolderPath:=JCL_file_MakeFilePath ($templateFolderPath;"method_templates_list")
  //ALERT($templateFolderPath)

  //メッセージ表示
  //C_TEXT($title;$msg;$ok_str)
  //$title:="JCL_prj_FG_methods_list"
  //$msg:="次のセレクトダイアログで、テンプレートファイルフォルダを選択"
  //$ok_str:="OK"
  //JCL_dlg_Inform ($title;$msg;$ok_str)

  //テンプレートファイルフォルダを選択
  //$dir:=Select folder("")
  //ALERT($templateFolderPath+Char(13)+Char(13)+$dir)
  //DOCUMENT LIST($dir;$aryFileName;Ignore invisible)  //.DS_Storeを除く
DOCUMENT LIST:C474($templateFolderPath;$aryFileName;Ignore invisible:K24:16)  //.DS_Storeを除く
For ($i;1;Size of array:C274($aryFileName))
	  //テンプレートの中身を取得
	$templateFileName:=$aryFileName{$i}
	$templateFilePath:=JCL_file_MakeFilePath ($templateFolderPath;$aryFileName{$i})
	DOCUMENT TO BLOB:C525($templateFilePath;$blob)
	$body:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
	
	  // タグを置き換えて、所定のフォルダに書き出す
	JCL_prj_FG_methods_One ($body;$inputTblName;$prefix;$templateFileName;$aryFieldNamePtr;$aryFieldTypePtr)
	
End for 
