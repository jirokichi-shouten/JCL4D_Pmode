//%attributes = {"shared":true}
  //JCL_tbl_DropAllTables
  //20111005 wat
  //すべてのテーブルを削除

C_LONGINT:C283($0;$cnt)
$cnt:=0
C_LONGINT:C283($numOfTables;$i)
C_TEXT:C284($table_name)
C_TEXT:C284($sql)

$numOfTables:=Get last table number:C254

For ($i;1;$numOfTables)
	
	If (Is table number valid:C999($i)=True:C214)
		
		$table_name:=Table name:C256($i)
		If ($table_name#"")  //wat_add 20111005
			
			$sql:="DROP TABLE "+$table_name+";"
			SQL LOGIN:C817(SQL_INTERNAL:K49:11;"";"")
			SQL EXECUTE:C820($sql)
			SQL LOGOUT:C872
			
			$cnt:=$cnt+1
			
		End if 
		
	End if 
	
End for 

$0:=$cnt
