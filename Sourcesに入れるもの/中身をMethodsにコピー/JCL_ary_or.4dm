//%attributes = {"shared":true}
  //JCL_ary_or
  //20170222 wat
  //  配列の OR を作成
  //20171109 wat 条件が間違っていたので修正

C_POINTER:C301($1;$ary1ptr)
$ary1ptr:=$1  // 比較配列
C_POINTER:C301($2;$ary2ptr)
$ary2ptr:=$2  // 比較配列
C_POINTER:C301($3;$ary3ptr)
$ary3ptr:=$3  // 結果配列
C_LONGINT:C283($i;$sizeOfAry)

  // まず結果配列をクリア
DELETE FROM ARRAY:C228($ary3ptr->;1;Size of array:C274($ary3ptr->))

  // 配列１を配列３にコピー
COPY ARRAY:C226($ary1ptr->;$ary3ptr->)

$sizeOfAry:=Size of array:C274($ary2ptr->)
For ($i;1;$sizeOfAry)
	
	  // 配列３に配列２の要素がなかっtら追加
	$index:=Find in array:C230($ary1ptr->;$ary2ptr->{$i})
	If ($index<=0)
		
		  // なかった要素だけを結果に追加
		APPEND TO ARRAY:C911($ary3ptr->;$ary2ptr->{$i})
		
	End if 
	
End for 

