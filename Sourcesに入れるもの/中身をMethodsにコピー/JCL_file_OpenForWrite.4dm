//%attributes = {"shared":true}
  //JCL_file_OpenForWrite
  //20110527 wat new
  //ファイル名を指定してオープン

C_TEXT:C284($1;$fileName)
$fileName:=$1
C_POINTER:C301($2)
C_TIME:C306($FileRef)  //ファイル参照
C_LONGINT:C283($0;$open_ok)  //ダイアログＯＫ
$open_ok:=0

  //エラーコール
ON ERR CALL:C155("JCL_file_OnErrorCall")

If (Test path name:C476($fileName)=Is a document:K24:1)
	
	  //ファイルがあれば開く
	$FileRef:=Append document:C265($fileName)
	$open_ok:=OK
	
Else 
	
	  //なければ作る
	$FileRef:=Create document:C266($filename)
	$open_ok:=OK
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

  //ＯＫは戻り値で返す
$2->:=$FileRef
$0:=$open_ok
