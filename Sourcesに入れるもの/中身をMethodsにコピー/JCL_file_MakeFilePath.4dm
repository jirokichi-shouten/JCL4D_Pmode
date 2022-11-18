//%attributes = {"shared":true}
//JCL_file_MakeFilePath
//20110222 wat
//ファイルパスを生成

C_TEXT:C284($1; $folder)
$folder:=$1  //フォルダ名
C_TEXT:C284($2; $fileName)
$fileName:=$2  //ファイル名
C_TEXT:C284($0; $outPath)

C_TEXT:C284($separator)
$separator:=JCL_file_GetDirSeparator

C_LONGINT:C283($length)
C_TEXT:C284($char)

$length:=Length:C16($folder)

//末尾の１文字取得
$latOfFolderChar:=Substring:C12($folder; $length)
$firstOfFileChar:=Substring:C12($fileName; 1; 1)

If ($latOfFolderChar=$separator)
	If ($firstOfFileChar=$separator)
		//どちらもセパレータ付きならフォルダからカット
		$folder:=Substring:C12($folder; 1; $length-1)
		$outPath:=$folder+$fileName
		
	Else 
		//フォルダにセパレータがついていてファイルにセパレータがないならそのまま結合
		$outPath:=$folder+$fileName
		
	End if 
Else 
	//フォルダにセパレータがついていないなら、セパレータを入れて結合
	If ($firstOfFileChar=$separator)
		//ファイル名の最初にセパレータがついていたら
		$outPath:=$folder+$fileName
		
	Else 
		//どちらもセパレータなしならセパレータを入れて結合
		$outPath:=$folder+$separator+$fileName
		
	End if 
End if 

$0:=$outPath
