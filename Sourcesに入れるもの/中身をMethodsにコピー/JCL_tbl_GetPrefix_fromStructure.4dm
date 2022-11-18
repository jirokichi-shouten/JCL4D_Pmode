//%attributes = {}
//JCL_tbl_GetPrefix_fromStructure
//20210106 wat
//テーブル名からテーブルプリフィックスを取得
//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。

C_TEXT:C284($1; $tableName)
$tableName:=$1
C_TEXT:C284($0; $prefix)
$prefix:=""
C_LONGINT:C283($i; $numOfTables)
C_LONGINT:C283($pos)
C_BOOLEAN:C305($isValid)

$numOfTables:=Get last table number:C254
For ($i; 1; $numOfTables)
	
	$isValid:=Is table number valid:C999($i)
	If ($isValid=True:C214)
		If ($tableName=Table name:C256($i))
			$fieldName:=Field name:C257($i; 1)
			$pos:=Position:C15("_"; $fieldName)
			$prefix:=Substring:C12($fieldName; 1; $pos-1)
			
		End if 
	End if 
End for 

$0:=$prefix
