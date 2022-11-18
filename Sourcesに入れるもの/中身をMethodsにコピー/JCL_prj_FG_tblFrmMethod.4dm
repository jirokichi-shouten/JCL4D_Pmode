//%attributes = {}
  //JCL_prj_FG_tblFrmMethod
  //20210217 ike wat
  //FormGenerator, フォームメソッドだけ作成
  //20210608 wat 引数をオブジェクト型に変更

C_OBJECT:C1216($1;$objFrm)
$objFrm:=$1
  //C_TEXT($1;$prefix)
  //$prefix:=$1
  //C_TEXT($2;$inputFrmName)
  //$inputFrmName:=$2
  //C_TEXT($3;$tblName)
  //$tblName:=$3
C_TEXT:C284($folderPath;$filePath)
C_TEXT:C284($body)
C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)
C_TEXT:C284($dateTimeStr)

  //日付時刻文字列を作成 20210601
$dateTimeStr:=JCL_str_dateTime (Current date:C33;Current time:C178)

  //ファイルの中身はメソッド名だけ
$body:="//"+$dateTimeStr+Char:C90(Carriage return:K15:38)
$body:=$body+$objFrm.prefix+"_frm"

  //ファイルに書き出し
$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Project")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"Sources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"TableForms")
$tblNr:=JCL_tbl_GetNumber ($objFrm.tblName)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$folderPath:=JCL_file_MakeFilePath ($folderPath;$tblNrText)
$outFolderPath:=JCL_file_MakeFilePath ($folderPath;$objFrm.frmName)
$outFilePath:=JCL_file_MakeFilePath ($outFolderPath;"method.4dm")
TEXT TO DOCUMENT:C1237($outFilePath;$body)
