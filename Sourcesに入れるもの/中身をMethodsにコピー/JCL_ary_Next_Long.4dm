//%attributes = {"shared":true}
  //JCL_ary_GetNext_Long
  //20140603 wat
  //配列で、次のロングバリューを返す

C_POINTER:C301($1;$inDataAryPtr)
$inDataAryPtr:=$1  //ロングデータ配列のポインタ
C_LONGINT:C283($2;$inLongValue)
$inLongValue:=$2  //ロングバリュー
C_LONGINT:C283($0;$outLongValue)  //ロングのリターンバリュー
$outLongValue:=0
C_LONGINT:C283($pos;$sizeOfAry)

$sizeOfAry:=Size of array:C274($inDataAryPtr->)

$pos:=Find in array:C230($inDataAryPtr->;$inLongValue)
If ($pos#-1)
	
	If ($pos=$sizeOfAry)
		
		$pos:=$pos
		
	Else 
		
		$pos:=$pos+1
		
	End if 
	
	$outLongValue:=$inDataAryPtr->{$pos}
	
	  //見つからないってことはあり得ない
	
End if 

$0:=$outLongValue
