//%attributes = {"shared":true}
  //JCL_num_GetRGB
  //20130709
  //整数値ＲＧＢからカラー値を返す

C_LONGINT:C283($1;$red)
$red:=$1
C_LONGINT:C283($2;$green)
$green:=$2
C_LONGINT:C283($3;$blue)
$blue:=$3
C_TEXT:C284($useFor)
$useFor:=""
If (Count parameters:C259=4)
	C_TEXT:C284($4)
	$useFor:=$4
End if 

C_LONGINT:C283($0;$color)

If ($useFor="4d view")
	
	$color:=($blue*256*256)+($green*256)+$red
	
Else 
	
	$color:=($red*256*256)+($green*256)+$blue
	
End if 

$0:=$color
