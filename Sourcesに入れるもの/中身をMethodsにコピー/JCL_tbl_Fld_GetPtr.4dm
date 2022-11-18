//%attributes = {"shared":true}
  //JCL_tbl_Fld_GetPtr
  //JCL_tbl_GetFldPtr
  //20130120 wat
  //zz_tbl_GetIDFieldPtr
  //テーブルポインタからIDフィールドのポインタを獲る

C_POINTER:C301($1;$inTablePtr)
$inTablePtr:=$1  //テーブルポインタ
C_TEXT:C284($2;$search_str)
$search_str:=$2  //フィールド名
C_POINTER:C301($3;$outFieldPtrPtr)
$outFieldPtrPtr:=$3
C_LONGINT:C283($0;$retCode)
$retCode:=1  //error
C_LONGINT:C283($table_num)
C_TEXT:C284($field_name)
C_LONGINT:C283($numOfFields;$i)

  //テーブル番号を得る
$table_num:=Table:C252($inTablePtr)

  //フィールド情報取得
$numOfFields:=Get last field number:C255($inTablePtr)
For ($i;1;$numOfFields)
	
	If (Is field number valid:C1000($inTablePtr;$i)=True:C214)
		
		$field_name:=Field name:C257($table_num;$i)
		If ($search_str=$field_name)
			
			  //見つかった
			$outFieldPtrPtr->:=Field:C253($table_num;$i)
			$outFieldStr:=$field_name
			
			$i:=$numOfFields  //フォー文を抜ける
			$retCode:=0  // no error
			
		End if 
		
	End if 
	
End for 

$0:=$retCode
