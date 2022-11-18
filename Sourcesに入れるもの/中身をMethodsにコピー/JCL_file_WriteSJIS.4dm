//%attributes = {"shared":true}
  //JCL_file_WriteSJIS
  //20100721 wat new
  //テキストファイルに書き出す

C_TIME:C306($1;$doc)
$doc:=$1  //ファイル参照
C_TEXT:C284($2;$inText)
$inText:=$2  //出力対象の文字列
C_BLOB:C604($convertedBLOB)

  //文字セットを指定して、ＢＬＯＢに変換
CONVERT FROM TEXT:C1011($inText;"Shift_JIS";$convertedBLOB)
  //CONVERT FROM TEXT($inText;kTextEncodingMacJapanese;$convertedBLOB)
  //CONVERT FROM TEXT($inText;"x-mac-japanese";$convertedBLOB)

  //CONVERT FROM TEXT($inText;1258;$convertedBLOB)
  //注: IANAに定義されていない特別な文字セット (1258=x-mac-japanese) を使用することができます。
  //これはWindows上ではコードページ10001に、Mac上ではkTextEncodingMacJapaneseにマッ プされています。


If (OK=1)
	
	  //変換が成功したときだけ書き出す
	SEND PACKET:C103($doc;$convertedBLOB)
	
End if 

$0:=OK
