//%attributes = {"shared":true}
  //JCL_tbl_GetPtr_byName
  //20130119 wat
  //テーブル名からポインタを返す

  //JCL_tbl_GetPtr_byName
  //20111103 wat
  //テーブルポインタを取得

C_TEXT:C284($1;$inTblName)
$inTblName:=$1
C_POINTER:C301($0;$outTblPtr)
C_TEXT:C284($tblName)
C_POINTER:C301($tblPtr)
C_LONGINT:C283($numOfTables;$i)

$numOfTables:=Get last table number:C254

For ($i;1;$numOfTables)
	
	If (Is table number valid:C999($i)=True:C214)
		
		$tblPtr:=Table:C252($i)
		$tblName:=Table name:C256($i)
		If ($tblName=$inTblName)
			
			$outTblPtr:=$tblPtr
			
		End if 
		
	End if 
	
End for 

$0:=$outTblPtr
