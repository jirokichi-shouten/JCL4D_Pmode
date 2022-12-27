//%attributes = {}
//JCL_str_ReplaceReturn
//20221227 ike wat
//改行コードを統一する
//GitでテンプレートファイルのコードがLFにされてしまったため、JCLではLFに統一することにした

C_TEXT:C284($1; $inStr)
$inStr:=$1
C_TEXT:C284($0; $replaceStr)

C_TEXT:C284($rowDelimiter)
$rowDelimiter:=Char:C90(Line feed:K15:40)  //add_ikeda 20221227

$replaceStr:=$inStr

$replaceStr:=Replace string:C233($replaceStr; Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40); $rowDelimiter)  //先にCRLFを置き換える
$replaceStr:=Replace string:C233($replaceStr; Char:C90(Carriage return:K15:38); $rowDelimiter)  //残ったCRを置き換える
$replaceStr:=Replace string:C233($replaceStr; $rowDelimiter+$rowDelimiter; $rowDelimiter)

$0:=$replaceStr
