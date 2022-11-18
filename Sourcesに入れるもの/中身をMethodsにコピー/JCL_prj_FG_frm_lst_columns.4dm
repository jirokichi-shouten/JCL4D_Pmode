//%attributes = {}
  //JCL_prj_FG_frm_lst_columns
  //20210310 ike wat
  //リストボックス用、列

C_TEXT:C284($1;$folderPath)
$folderPath:=$1
C_TEXT:C284($2;$prefix)
$prefix:=$2
C_POINTER:C301($3;$aryFieldNamePtr)
$aryFieldNamePtr:=$3
C_POINTER:C301($4;$aryFieldTypePtr)
$aryFieldTypePtr:=$4
C_POINTER:C301($5;$aryFieldLengthPtr)
$aryFieldLengthPtr:=$5
C_TEXT:C284($0;$body_col)
$body_col:=""

C_TEXT:C284($filePath)
C_TEXT:C284($col_template)
C_LONGINT:C283($sizeOfAry;$i)
C_TEXT:C284($label)
C_TEXT:C284($fldWidth)

$filePath:=JCL_file_MakeFilePath ($folderPath;"frm_lst_columns.txt")
$col_template:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
For ($i;1;$sizeOfAry)
	  //配列名を作成
	$body_col:=$body_col+Replace string:C233($col_template;"[--FRM_PREFIX]";$prefix)
	$body_col:=Replace string:C233($body_col;"[--FIELD]";$aryFieldNamePtr->{$i})
	$label:=JCL_fields_Label ($aryFieldNamePtr->{$i})
	If ($label="")
		$label:=$aryFieldNamePtr->{$i}
		
	End if 
	$body_col:=Replace string:C233($body_col;"[--LABEL]";$label)
	$fldWidth:=JCL_prj_fg_fldWidth ($aryFieldTypePtr->{$i};$aryFieldLengthPtr->{$i})
	$body_col:=Replace string:C233($body_col;"[--FIELD_WIDTH]";$fldWidth)
	
	  //カンマ
	If ($i#$sizeOfAry)
		$body_col:=$body_col+","
		
	End if 
End for 

$0:=$body_col
