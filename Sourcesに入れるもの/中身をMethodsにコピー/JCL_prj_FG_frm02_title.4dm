//%attributes = {}
  //JCL_prj_FG_frm02_title
  //20210330 ike wat
  //入力フォームのタイトル文字列
  //20210608 wat 引数をオブジェクト型に変更

C_TEXT:C284($1;$folderPath)
$folderPath:=$1
C_OBJECT:C1216($2;$objFrm)
$objFrm:=$2
C_TEXT:C284($0;$body)

C_TEXT:C284($filePath;$template)
C_TEXT:C284($title)

$filePath:=JCL_file_MakeFilePath ($folderPath;"frm02_title.txt")
$template:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

$body:=Replace string:C233($template;"[--FRM_PREFIX]";$objFrm.prefix)
$body:=Replace string:C233($body;"[--RONDOM_COLOR]";$objFrm.color_text)

  //$title:=JCL_fields_cache_TableLabel ($objFrm.tblName)
  //$title:=$title+"一覧"
  //$body:=Replace string($body;"[--FRM_TITLE]";$title)

$0:=$body
