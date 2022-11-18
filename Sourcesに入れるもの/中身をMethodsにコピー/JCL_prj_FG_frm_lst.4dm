//%attributes = {}
  //JCL_prj_FG_frm_lst
  //20210310 ike wat
  //リストボックス用

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
C_TEXT:C284($0;$body)
$body:=""
C_TEXT:C284($filePath)
C_TEXT:C284($template)
C_TEXT:C284($tbl_prefix)
C_LONGINT:C283($pos)

$filePath:=JCL_file_MakeFilePath ($folderPath;"frm_lst.txt")
$template:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

$body:=$template

  //リストボックス用、全体
$pos:=Position:C15("_";$aryFieldNamePtr->{1})
$tbl_prefix:=Substring:C12($aryFieldNamePtr->{1};1;$pos-1)  //フィールド名のプリフィックス
$body:=Replace string:C233($body;"[--TBL_PREFIX]";$tbl_prefix)

$body:=Replace string:C233($body;"[--FRM_PREFIX]";$prefix)

  //リストボックス用、列
$body_col:=JCL_prj_FG_frm_lst_columns ($folderPath;$prefix;$aryFieldNamePtr;$aryFieldTypePtr;$aryFieldLengthPtr)
$body:=Replace string:C233($body;"[--frm_lst_columns]";$body_col)

$0:=$body
