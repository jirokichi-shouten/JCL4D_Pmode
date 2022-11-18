//%attributes = {"shared":true}
  //JCL_btn_SetVisible
  //20100708 wat 
  //ボタンを見えなくする、ラッパ

C_POINTER:C301($1;$inButtonPtr)
$inButtonPtr:=$1  //イネイブル対象となるボタンのポインタ
C_BOOLEAN:C305($2;$inBool)
$inBool:=$2  //ブール値

  //引数が真ならボタンは表示、偽なら非表示
OBJECT SET VISIBLE:C603($inButtonPtr->;$inBool)  //ボタンを非表示
