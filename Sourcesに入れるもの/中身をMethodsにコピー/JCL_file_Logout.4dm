//%attributes = {"shared":true}
  //JCL_file_Logout
  //20110527 wat
  //ログをファイルに書き出す
  //ファイルはデスクトップ、なければ作る

C_TEXT:C284($1;$inMsg)
$inMsg:=$1  //書き出したい内容
C_TEXT:C284($folderPath;$filePath)
C_TIME:C306($FileRef)  //ファイル参照

$folderPath:=System folder:C487(Desktop:K41:16)
$filePath:=JCL_file_MakeFilePath ($folderPath;"Logout.txt")

$open_ok:=JCL_file_OpenForWrite ($filePath;->$FileRef)
If ($open_ok=1)
	
	  //ファイルに書き出す
	$dateStr:=JCL_str_Datemark (Current date:C33;Current time:C178)
	JCL_file_WriteSJIS ($FileRef;$dateStr)
	JCL_file_WriteTab ($FileRef)
	JCL_file_WriteSJIS ($FileRef;$inMsg)
	JCL_file_WriteCRLF ($FileRef)
	
	  //ファイルを閉じる
	CLOSE DOCUMENT:C267($FileRef)
	
End if 
