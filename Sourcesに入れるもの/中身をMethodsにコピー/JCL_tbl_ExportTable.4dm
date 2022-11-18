//%attributes = {"shared":true}
  //JCL_tbl_ExportTable
  //20130430 yabe
  //一つのテーブルとそのフィールド書き出し

C_TIME:C306($1;$doc)
$doc:=$1
C_TEXT:C284($2;$tableName)
$tableName:=$2
C_POINTER:C301($3;$inAryFieldName)
$inAryFieldName:=$3
C_POINTER:C301($4;$inAryFieldType)
$inAryFieldType:=$4
C_POINTER:C301($5;$inAryFieldLength)
$inAryFieldLength:=$5
C_POINTER:C301($6;$inAryFieldIndex)
$inAryFieldIndex:=$6

C_TEXT:C284($tablePrefix)
C_LONGINT:C283($i;$numOfFields)

$tablePrefix:=JCL_tbl_Prefix ($inAryFieldName)
$numOfFields:=Size of array:C274($inAryFieldName->)

SEND PACKET:C103($doc;$tableName+Char:C90(Tab:K15:37))
SEND PACKET:C103($doc;$tablePrefix+Char:C90(Carriage return:K15:38))

For ($i;1;$numOfFields)
	
	$exportFieldName:=Replace string:C233($inAryFieldName->{$i};$tablePrefix;"";1)
	
	SEND PACKET:C103($doc;$exportFieldName+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc;$inAryFieldType->{$i}+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc;$inAryFieldLength->{$i}+Char:C90(Tab:K15:37))
	SEND PACKET:C103($doc;$inAryFieldIndex->{$i}+Char:C90(Carriage return:K15:38))
	
End for 

  //テーブルの区切り
SEND PACKET:C103($doc;"_"+Char:C90(Carriage return:K15:38))
