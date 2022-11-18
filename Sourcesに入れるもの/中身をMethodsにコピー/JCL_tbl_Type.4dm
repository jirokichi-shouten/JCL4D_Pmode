//%attributes = {"shared":true}
  //JCL_tbl_Type
  //JCL_tbl_GetType
  //20130430 yabe
  //タイプ文字列を得る

C_LONGINT:C283($1;$type)
$type:=$1  //フィールド型
C_TEXT:C284($0;$type_str)

Case of 
	: ($type=Is alpha field:K8:1)
		$type_str:="Is Alpha Field"
	: ($type=Is text:K8:3)
		$type_str:="Is Text"
	: ($type=Is real:K8:4)
		$type_str:="Is Real"
	: ($type=Is integer:K8:5)
		$type_str:="Is Integer"
	: ($type=Is longint:K8:6)
		$type_str:="Is LongInt"
	: ($type=Is date:K8:7)
		$type_str:="Is Date"
	: ($type=Is time:K8:8)
		$type_str:="Is Time"
	: ($type=Is boolean:K8:9)
		$type_str:="Is Boolean"
	: ($type=Is picture:K8:10)
		$type_str:="Is Picture"
	: ($type=Is subtable:K8:11)
		$type_str:="Is Subtable"
	: ($type=Is BLOB:K8:12)
		$type_str:="Is BLOB"
End case 

$0:=$type_str
