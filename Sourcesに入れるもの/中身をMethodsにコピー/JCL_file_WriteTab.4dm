//%attributes = {"shared":true}
  //JCL_file_WriteTab
  //20100721 wat new
  //ファイル参照にタブコードをを書き出す

C_TIME:C306($1;$doc)
$doc:=$1  //ファイル参照

SEND PACKET:C103($doc;Char:C90(Tab:K15:37))
