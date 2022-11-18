  //JCL_ary_debug_Logout
  //20190828 wat
  //JCL_ary_debug_Logout ("TR01_btnPrintKeiri";"vTR01_lstTR_MEISHOU")
  //デバッグモジュール、配列の中身をログに出力

C_TEXT($1;$methodName)
$methodName:=$1
C_TEXT($2;$aryName)
$aryName:=$2
C_POINTER($objPtr)
$objPtr:=OBJECT Get pointer(Object named;$aryName)
C_TEXT($msg)
C_LONGINT($i;$sizeOfAry)

JCL_file_Logout ("==== "+$methodName)

$sizeOfAry:=Size of array($objPtr->)
For ($i;1;$sizeOfAry)
	
	$msg:=$aryName+": "
	$msg:=$msg+"i=["+String($i)+"]"
	$msg:=$msg+": value=["+$objPtr->{$i}+"]"
	JCL_file_Logout ($msg)
	  //ALERT($msg)
	
End for 
JCL_file_Logout ("====")
