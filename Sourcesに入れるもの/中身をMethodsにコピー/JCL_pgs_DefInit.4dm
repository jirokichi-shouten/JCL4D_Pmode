//%attributes = {"shared":true}
//JCL_pgs_DefInit
//20111127 wat
//プログレスバー関連のグローバル変数を宣言・初期化
// プログレスバー関連 20080605add_yabe

C_LONGINT:C283(<>P01_Meter)  //プログレスバー
<>P01_Meter:=0

C_BOOLEAN:C305(<>P01_Cancel)
<>P01_Cancel:=False:C215

C_TEXT:C284(<>P01_Msg)
<>P01_Msg:=""

C_TEXT:C284(<>P01_Count)
<>P01_Count:=""
