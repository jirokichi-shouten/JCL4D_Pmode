//%attributes = {}
//D01_frmDefInit
//20210607 wat
//ログインダイアログ用　プロセス変数

C_TEXT:C284(vJCL_D01_tblName)
vJCL_D01_tblName:=""

//テーブル名
ARRAY TEXT:C222(vJCL_D01_aryTableName; 0)

//黄金比の縦横比、組み合わせ
ARRAY TEXT:C222(vJCL_D01_aryGoldenRatio; 0)

//別の色
C_TEXT:C284(vJCL_D01_varColorText0)
C_TEXT:C284(vJCL_D01_varColorText1)
C_TEXT:C284(vJCL_D01_varColorText2)
C_TEXT:C284(vJCL_D01_varColorText3)
C_TEXT:C284(vJCL_D01_varColorText4)

//色リスト
ARRAY BOOLEAN:C223(vD01_lstTB; 0)
ARRAY LONGINT:C221(vD01_lstTB_Nr; 0)
ARRAY LONGINT:C221(vD01_lstTB_COLOR; 0)
ARRAY TEXT:C222(vD01_lstTB_NAME; 0)
