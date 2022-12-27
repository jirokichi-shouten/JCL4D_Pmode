//%attributes = {}
//JCL_str_unifyCR
//JCL_str_uniformCR
//Jiro_str_uniformCR
//20150828 wat
//改行コードを統一
//改行コードをCRに統一する
//20221227 ファイル読み込みの際はLFに統一する JCL_str_ReplaceReturn を推奨する

C_TEXT:C284($1; $txt)
$txt:=$1
C_TEXT:C284($0; $retTxt)

C_TEXT:C284($CR; $LF; $CRLF)
$CR:=Char:C90(Carriage return:K15:38)
$LF:=Char:C90(Line feed:K15:40)
$CRLF:=$CR+$LF

//CRLFをCRに変換
$retTxt:=Replace string:C233($txt; $CRLF; $CR)

//LFをCRに変換
$retTxt:=Replace string:C233($retTxt; $LF; $CR)

$0:=$retTxt
