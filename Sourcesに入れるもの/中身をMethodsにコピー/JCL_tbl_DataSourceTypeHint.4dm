//%attributes = {}
// JCL_tbl_DataSourceTypeHint
// 20220419 hisa
//メソッド生成時、テンプレートの dataSourceTypeHint を得る
// http://151.80.33.215/4Dv19R3/4D/19-R3/Dynamic-Forms.300-5612364.ja.html

C_TEXT:C284($1; $fieldType)
$fieldType:=$1  //フィールド型
C_TEXT:C284($0; $dataSourceTypeHint)

$dataSourceTypeHint:=""
Case of 
	: ($fieldType="Is Alpha Field")
		$dataSourceTypeHint:="text"
		
	: ($fieldType="Is Text")
		$dataSourceTypeHint:="text"
		
	: ($fieldType="Is Real")
		$dataSourceTypeHint:="number"
		
	: ($fieldType="Is Integer")
		$dataSourceTypeHint:="integer"
		
	: ($fieldType="Is LongInt")
		$dataSourceTypeHint:="integer"
		
	: ($fieldType="Is Date")
		$dataSourceTypeHint:="date"
		
	: ($fieldType="Is Time")
		$dataSourceTypeHint:="time"
		
	: ($fieldType="Is Boolean")
		$dataSourceTypeHint:="boolean"
		
	: ($fieldType="Is Picture")
		$dataSourceTypeHint:="picture"
		
	: ($fieldType="Is Subtable")
		$dataSourceTypeHint:=""
		
	: ($fieldType="Is BLOB")
		$dataSourceTypeHint:=""
End case 

$0:=$dataSourceTypeHint

