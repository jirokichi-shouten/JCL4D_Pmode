//%attributes = {"shared":true}
  //JCL_file_Open
  //20180103 wat
  //Jiro_file_Open
  //20101209 wat new
  //ファイルオープンダイアログ

C_POINTER:C301($1)
C_TIME:C306($FileRef)  //ファイル参照
C_LONGINT:C283($0;$dlg_ok)  //ダイアログＯＫ

  //エラーコール
ON ERR CALL:C155("Jiro_file_OnErrorCall")

$FileRef:=Open document:C264("";"")
$dlg_ok:=OK

  //エラーコール終了
ON ERR CALL:C155("")

  //ダイアログがＯＫされたかは戻り値で返す
$1->:=$FileRef
$0:=$dlg_ok
