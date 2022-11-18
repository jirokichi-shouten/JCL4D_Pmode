//%attributes = {"shared":true}
  //JCL_fld_SetFontSize_byLen
  //20170904
  //テキストフィールド　文字数によってフォントサイズを小さくする

C_TEXT:C284($1;$fldName)
$fldName:=$1
C_LONGINT:C283($2;$capaLen)
$capaLen:=$2
C_LONGINT:C283($len)
C_LONGINT:C283($org_size;$new_size)
C_REAL:C285($ratio)
C_POINTER:C301($fldPtr)
C_LONGINT:C283($org_size2)

$fldPtr:=OBJECT Get pointer:C1124(Object named:K67:5;$fldName)

$org_size:=OBJECT Get font size:C1070($fldPtr->)
$new_size:=$org_size

$len:=Length:C16($fldPtr->)
If ($capaLen<$len)
	
	$ratio:=$capaLen/$len
	$new_size:=$org_size*$ratio
	
End if 

  //C_TEXT($m)
  //$m:="JCL_fld_SetFontSize_byLen"
  //$m:=$m+": $fldName=["+$fldName+"]"
  //$m:=$m+": $org_size=["+String($org_size)+"]"
  //$m:=$m+": $org_size2=["+String($org_size2)+"]"
  //$m:=$m+": $len=["+String($len)+"]"
  //$m:=$m+": $new_size=["+String($new_size)+"]"
  //JCL_file_Logout ($m)

OBJECT SET FONT SIZE:C165($fldPtr->;$new_size)
