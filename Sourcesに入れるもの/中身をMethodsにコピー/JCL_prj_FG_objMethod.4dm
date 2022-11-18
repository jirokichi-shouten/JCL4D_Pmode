//%attributes = {}
  //JCL_prj_FG_objMethod
  //20210317 ike wat
  //FormGenerator, オブジェクトメソッド作成
  //20210608 wat 引数をオブジェクト型に変更

C_OBJECT:C1216($1;$objFrm)
$objFrm:=$1
C_TEXT:C284($2;$objName)
$objName:=$2
C_TEXT:C284($tmpPath;$filePath)
C_TEXT:C284($body)
C_TEXT:C284($methodName)

  //ファイルに書き出し
$tmpPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Project")
$tmpPath:=JCL_file_MakeFilePath ($tmpPath;"Sources")
$tmpPath:=JCL_file_MakeFilePath ($tmpPath;"Forms")
$tmpPath:=JCL_file_MakeFilePath ($tmpPath;$objFrm.frmName)
$outFolderPath:=JCL_file_MakeFilePath ($tmpPath;"ObjectMethods")
$methodName:="v"+$objFrm.prefix+$objName+".4dm"
  //ファイルの中身はメソッド名だけ
$body:=$objFrm.prefix+$objName

$outFilePath:=JCL_file_MakeFilePath ($outFolderPath;$methodName)
TEXT TO DOCUMENT:C1237($outFilePath;$body)
