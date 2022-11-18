//%attributes = {"shared":true}
  //JCL_lst_SelectAll
  //20160426 wat
  // リストボックスの行をすべて選択する

C_POINTER:C301($1;$lstbox_ptr)
$lstbox_ptr:=$1
C_LONGINT:C283($i;$sizeOfAry)

$sizeOfAry:=Size of array:C274($lstbox_ptr->)
For ($i;1;$sizeOfAry)
	
	LISTBOX SELECT ROW:C912($lstbox_ptr->;$i;Listbox add to selection)
	
End for 

OBJECT SET SCROLL POSITION:C906($lstbox_ptr->)
