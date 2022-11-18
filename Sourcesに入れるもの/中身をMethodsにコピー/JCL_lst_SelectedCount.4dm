//%attributes = {"shared":true}
  //JCL_lst_SelectedCount
  //JCL_lst_SelectedCount
  //20100623 wat
  //リストボックスに選択されている行が何行あるか返す。汎用メソッド

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //ターゲットとなるリストボックスのブーリアン配列
C_LONGINT:C283($0;$cnt)

$cnt:=Count in array:C907($inListBoxPtr->;True:C214)

$0:=$cnt
