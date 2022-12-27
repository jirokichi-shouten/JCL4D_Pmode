//%attributes = {}
//JCL_str_IsCharRetrurn
//20221227 ike wat
//文字が（統一された）改行コードかどうかを判定
//If ($chr=Char(Carriage return))  //mod_ikeda 20221227//JCLではLFに統一することとした

C_TEXT:C284($1; $inChar)
$inChar:=$1
C_BOOLEAN:C305($0; $outRc)
$outRc:=False:C215


If ($inChar=Char:C90(Line feed:K15:40))
	
	$outRc:=True:C214
	
End if 

$0:=$outRc
