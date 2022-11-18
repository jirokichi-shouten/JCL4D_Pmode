//%attributes = {"shared":true}
  //JCL_file_Extension
  //20160823 yabe
  //ファイル名から拡張子を取得

C_TEXT:C284($1;$fileName)
$fileName:=$1

C_TEXT:C284($0;$ext)

If ($fileName="")
	$ext:=""
Else 
	
	ARRAY TEXT:C222($aryExtract;0)
	$sizeOfAry:=JCL_str_Extract ($fileName;".";->$aryExtract)
	
	If ($sizeOfAry=1)
		
		$ext:=""
		
	Else 
		
		$ext:=$aryExtract{$sizeOfAry}
		
	End if 
	
End if 

$0:=$ext
