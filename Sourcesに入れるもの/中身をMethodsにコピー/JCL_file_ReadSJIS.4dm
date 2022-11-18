//%attributes = {"shared":true}
  //JCL_file_ReadSJIS
  //20130718
  //JCL_file_ReadSJIS
  //20101210 wat new
  //レシーブパケット、ラップ
  //20110827 yabe 読み込み停止文字がなくても
  //読み込んだブロブのサイズがゼロでなければ、文字を得る

C_TIME:C306($1;$FileRef)
$FileRef:=$1  //ファイル参照
C_TEXT:C284($2;$stopChar)
$stopChar:=$2  //読み込み停止文字
C_BLOB:C604($blob)
C_POINTER:C301($3)
C_LONGINT:C283($0;$receive_ok)  //レシーブがあれば１，なければゼロ
C_TEXT:C284($str)

  //エラーコール
ON ERR CALL:C155("JCL_file_OnErrorCall")

  //ファイルからＢＬＯＢに受診
RECEIVE PACKET:C104($FileRef;$blob;$stopChar)

$receive_ok:=OK
If ($receive_ok=1)
	
	  //ＢＬＯＢから文字エンコーディング
	$str:=Convert to text:C1012($blob;"Shift-JIS")
	
Else   //20110827 yabe
	
	If (BLOB size:C605($blob)>0)
		
		$str:=Convert to text:C1012($blob;"Shift-JIS")
		
	End if 
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

$3->:=$str
$0:=$receive_ok
