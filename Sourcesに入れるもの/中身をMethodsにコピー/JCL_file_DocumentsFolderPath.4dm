//%attributes = {"shared":true}
  //JCL_file_DocumentsFolderPath
  //JCL_file_DocumentsFolderPath
  //20170301 wat
  // ユーザのドキュメントフォルダに置くフォルダとファイルのパスを作る
  //一時ファイルを保存するパスを返す
  // 20160907 wat 重複を避けるためデイトマークを入れる
  // 20170301 wat commented フォルダ名は外からもらう

C_TEXT:C284($1;$fileName)
$fileName:=$1
C_TEXT:C284($2;$folderName)  // 20170301
$folderName:=$2
C_TEXT:C284($0;$outFilePath)
C_TEXT:C284($ext)
C_TEXT:C284($documentsFolder)
C_TEXT:C284($tempPath)
C_LONGINT:C283($no)
C_TEXT:C284($datemark)
$datemark:=JCL_str_Datemark (Current date:C33;Current time:C178)

  //ファイル名から拡張子を取得
$ext:="."+JCL_file_Extension ($fileName)

  // ユーザのドキュメントフォルダに
$documentsFolder:=System folder:C487(Documents folder:K41:18)
$tempPath:=JCL_file_MakeFilePath ($documentsFolder;$folderName)

  // フォルダがなければ作る
If (Test path name:C476($tempPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($tempPath)
	
End if 

  //20160926 yabe ファイル名の重複を避けてパスを取得
$no:=0
$outFilePath:=JCL_file_MakeFilePath ($tempPath;$datemark+$ext)
While (Test path name:C476($outFilePath)=Is a document:K24:1)
	
	  // 同じファイル名がすでに合ったら（１）のように数字を補填する
	$no:=$no+1
	$outFilePath:=JCL_file_MakeFilePath ($tempPath;$datemark+"("+String:C10($no)+")"+$ext)
	
End while 

$0:=$outFilePath
