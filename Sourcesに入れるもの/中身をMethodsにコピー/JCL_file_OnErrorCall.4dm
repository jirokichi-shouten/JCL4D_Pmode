//%attributes = {"shared":true}
  //JCL_file_OnErrorCall
  //20110627 wat
  //ファイル関係のエラー処理

C_LONGINT:C283($err_code)
C_TEXT:C284($title;$alert;$ok_str)  //エラーメッセージ用

  //エラーコードを取得
$err_code:=Error

  //エラーメッセージ表示
$title:="File error."+Char:C90(Carriage return:K15:38)
$alert:=$title+"Error code is ["+String:C10($err_code)
$alert:=$alert+"]"
$ok_str:="OK"
ALERT:C41($alert;$ok_str)

