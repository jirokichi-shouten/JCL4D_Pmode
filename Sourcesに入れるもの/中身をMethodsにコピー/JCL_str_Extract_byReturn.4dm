//%attributes = {}
//JCL_str_Extract_byReturn
//20221227 ike wat
//統一された改行で切り出し//JCLではLFに統一する

C_TEXT:C284($1; $inTextStr)
$inTextStr:=$1
C_POINTER:C301($2; $outLineAryPtr)
$outLineAryPtr:=$2

C_TEXT:C284($rowDelimiter)
$rowDelimiter:=Char:C90(Line feed:K15:40)

$numOfLines:=JCL_str_Extract($inTextStr; $rowDelimiter; $outLineAryPtr)

$0:=$numOfLines
