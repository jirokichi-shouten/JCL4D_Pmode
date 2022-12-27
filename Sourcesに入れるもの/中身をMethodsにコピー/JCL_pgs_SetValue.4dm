//%attributes = {"shared":true}
//JCL_pgs_SetValue
//プログレスバー用プロセス変数に値をセット
//$1:メーター
//$2:現在処理しているもの
//$3:現在のカウント
//$3:全カウント
//20080605　矢部　新規作成
//20080924　矢部　現在処理しているものを表示とカウントを追加

C_LONGINT:C283($1)
<>P01_Meter:=$1

C_TEXT:C284($2)
<>P01_Msg:=$2

C_LONGINT:C283($3; $4)
<>P01_Count:=String:C10($3)+"／"+String:C10($4)
