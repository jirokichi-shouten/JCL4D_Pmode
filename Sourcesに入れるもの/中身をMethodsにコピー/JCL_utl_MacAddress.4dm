//%attributes = {"shared":true}
  //JCL_utl_MacAddress
  //20180105 yabe
  //Macアドレスを取得、Mac OSはen0を、Winは最初に見つかったものを返す
  //20210811 ike wat //_O_PLATFORM PROPERTIES($OS)

C_TEXT:C284($0;$macAddress;$cmd;$input;$output;$error;$device)
ARRAY TEXT:C222($lines;0)
C_LONGINT:C283($i;$sizeOfAry)
C_TEXT:C284($key1;$key2)

If (Is macOS:C1572)
	$key1:="Device: "
	$key2:="Ethernet Address: "
	
	$cmd:="networksetup -listallhardwareports"
	LAUNCH EXTERNAL PROCESS:C811($cmd;$input;$output;$error)
	JCL_str_Extract ($output;Char:C90(Line feed:K15:40);->$lines)
	$sizeOfAry:=Size of array:C274($lines)
	While ($i<=$sizeOfAry)
		If (Position:C15($key1;$lines{$i})=1)
			$device:=Substring:C12($lines{$i};Length:C16($key1)+1)
			If ($device="en0")
				If (Position:C15($key2;$lines{$i+1})=1)
					$macAddress:=Substring:C12($lines{$i+1};Length:C16($key2)+1)
					$i:=$sizeOfAry
					
				End if 
			End if 
		End if 
		
		$i:=$i+1
		
	End while 
Else 
	$key1:="物理アドレス"
	$cmd:="ipconfig /all"
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811($cmd;$input;$output;$error)
	JCL_str_Extract ($output;Char:C90(Line feed:K15:40);->$lines)
	$sizeOfAry:=Size of array:C274($lines)
	While ($i<=$sizeOfAry)
		If (Position:C15($key1;$lines{$i})#0)
			$macAddress:=Substring:C12($lines{$i};Length:C16($lines{$i})-17)
			$i:=$sizeOfAry
			
		End if 
		
		$i:=$i+1
		
	End while 
End if 

$0:=$macAddress
