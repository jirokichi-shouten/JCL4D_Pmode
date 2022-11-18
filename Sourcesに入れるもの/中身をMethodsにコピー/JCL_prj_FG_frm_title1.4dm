//%attributes = {}
  //JCL_prj_FG_frm_title
  //20210310 ike wat
  //フォームのタイトル文字列

C_TEXT:C284($1;$folderPath)
$folderPath:=$1
C_TEXT:C284($2;$prefix)
$prefix:=$2
C_TEXT:C284($3;$inputTblName)
$inputTblName:=$3
C_TEXT:C284($4;$color_txt)
$color_txt:=$4
C_TEXT:C284($0;$body)

C_TEXT:C284($template)
C_TEXT:C284($title)

$filePath:=JCL_file_MakeFilePath ($folderPath;"frm_title.txt")
$template:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

$body:=Replace string:C233($template;"[--FRM_PREFIX]";$prefix)
$body:=Replace string:C233($body;"[--RONDOM_COLOR]";$color_txt)

$title:=JCL_fields_cache_TableLabel ($inputTblName)
$title:=$title+"一覧"
$body:=Replace string:C233($body;"[--FRM_TITLE]";$title)

$0:=$body
