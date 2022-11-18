//%attributes = {"shared":true}
  //JCL_frm_DefaultFontSize
  //20180517 wat
  //デフォルトのフォントサイズに戻す

C_TEXT:C284($1;$defaultFldName)
$defaultFldName:=$1
C_TEXT:C284($2;$fldName)
$fldName:=$2
C_LONGINT:C283($default_font_size)

  // デフォルトのフィールドに設定されているフォントサイズ
$default_font_size:=OBJECT Get font size:C1070(*;$defaultFldName)


OBJECT SET FONT SIZE:C165(*;$fldName;$default_font_size)
