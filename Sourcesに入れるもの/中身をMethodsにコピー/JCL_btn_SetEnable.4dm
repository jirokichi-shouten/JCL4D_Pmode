//%attributes = {"shared":true}
  //JCL_btn_SetEnable
  //20100708 wat
  //ボタンをイネイブルにする、ラッパ
  //引数のブール値が、真だったらイネイブル
  //20150818 yabe 「NABLE BUTTON」「DISABLE BUTTON」は廃止にともない「OBJECT SET ENABLED」に変更

C_POINTER:C301($1;$inButtonPtr)
$inButtonPtr:=$1  //イネイブル対象となるボタンのポインタ
C_BOOLEAN:C305($inBool)
$inBool:=$2

  //引数が真ならボタンはイネイブル、偽ならグレイ
If ($inBool=True:C214)
	OBJECT SET ENABLED:C1123($inButtonPtr->;True:C214)
Else 
	OBJECT SET ENABLED:C1123($inButtonPtr->;False:C215)
End if 
