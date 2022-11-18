//%attributes = {"shared":true}
  //JCL_str_FormatDatemark
  //20101215 wat new
  //デイトマークストリングをフォーマットする

C_TEXT:C284($1;$inStr;$0;$outStr)
$inStr:=$1
C_LONGINT:C283($2)
C_LONGINT:C283($numOfParams)
$numOfParams:=Count parameters:C259
C_TEXT:C284($platformStr)
C_TEXT:C284($delimiter;$dot;$slash;$space;$colon)
$dot:="."  //mac
$slash:="/"  //win
$space:=" "
$colon:=":"

$platformStr:=JCL_str_Platform 
If ($platformStr="Mac")
	$delimiter:=$dot
Else 
	$delimiter:=$slash
End if 

  //空白文字なら何もしない
If ($inStr#"")
	
	  //YYYY/MM/DD HH:MMにする
	$outStr:=Substring:C12($inStr;1;4)  //YYYY
	$outStr:=$outStr+$delimiter+Substring:C12($inStr;5;2)  //MM
	$outStr:=$outStr+$delimiter+Substring:C12($inStr;7;2)  //DD
	
	If ($numOfParams=1)
		$outStr:=$outStr+$space+Substring:C12($inStr;9;2)  //HH
		$outStr:=$outStr+$colon+Substring:C12($inStr;11;2)  //MM
		$outStr:=$outStr+$colon+Substring:C12($inStr;13;2)  //SS
	End if 
	
End if 

$0:=$outStr
