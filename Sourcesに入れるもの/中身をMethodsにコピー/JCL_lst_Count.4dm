//%attributes = {"shared":true}
  //JCL_lst_Count
  //JCL_lst_GetCount
  //20100721 wat new
  //リストボックスの表示行数を取得
  //オンロード時はリストボックスの配列からは件数が取得できない
  //クリエイトアレイで作成したIDの配列を与えるとうまく動く

C_POINTER:C301($1;$inListBoxPtr)
$inListBoxPtr:=$1  //ターゲットとなるリストボックスのブーリアン配列ではＮＧ
C_LONGINT:C283($numOfRows;$0)

  //リストボックス配列から表示行数を得る
$numOfRows:=Size of array:C274($inListBoxPtr->)

$0:=$numOfRows
