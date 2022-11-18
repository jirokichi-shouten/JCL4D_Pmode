//%attributes = {"shared":true}
  //JCL_file_GetFromResourcesFolder
  //20180122 wat
  //リソースフォルダの　所定のフォルダから　所定のファイルを 所定のエンコードで取得

C_TEXT:C284($1;$inFolder)
$inFolder:=$1
C_TEXT:C284($2;$inFileName)
$inFileName:=$2
C_TEXT:C284($3;$inEncode)
$inEncode:=$3
C_TEXT:C284($fileText;$0)
$fileText:=""
C_TEXT:C284($folderPath;$filePath)
C_BLOB:C604($blob)

$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Current resources folder:K5:16);$inFolder)
$filePath:=JCL_file_MakeFilePath ($folderPath;$inFileName)

  //ファイルの内容を読み込んで　エンコード
DOCUMENT TO BLOB:C525($filePath;$blob)
$fileText:=Convert to text:C1012($blob;$inEncode)

$0:=$fileText
