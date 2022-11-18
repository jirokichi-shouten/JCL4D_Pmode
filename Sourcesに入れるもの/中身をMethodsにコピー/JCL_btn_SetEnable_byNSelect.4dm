//%attributes = {"shared":true}
  //JCL_btn_SetEnable_byNSelect
  //20130401 wat
  //リストボックスで1行以上選択されていればボタンはイネイブル

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //選択判定対象となるリストボックスのブーリアン配列
C_POINTER:C301($2;$inButtonPtr)
$inButtonPtr:=$2  //イネイブル対象となるボタンのポインタ
C_LONGINT:C283($selCnt)

  //リストで選択されている行が一つだけの場合にイネイブル、
  //そうでなければボタンはグレイ
$selCnt:=JCL_lst_SelectedCount ($inListBoxPtr)
If ($selCnt>=1)
	
	JCL_btn_SetEnable ($inButtonPtr;True:C214)
	
Else 
	
	JCL_btn_SetEnable ($inButtonPtr;False:C215)
	
End if 
