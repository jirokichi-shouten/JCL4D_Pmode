//%attributes = {"shared":true}
  //JCL_lst_Selected_firstRow
  //JCL_lst_GetSelected_firstRow
  //20100623 wat new
  //リストボックスで選択されている最初の行番号を得る

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //ターゲットとなるリストボックスのブーリアン配列
C_LONGINT:C283($i;$numOfRows;$foundRow;$0)
$foundRow:=0
C_BOOLEAN:C305($found)

  //リストボックス配列から選択行を得る
$numOfRows:=JCL_lst_Count ($inListBoxPtr)
$i:=1
$found:=False:C215
While (($i<=$numOfRows) & ($found=False:C215))
	
	If ($inListBoxPtr->{$i}=True:C214)
		
		  //最初に見つかった、選択されている行
		$foundRow:=$i
		$found:=True:C214  //これでループを抜ける
		
	End if 
	
	$i:=$i+1
	
End while 

$0:=$foundRow
