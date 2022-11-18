//%attributes = {"shared":true}
  //JCL_frm_GetObjectSize
  //フォームオブジェクト　文字数によってフォントサイズを小さくするため
  //20170905 yabe wat

C_TEXT:C284($1;$fldName)
$fldName:=$1
C_POINTER:C301($2;$widthPtr)
$widthPtr:=$2
C_POINTER:C301($3;$heightPtr)
$heightPtr:=$3
C_LONGINT:C283($left;$top;$right;$bottom)


OBJECT GET COORDINATES:C663(*;$fldName;$left;$top;$right;$bottom)

$widthPtr->:=$right-$left
$heightPtr->:=$bottom-$top

