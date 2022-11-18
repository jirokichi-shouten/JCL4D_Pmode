//%attributes = {}
//JCL_D01_frmOnLoad
//20210607 wat
//オンロードメソッド

JCL_D01_frmDefInit

JCL_D01_popTableName_make

JCL_D01_popGoldennRation_make
vJCL_D01_aryGoldenRatio:=1

//色
C_TEXT:C284($color_txt)
$color_txt:=vJCL_D01_objFrm.color_text
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectTitle"; $color_txt; $color_txt)

//別の色５色
JCL_D01_btnColor

//使用済み色リスト、テーブル一覧
JCL_D01_lstTB_make

