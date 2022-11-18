//%attributes = {"shared":true}
  //JCL_ary_FindInLike
  //20180829 wat
  //配列の中に入っているか、文字列の一部が入っていればOK
  //最初に見つかったインデックスを返す

C_POINTER:C301($1;$aryStrPtr)
$aryStrPtr:=$1
C_TEXT:C284($2;$findStr)
$findStr:=$2
C_LONGINT:C283($0;$index)
$index:=0

C_LONGINT:C283($i;$sizeOfAry)
$sizeOfAry:=Size of array:C274($aryStrPtr->)
For ($i;1;$sizeOfAry)
	
	$pos:=Position:C15($findStr;$aryStrPtr->{$i})
	If ($pos>0)
		
		$index:=$i
		$i:=$sizeOfAry
	End if 
	
End for 

$0:=$index
