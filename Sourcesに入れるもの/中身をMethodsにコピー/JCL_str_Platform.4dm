//%attributes = {"shared":true}
  //JCL_str_GetPlatform
  //20100805 wat new
  //マックかウィンかを文字列で返す
  //20210811 ike wat //_O_PLATFORM PROPERTIES($OS)

C_TEXT:C284($0;$platformStr)
$platformStr:=""

  //実行されているのが
If (Is Windows:C1573)
	
	$platformStr:="Win"
	
Else 
	
	$platformStr:="Mac"
	
End if 

$0:=$platformStr
