//%attributes = {}
  //JCL_prj_fg_fldWidth
  //20210210 ike wat
  //フィールド長さを返す

C_TEXT:C284($1;$type)
$type:=$1
C_TEXT:C284($2;$length)
$length:=$2
C_TEXT:C284($0;$fldWidth)
$fldWidth:=""
C_LONGINT:C283($w)

Case of 
	: ($type="Is Alpha Field")
		$w:=Num:C11($length)
		
	: ($type="Is Text")
		$w:=68
		
	: ($type="Is Real")
		$w:=90
		
	: ($type="Is Integer")
		$w:=42
		
	: ($type="Is LongInt")
		$w:=42
		
	: ($type="Is Date")
		$w:=90
		
	: ($type="Is Time")
		$w:=90
		
	: ($type="Is Boolean")
		$w:=42
	: ($type="Is Picture")
		$w:=90
		
	: ($type="Is Subtable")
		$w:=10
		
	: ($type="Is BLOB")
		$w:=10
End case 

$fldWidth:=String:C10($w)
$0:=$fldWidth
