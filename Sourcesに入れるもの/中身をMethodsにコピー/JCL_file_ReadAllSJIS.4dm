//%attributes = {"shared":true}
  //JCL_file_ReadAllSJIS
  //20180103 wat
  //Jiro_file_ReadAllSJIS
  //20110120 wat new
  //EOFまでレシーブパケット、ラップ

C_TIME:C306($1;$FileRef)
$FileRef:=$1  //ファイル参照
C_BLOB:C604($blob)
C_POINTER:C301($2)  //文字列を返す
C_LONGINT:C283($0;$receive_ok)  //レシーブがあれば１，なければゼロ
C_TEXT:C284($str)
C_REAL:C285($sizeOfFile)

  //エラーコール
ON ERR CALL:C155("Jiro_file_OnErrorCall")

  //ファイルからＢＬＯＢに受診
$sizeOfFile:=Get document size:C479($FileRef)

RECEIVE PACKET:C104($FileRef;$blob;$sizeOfFile)

$receive_ok:=OK
If ($receive_ok=1)
	
	  //ＢＬＯＢから文字エンコーディング
	$str:=Convert to text:C1012($blob;"Shift-JIS")
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

$2->:=$str
$0:=$receive_ok
