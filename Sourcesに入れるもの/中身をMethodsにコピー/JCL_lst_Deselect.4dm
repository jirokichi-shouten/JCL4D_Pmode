//%attributes = {"shared":true}
  //JCL_lst_Deselect
  //20100831wat new
  //デセレクト専用コマンド

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //ターゲットリストボックスのブーリアン配列

  //デセレクト
LISTBOX SELECT ROW:C912($inListBoxPtr->;0;lk remove from selection:K53:3)
