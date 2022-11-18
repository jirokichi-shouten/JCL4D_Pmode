//%attributes = {}
  //JCL_fields_cache_TableLabel
  //20210310 ike wat
  //キャッシュからテーブルラベルを取得

C_TEXT:C284($1;$inputTblName)
$inputTblName:=$1
C_TEXT:C284($0;$label)
$label:=""
C_LONGINT:C283($index)

$index:=Find in array:C230(vJCL_fields_tblName;$inputTblName)
If ($index#-1)
	$label:=vJCL_fields_tblLabel{$index}
	
Else 
	$label:="unkown"
	
End if 

$0:=$label
