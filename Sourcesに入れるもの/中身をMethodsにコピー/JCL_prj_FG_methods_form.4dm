//%attributes = {}
  //JCL_prj_FG_methods_form
  //20210510 wat
  //FormGenerator, フォーム用メソッドテンプレートから一連のメソッドを作成

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
C_TEXT:C284($folderPath;$filePath)
C_BLOB:C604($blob)
C_TEXT:C284($body)
ARRAY TEXT:C222($aryFileName;0)  //の配列
C_TEXT:C284($fileName)

  //テンプレートフォルダの場所
$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Resources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"JCL4D_Resources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"method_templates_form")
DOCUMENT LIST:C474($folderPath;$aryFileName;Ignore invisible:K24:16)  //.DS_Storeを除く
For ($i;1;Size of array:C274($aryFileName))
	  //テンプレートの中身を取得
	$fileName:=JCL_file_MakeFilePath ($folderPath;$aryFileName{$i})
	  //$fileName:=$aryFileName{$i}
	DOCUMENT TO BLOB:C525($fileName;$blob)
	$body:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
	
	  // タグを置き換えて、所定のフォルダに書き出す
	JCL_prj_FG_methods_One ($body;$inputTblName;$prefix;$fileName;$aryFieldNamePtr;$aryFieldTypePtr)
	
End for 
