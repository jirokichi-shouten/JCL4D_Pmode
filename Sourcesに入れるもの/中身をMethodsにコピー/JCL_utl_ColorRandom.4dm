//%attributes = {}
  //JCL_utl_ColorRandom
  //zz_color_random
  //20210317 wat
  //ランダムなカラーを文字列で返す
  //$color_txt:="#FF0000"

C_TEXT:C284($0;$retStr)
$retStr:=""
C_LONGINT:C283($num;$red;$green;$blue)
C_TEXT:C284($tmpStr)
ARRAY LONGINT:C221($aryColor;0)

APPEND TO ARRAY:C911($aryColor;255)  //1
APPEND TO ARRAY:C911($aryColor;218)  //2
APPEND TO ARRAY:C911($aryColor;195)  //3
APPEND TO ARRAY:C911($aryColor;158)  //4
APPEND TO ARRAY:C911($aryColor;97)  //5
APPEND TO ARRAY:C911($aryColor;60)  //6
APPEND TO ARRAY:C911($aryColor;37)  //7
APPEND TO ARRAY:C911($aryColor;0)  //8

$red:=$aryColor{Mod:C98(Random:C100;8)}
$green:=$aryColor{Mod:C98(Random:C100;8)}
$blue:=$aryColor{Mod:C98(Random:C100;8)}

$num:=16*16*$red+16*$green+$blue
$num:=16*16*($red+100)+16*($green+100)+$blue+100
$tmpStr:=String:C10($num;"&$")
If (Length:C16($tmpStr)>7)
	$tmpStr:=Substring:C12($tmpStr;3;8)
	
Else 
	$tmpStr:=Substring:C12($tmpStr;2;7)
	
End if 

$retStr:="#"
$retStr:=$retStr+Replace string:C233($tmpStr;"$";"")
  //ALERT($retStr)

$0:=$retStr
