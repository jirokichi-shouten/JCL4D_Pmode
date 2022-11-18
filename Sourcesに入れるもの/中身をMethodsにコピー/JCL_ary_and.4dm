//%attributes = {"shared":true}
  //JCL_ary_and
  //20170206 wat
  //  配列のANDを作成

C_POINTER:C301($1;$ary1ptr)
$ary1ptr:=$1  // 比較配列
C_POINTER:C301($2;$ary2ptr)
$ary2ptr:=$2  // 比較配列
C_POINTER:C301($3;$ary3ptr)
$ary3ptr:=$3  // 結果配列
C_LONGINT:C283($i;$sizeOfAry)
C_LONGINT:C283($0;$cnt)
$cnt:=0

  // まず結果配列をクリア
DELETE FROM ARRAY:C228($ary3ptr->;1;Size of array:C274($ary3ptr->))

$sizeOfAry:=Size of array:C274($ary2ptr->)
For ($i;1;$sizeOfAry)
	
	$index:=Find in array:C230($ary1ptr->;$ary2ptr->{$i})
	If ($index>0)
		
		  // どちらにもあった要素だけを結果に追加
		APPEND TO ARRAY:C911($ary3ptr->;$ary2ptr->{$i})
		$cnt:=$cnt+1
		
	End if 
	
End for 

$0:=$cnt
