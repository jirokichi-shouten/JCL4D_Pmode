//%attributes = {"shared":true}
  //JCL_lst_SetSelect_byRow
  //20100624 wat
  //リストボックスを行番号で選択
  //行番号がゼロの場合は何も選択しない、という仕様にした。

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //ターゲットとなるリストボックスのブーリアン配列
C_LONGINT:C283($2;$row_number)
$row_number:=$2  //行番号

  //行番号がゼロの場合は何も選択しない
If ($row_number#0)
	LISTBOX SELECT ROW:C912($inListBoxPtr->;$row_number;lk replace selection:K53:1)
Else 
	  //ゼロの場合はデセレクト
	LISTBOX SELECT ROW:C912($inListBoxPtr->;0;lk remove from selection:K53:3)
End if 
