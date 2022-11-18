//%attributes = {"shared":true}
//JCL_tbl_Names_fromStructure
//JCL_tbl_GetTableNameAry
//20130430 yabe
//テーブル名配列を返す
//20220430 wat valid検知を追加、削除されているテーブルがあるとエラーになるため。

C_POINTER:C301($1; $ioAryTableNamePtr)
$ioAryTableNamePtr:=$1
C_LONGINT:C283($i; $numOfTables)
C_TEXT:C284($tblName)
C_BOOLEAN:C305($isValid)

DELETE FROM ARRAY:C228($ioAryTableNamePtr->; 1; Size of array:C274($ioAryTableNamePtr->))

$numOfTables:=Get last table number:C254

For ($i; 1; $numOfTables)
	
	$isValid:=Is table number valid:C999($i)
	If ($isValid=True:C214)
		$tblName:=Table name:C256($i)
		
		APPEND TO ARRAY:C911($ioAryTableNamePtr->; $tblName)
		
	End if 
End for 
