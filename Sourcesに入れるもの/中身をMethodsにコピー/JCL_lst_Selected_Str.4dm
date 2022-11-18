//%attributes = {"shared":true}
  //JCL_lst_Selected_Str
  //20100628 wat new
  //汎用メソッド。 リストボックスの行選択を取得して、
  //連結されている文字列の配列から、最初に選択されている行のバリューを返す

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //リストボックスのブーリアン配列のポインタ
C_POINTER:C301($2;$inDataAryPtr)
$inDataAryPtr:=$2  //データ配列のポインタ
C_TEXT:C284($0;$strValue)  //文字列のリターンバリュー
$strValue:=""
C_LONGINT:C283($foundRow)

  //リストボックスの最初に見つかった選択されている行番号を得る
$foundRow:=JCL_lst_Selected_firstRow ($inListBoxPtr)

  //配列の値を返す
If ($foundRow#0)
	$strValue:=$inDataAryPtr->{$foundRow}
	
End if 
$0:=$strValue
