//%attributes = {"shared":true}
  //JCL_file_Create
  //20101210 wat new
  //ファイルを作成する、ドキュメント名を返す

C_TEXT:C284($1;$inExt)
$inExt:=$1  //ファイル拡張子
C_POINTER:C301($2;$outDocPtr)
$outDocPtr:=$2  //ファイル参照番号
C_POINTER:C301($3;$outDocNamePtr)
$outDocNamePtr:=$3  //ファイル名
C_LONGINT:C283($0)
C_TEXT:C284($defaultFileName)
C_TEXT:C284($docName)  //ファイル参照番号
C_TIME:C306($doc)

  //エラーコール
ON ERR CALL:C155("JCL_file_OnErrorCall")

$numofParams:=Count parameters:C259
If ($numofParams>=4)
	C_TEXT:C284($4;$inDocName)
	$inDocName:=$4  //デフォルトファイル名
	
	  //$doc:=Select document(System folder(Documents folder)+"Report.pdf";"pdf";"Report name:";File name entry)				\
				
	$defaultFileName:=$inDocName+$inExt
	$docName:=Select document:C905(System folder:C487(Desktop:K41:16)+"aaa";"txt";"Output file name:";File name entry:K24:17;$fullPath)
	  //$doc:=Select document(System folder(Desktop)+$defaultFileName;"txt";"Output file name:";File name entry)				\
				
	$doc:=Create document:C266($fullPath;$inExt)
	
Else 
	
	  //ファイル参照番号は引数で返す
	  //Document:=$3->
	$outDocPtr->:=Create document:C266("";$inExt)
	  //空文字を与えるとファイル保存ダイアログが表示される
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

  //ドキュメント名は引数で返す
$outDocNamePtr->:=Document

  //ダイアログがＯＫされたかは戻り値で返す
$0:=ok
