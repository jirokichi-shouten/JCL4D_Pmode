//%attributes = {"shared":true}
  //JCL_utl_MachineInfo
  //20180105 yabe
  //20210811 ike wat //_O_PLATFORM PROPERTIES($OS)

C_TEXT:C284($0;$machineInfo;$cmd;$input;$output;$error)

If (Is macOS:C1572)
	
	$cmd:="system_profiler SPHardwareDataType"
	LAUNCH EXTERNAL PROCESS:C811($cmd;$input;$output;$error)
	$machineInfo:=$output
	
	$cmd:="sw_vers"
	LAUNCH EXTERNAL PROCESS:C811($cmd;$input;$output;$error)
	$machineInfo:=$machineInfo+$output
	
Else 
	
	$cmd:="systeminfo /fo table /nh"
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	LAUNCH EXTERNAL PROCESS:C811($cmd;$input;$output;$error)
	$machineInfo:=$output
End if 

$0:=$machineInfo
