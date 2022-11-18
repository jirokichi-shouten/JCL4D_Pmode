//%attributes = {"shared":true}
  //JCL_ary_concat
  //20170206 wat
  // 配列と配列を　連結して　配列に追加して返す　親でアロケート

C_POINTER:C301($1;$aryResultPtr)
$aryResultPtr:=$1  // 結果配列、渡された時に要素があればそのあとに追加
C_POINTER:C301($2;$aryPtr)
$aryPtr:=$2  // 追加する配列
C_LONGINT:C283($0;$cnt)
$cnt:=0
C_LONGINT:C283($i;$sizeOfAry)

$sizeOfAry:=Size of array:C274($aryPtr->)
For ($i;1;$sizeOfAry)
	
	APPEND TO ARRAY:C911($aryResultPtr->;$aryPtr->{$i})
	$cnt:=$cnt+1
	
End for 

$0:=$sizeOfAry
