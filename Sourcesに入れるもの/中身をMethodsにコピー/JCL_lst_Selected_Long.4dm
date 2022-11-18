//%attributes = {"shared":true}
  //JCL_lst_GetSelected_Long
  //20100623 wat new
  //汎用メソッド。 リストボックスの行選択を取得して、
  //連結されているロングの配列から、最初の選択行のバリューを返す

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //リストボックスのブーリアン配列
C_POINTER:C301($2;$inDataAryPtr)
$inDataAryPtr:=$2  //ロングデータ配列のポインタ
C_LONGINT:C283($0;$longValue)  //ロングのリターンバリュー
$longValue:=0
C_LONGINT:C283($foundRow)

  //リストボックスの最初に見つかった選択されている行番号を得る
$foundRow:=JCL_lst_Selected_firstRow ($inListBoxPtr)

  //配列の値を返す
If ($foundRow#0)
	$longValue:=$inDataAryPtr->{$foundRow}
End if 
$0:=$longValue
