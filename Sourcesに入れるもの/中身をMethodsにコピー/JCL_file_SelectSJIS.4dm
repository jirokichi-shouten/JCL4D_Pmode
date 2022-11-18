//%attributes = {"shared":true}
  //JCL_file_SelectSJIS
  //20171129 wat
  //ファイルを選択して、その内容を取得

C_POINTER:C301($1)  //テキストのポインタ
C_LONGINT:C283($0;$open_ok)
C_TEXT:C284($doc_name)

$doc_name:=Select document:C905(111;"txt";"伝票ファイルを選択してください";0)

ALERT:C41(Document)

$open_ok:=OK
If ($open_ok=1)
	
	$1->:=Document to text:C1236(Document;"Shift-JIS";Document unchanged:K24:18)
	
End if 

  //$1->:=$fileText
$0:=$open_ok
