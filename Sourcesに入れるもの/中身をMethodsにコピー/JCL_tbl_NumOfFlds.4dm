//%attributes = {}
//JCL_tbl_NumOfFlds
//20221013 wat
//有効なフィールド数を取得

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1
C_LONGINT:C283($0; $validFldCnt)
$validFldCnt:=0
C_LONGINT:C283($numOfFields; $i)

//テーブル番号を得る
$table_num:=Table:C252($tblPtr)

//フィールド情報取得
$numOfFields:=Get last field number:C255($tblPtr)
For ($i; 1; $numOfFields)
	
	If (Is field number valid:C1000($tblPtr; $i)=True:C214)
		//フィールドが有効ならカウントアップ
		$validFldCnt:=$validFldCnt+1
		
		
	End if 
End for 


$0:=$validFldCnt
