//%attributes = {}
  //JCL_D01_popTableName_make
  //20210607 wat
  //テーブル名をポップアップリストに表示するための配列

C_LONGINT:C283($0;$cnt)
$cnt:=0
C_LONGINT:C283($numOfTables;$i)
C_TEXT:C284($table_name)

APPEND TO ARRAY:C911(vJCL_D01_aryTableName;"")

  //テーブル数を取得
$numOfTables:=Get last table number:C254
For ($i;1;$numOfTables)
	If (Is table number valid:C999($i)=True:C214)
		  //テーブル名を取得して配列に格納
		$table_name:=Table name:C256($i)
		If ($table_name#"")  //wat_add 20111005
			
			APPEND TO ARRAY:C911(vJCL_D01_aryTableName;$table_name)
			$cnt:=$cnt+1
			
		End if 
	End if 
End for 
