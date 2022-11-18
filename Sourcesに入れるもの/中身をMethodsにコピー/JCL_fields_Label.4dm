//%attributes = {}
  //JCL_fields_Label
  //20210210 ike wat
  //fieldsのテーブルプリフィックス＆フィールド名からTA_IDとか、からラベルを取得

C_TEXT:C284($1;$fldName)
$fldName:=$1
C_TEXT:C284($0;$label)
$label:=""

C_LONGINT:C283($index)

$index:=Find in array:C230(vJCL_fields_name;$fldName)
If ($index#-1)
	$label:=vJCL_fields_label{$index}
	
End if 

$0:=$label
