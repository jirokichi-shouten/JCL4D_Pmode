//%attributes = {}
//JCL_prj_FG_frm_flds
//20210606 wat
//フィールド用の文字列を作成、複数フィールドを作成
// 20220419 hisa

C_TEXT:C284($1; $folderPath)
$folderPath:=$1
C_TEXT:C284($2; $prefix)
$prefix:=$2
C_POINTER:C301($3; $aryFieldNamePtr)
$aryFieldNamePtr:=$3
C_POINTER:C301($4; $aryFieldTypePtr)
$aryFieldTypePtr:=$4
C_POINTER:C301($5; $aryFieldLengthPtr)
$aryFieldLengthPtr:=$5
C_TEXT:C284($0; $body_flds)
$body_flds:=""

C_TEXT:C284($filePath)
C_TEXT:C284($fld_template)
C_LONGINT:C283($sizeOfAry; $i)
C_TEXT:C284($label)
C_OBJECT:C1216($objFldPos)
C_TEXT:C284($dataType)  // 20220419 hisa

$filePath:=JCL_file_MakeFilePath($folderPath; "frm_flds.txt")
$fld_template:=Document to text:C1236($filePath; "UTF-8"; Document with native format:K24:19)

$sizeOfAry:=Size of array:C274($aryFieldNamePtr->)
$objFldPos:=New object:C1471
$objFldPos.top:=90
$objFldPos.left:=110
$objFldPos.label_left:=10
For ($i; 1; $sizeOfAry)
	//配列名を作成
	$body_flds:=$body_flds+Replace string:C233($fld_template; "[--FRM_PREFIX]"; $prefix)
	$body_flds:=Replace string:C233($body_flds; "[--FIELD]"; $aryFieldNamePtr->{$i})
	
	//フィールドラベルを取得
	$label:=JCL_fields_Label($aryFieldNamePtr->{$i})
	If ($label="")
		//ラベルが取得できなかったらフィールド名を使う
		$label:=$aryFieldNamePtr->{$i}
		
	End if 
	$body_flds:=Replace string:C233($body_flds; "[--LABEL]"; $label)
	
	//フィールド位置
	$objFldPos:=JCL_prj_fg_fldNextPos($objFldPos)
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_TOP]"; String:C10($objFldPos.top))
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_LEFT]"; String:C10($objFldPos.left))
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_LABEL_LEFT]"; String:C10($objFldPos.label_left))
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_LABEL_WIDTH]"; String:C10(94))
	
	//フィールド幅
	$fldWidth:=JCL_prj_fg_fldWidth($aryFieldTypePtr->{$i}; $aryFieldLengthPtr->{$i})
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_WIDTH]"; $fldWidth)
	
	//データソースタイプヒント（dataSourceTypeHint）を置換
	$dataType:=JCL_tbl_DataSourceTypeHint($aryFieldTypePtr->{$i})  // 20220419 hisa
	$body_flds:=Replace string:C233($body_flds; "[--FIELD_DATA_SOURCE_TYPE_HINT]"; $dataType)  // 20220419 hisa
	
	//カンマ
	If ($i#$sizeOfAry)
		$body_flds:=$body_flds+","
		
	End if 
End for 

$0:=$body_flds
