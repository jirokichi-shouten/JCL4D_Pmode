//%attributes = {"shared":true}
  //JCL_lst_GetSelectedValues
  //JCL_lst_GetSelectedLongAry
  //20130128 wat
  //リストボックスの選択されている行の値配列を取得

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //リストボックスのブーリアン配列
C_POINTER:C301($2;$inAryPtr)
$inAryPtr:=$2  //リストに表示されているデータ配列のポインタ
C_POINTER:C301($3;$outAryPtr)
$outAryPtr:=$3  //選択されているデータ配列のポインタ（返す）
C_LONGINT:C283($0;$cnt)  //配列数
$cnt:=0

C_LONGINT:C283($selCnt)
C_LONGINT:C283($sizeOfAry;$i)

  //配列をクリア
DELETE FROM ARRAY:C228($outAryPtr->;1;Size of array:C274($outAryPtr->))

  //空行がクリックされたら、配列クリアのまま
$selCnt:=JCL_lst_SelectedCount ($inListBoxPtr)
If ($selCnt>=1)
	
	  //選択されている ID を取得
	$sizeOfAry:=Size of array:C274($inAryPtr->)
	For ($i;1;$sizeOfAry)
		
		If ($inListBoxPtr->{$i}=True:C214)
			
			APPEND TO ARRAY:C911($outAryPtr->;$inAryPtr->{$i})
			$cnt:=$cnt+1
			
		End if 
		
	End for 
	
End if 

$0:=$cnt
