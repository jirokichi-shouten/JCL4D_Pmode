//%attributes = {"shared":true}
  //JCL_file_WriteCRLF
  //20100721 wat new
  //ジロファイル、ファイル参照にＣＲとＬＦを書き出す

C_TIME:C306($1;$doc)
$doc:=$1  //ファイル参照

  //改行
SEND PACKET:C103($doc;Char:C90(Carriage return:K15:38))

  //ラインフィード
SEND PACKET:C103($doc;Char:C90(Line feed:K15:40))

  //ラインフィードを出力するとWindowsのメモ帳でＯＫ
  //JEditは情報表示でWindows改行になってしまうが、
  //テキストエディットで読み込みＯＫ
