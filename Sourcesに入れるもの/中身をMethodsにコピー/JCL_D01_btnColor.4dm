//%attributes = {}
//vJCL_D01_btnColor
//D01_btnColor
//20210607 wat
//別の色５色

C_TEXT:C284($color_txt)

$color_txt:=JCL_utl_ColorRandom
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor0"; $color_txt; $color_txt)
vJCL_D01_varColorText0:=$color_txt

$color_txt:=JCL_utl_ColorRandom
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor1"; $color_txt; $color_txt)
vJCL_D01_varColorText1:=$color_txt

$color_txt:=JCL_utl_ColorRandom
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor2"; $color_txt; $color_txt)
vJCL_D01_varColorText2:=$color_txt

$color_txt:=JCL_utl_ColorRandom
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor3"; $color_txt; $color_txt)
vJCL_D01_varColorText3:=$color_txt

$color_txt:=JCL_utl_ColorRandom
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectColor4"; $color_txt; $color_txt)
vJCL_D01_varColorText4:=$color_txt
