//%attributes = {"shared":true}
//JCL_tbl_Fields_withAttr
//JCL_tbl_GetFields
//20130430 yabe
//フィールド属性を配列で返す
// 20220516 hisa wat valid検知を追加、削除されているテーブルがあるとエラーになるため。

C_TEXT:C284($1; $tableName)
$tableName:=$1
C_POINTER:C301($2; $ioAryFieldName)
$ioAryFieldName:=$2
C_POINTER:C301($3; $ioAryFieldType)
$ioAryFieldType:=$3
C_POINTER:C301($4; $ioAryFieldLength)
$ioAryFieldLength:=$4
C_POINTER:C301($5; $ioAryFieldIndex)
$ioAryFieldIndex:=$5

C_LONGINT:C283($i; $numOfTables)
C_LONGINT:C283($k; $numOfFields)
C_TEXT:C284($name)
C_LONGINT:C283($type)
C_LONGINT:C283($len)
C_BOOLEAN:C305($index)
C_BOOLEAN:C305($unique)
C_BOOLEAN:C305($visible)
C_TEXT:C284($tbName)

DELETE FROM ARRAY:C228($ioAryFieldName->; 1; Size of array:C274($ioAryFieldName->))
DELETE FROM ARRAY:C228($ioAryFieldType->; 1; Size of array:C274($ioAryFieldType->))
DELETE FROM ARRAY:C228($ioAryFieldLength->; 1; Size of array:C274($ioAryFieldLength->))
DELETE FROM ARRAY:C228($ioAryFieldIndex->; 1; Size of array:C274($ioAryFieldIndex->))

$numOfTables:=Get last table number:C254

For ($i; 1; $numOfTables)
	
	If (Is table number valid:C999($i)=True:C214)  // 20220516 hisa wat
		
		$tbName:=Table name:C256($i)
		If ($tbName=$tableName)
			$numOfFields:=Get last field number:C255($i)
			
			For ($k; 1; $numOfFields)
				$name:=Field name:C257($i; $k)
				GET FIELD PROPERTIES:C258($i; $k; $type; $len; $index; $unique; $visible)
				
				APPEND TO ARRAY:C911($ioAryFieldName->; $name)
				APPEND TO ARRAY:C911($ioAryFieldType->; JCL_tbl_Type($type))
				APPEND TO ARRAY:C911($ioAryFieldLength->; String:C10($len))
				APPEND TO ARRAY:C911($ioAryFieldIndex->; String:C10(Num:C11($index); "1;;0"))
				
			End for 
		End if 
		
	End if 
	
End for 