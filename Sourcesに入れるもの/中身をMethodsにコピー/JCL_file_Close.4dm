//%attributes = {"shared":true}
  //JCL_file_Close
  //20101210 wat new
  //ファイルを閉じる

C_TIME:C306($1;$doc)
$doc:=$1  //ファイル参照番号

CLOSE DOCUMENT:C267($doc)
