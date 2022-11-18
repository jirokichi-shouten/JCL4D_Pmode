//%attributes = {}
  //JCL_D01_popGoldenRatio
  //20210607 wat
  //黄金比ポップアップ

C_TEXT:C284($selStr)
C_LONGINT:C283($width;$height)

$selStr:=vJCL_D01_aryGoldenRatio{vJCL_D01_aryGoldenRatio}
$pos:=Position:C15("x";$selStr)

If ($pos>0)
	  //縦横文字列から、幅と高さを切り出す
	$width:=Num:C11(Substring:C12($selStr;1;$pos-1))
	$height:=Num:C11(Substring:C12($selStr;$pos+1))
	
	
	vJCL_D01_objFrm.width:=$width
	vJCL_D01_objFrm.height:=$height
	
End if 
