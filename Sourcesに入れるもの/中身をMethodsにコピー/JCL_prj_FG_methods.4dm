//%attributes = {}
  //JCL_prj_FG_methods
  //20210608 wat
  //メソッドジェネレータ、フォーム構造体をもらって、テンプレートからメソッド群を作成

C_OBJECT:C1216($1;$objFrm)
$objFrm:=$1
  //JCL_prj_FG_methods_list
  //20210224 ike wat
  //FormGenerator, リスト用メソッドテンプレートから一連のメソッドを作成
  //20210510 wat テンプレートの場所を固定

C_POINTER:C301($2;$aryFieldNamePtr)
$aryFieldNamePtr:=$2
C_POINTER:C301($3;$aryFieldTypePtr)
$aryFieldTypePtr:=$3
C_TEXT:C284($templateFolderPath;$filePath)
C_BLOB:C604($blob)
C_TEXT:C284($body)
ARRAY TEXT:C222($aryFileName;0)  //の配列
C_TEXT:C284($templateFileName;$templateFilePath)

  //テンプレートフォルダの場所
$templateFolderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Resources")
$templateFolderPath:=JCL_file_MakeFilePath ($templateFolderPath;"JCL4D_Resources")
$templateFolderPath:=JCL_file_MakeFilePath ($templateFolderPath;$objFrm.method_templates)
DOCUMENT LIST:C474($templateFolderPath;$aryFileName;Ignore invisible:K24:16)  //.DS_Storeを除く
For ($i;1;Size of array:C274($aryFileName))
	  //テンプレートの中身を取得
	$templateFileName:=$aryFileName{$i}
	$templateFilePath:=JCL_file_MakeFilePath ($templateFolderPath;$aryFileName{$i})
	DOCUMENT TO BLOB:C525($templateFilePath;$blob)
	$body:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
	
	  // タグを置き換えて、所定のフォルダに書き出す
	JCL_prj_FG_methods_One ($body;$objFrm.tblName;$objFrm.prefix;$templateFileName;$aryFieldNamePtr;$aryFieldTypePtr)
	
End for 
