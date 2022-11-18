//%attributes = {"shared":true}
  //JCL_tbl_Prefix
  //JCL_tbl_GetTablePrefix
  //20130430 yabe
  //フィールド名からテーブル略称を取得
  //すべてのフィールド名を先頭文字から比較していき、一致している部分をプレフィックスとみなす。
  //たとえばTA_ID、TA_NAME、、、となると、TA_までは完全一致するのでそこがプレフィックスと判る。

C_POINTER:C301($1;$inAryFieldName)
$inAryFieldName:=$1
C_TEXT:C284($0;$tablePrefix)
$tablePrefix:=""

C_LONGINT:C283($i;$numOfFields)
C_BOOLEAN:C305($loop)
C_LONGINT:C283($pos)
C_TEXT:C284($char1;$char2)
$pos:=1
$loop:=True:C214

$numOfFields:=Size of array:C274($inAryFieldName->)

If ($numOfFields>=2)
	
	$len:=Length:C16($inAryFieldName->{1})
	
	While (($loop=True:C214) & ($pos<$len))
		
		$char1:=Substring:C12($inAryFieldName->{1};$pos;1)
		
		For ($i;1;$numOfFields)
			
			$char2:=Substring:C12($inAryFieldName->{$i};$pos;1)
			
			If ($char1#$char2)
				
				$loop:=False:C215
				
			End if 
			
			If ($i=$numOfFields)
				
				If ($loop=True:C214)
					
					$tablePrefix:=$tablePrefix+$char1
					
				End if 
				
			End if 
			
		End for 
		
		$pos:=$pos+1
		
	End while 
	
End if 

$0:=$tablePrefix