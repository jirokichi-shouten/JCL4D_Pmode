//%attributes = {}
//JCL_tbl_GetNumber
//20210330 ike wat
//テーブル名からテーブル番号を得る
//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。

C_TEXT:C284($1; $inTableName)
$inTableName:=$1
C_LONGINT:C283($0; $outTblNr)
$outTblNr:=0
C_LONGINT:C283($i; $numOfTables)
C_BOOLEAN:C305($isValid)

$numOfTables:=Get last table number:C254
For ($i; 1; $numOfTables)
	$isValid:=Is table number valid:C999($i)
	If ($isValid=True:C214)
		If (Table name:C256($i)=$inTableName)
			$outTblNr:=$i
			
		End if 
	End if 
End for 


$0:=$outTblNr
