//%attributes = {}
  //JCL_prj_FG_frm_obj
  //20210317 wat
  //フォームのModボタン

C_TEXT:C284($1;$folderPath)
$folderPath:=$1
C_TEXT:C284($2;$prefix)
$prefix:=$2
C_TEXT:C284($3;$fileName)
$fileName:=$3
C_TEXT:C284($0;$body)

C_TEXT:C284($template)
C_TEXT:C284($color_txt;$title)

$filePath:=JCL_file_MakeFilePath ($folderPath;$fileName)
$template:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

$body:=Replace string:C233($template;"[--FRM_PREFIX]";$prefix)


$0:=$body
