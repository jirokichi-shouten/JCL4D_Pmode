//%attributes = {"shared":true}
  //JCL_file_CreatedOn
  //20160504 wat
  //ファイル作成日を取得

C_TEXT:C284($1;$file_path)
$file_path:=$1
C_DATE:C307($0)

C_BOOLEAN:C305($Locked;$invisible)
C_DATE:C307($created_on)
C_TIME:C306($created_at)
C_DATE:C307($modified_on)
C_TIME:C306($modified_at)
GET DOCUMENT PROPERTIES:C477($file_path;$Locked;$invisible;$created_on;$created_at;$modified_on;$modified_at)



$0:=$created_on
