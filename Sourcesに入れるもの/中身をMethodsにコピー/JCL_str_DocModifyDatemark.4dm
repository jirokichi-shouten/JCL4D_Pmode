//%attributes = {}
//JCL_str_DocModifyDatemark
//20220106 wat
//ドキュメントの作成日と時間をデイとマークで返す

C_TEXT:C284($1; $fullPath)
$fullPath:=$1
C_TEXT:C284($0; $datemark)
$datemark:=""

C_BOOLEAN:C305($locked; $invisible)
C_DATE:C307($created_on; $modified_on)
C_TIME:C306($created_at; $modified_at)

//
GET DOCUMENT PROPERTIES:C477($fullPath; $locked; $invisible; $created_on; $created_at; $modified_on; $modified_at)

$datemark:=JCL_str_Datemark($modified_on; $modified_at)

$0:=$datemark
