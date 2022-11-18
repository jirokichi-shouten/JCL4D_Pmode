//%attributes = {"shared":true}
  //JCL_file_HTML_toWebArea
  //20170724 wat
  // オンメモリーのHTMLを　一時ファイルに書き出し、Webエリアにロードさせる

C_TEXT:C284($1;$html)
$html:=$1
C_TEXT:C284($2;$objName)
$objName:=$2
C_TEXT:C284($3;$fileName)
$fileName:=$3

WA OPEN URL:C1020(*;$objName;"about:blank")

TEXT TO BLOB:C554($html;$blob;UTF8 C string:K22:15)

  //ファイル保存 // 20170302 wat 一時ファイルの保存場所をドキュメントフォルダに変更
C_TEXT:C284($tempPath)
$tempPath:=JCL_file_DocumentsFolderPath ($fileName;"DMS4D_TMP")
BLOB TO DOCUMENT:C526($tempPath;$blob)

  //表示
C_TEXT:C284($posixPath)
$posixPath:="file:///"+Convert path system to POSIX:C1106($tempPath)
WA OPEN URL:C1020(*;$objName;$posixPath)
