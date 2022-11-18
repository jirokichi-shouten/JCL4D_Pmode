//%attributes = {"shared":true}
  //JCL_file_SQLOut
  //20130109 wat
  //SQL文をファイルに書き出す
  //ファイルはデスクトップ、なければ作る

C_TEXT:C284($1;$inMsg)
$inMsg:=$1  //書き出したい内容
C_TEXT:C284($folderPath;$filePath)
C_TIME:C306($FileRef)  //ファイル参照
C_TEXT:C284($fileName)

$fileName:="SQL"+JCL_str_Datemark (Current date:C33;Current time:C178)+".txt"
$folderPath:=System folder:C487(Desktop:K41:16)
$filePath:=JCL_file_MakeFilePath ($folderPath;$fileName)

$open_ok:=JCL_file_OpenForWrite ($filePath;->$FileRef)
If ($open_ok=1)
	
	  //ファイルに書き出す
	JCL_file_WriteSJIS ($FileRef;$inMsg)
	JCL_file_WriteCRLF ($FileRef)
	JCL_file_WriteCRLF ($FileRef)
	
	  //ファイルを閉じる
	CLOSE DOCUMENT:C267($FileRef)
	
End if 
