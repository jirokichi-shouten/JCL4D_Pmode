//%attributes = {}
//JCL_str_IsNumber
//20180926 wat
//JCL_str_Numbers
//JCL_str_GetNumber
//20130606 yabe
//文字列から数値だけをとりだす
//全角は半角に変換する
//4Dは文字列比較で半角数字と全角数字を同じとみなすようだ
//4D - ランゲージリファレンス「文字列比較の詳細」には
//"１"="1"はTRUEを返すと記述があるが、ここでは念のため
//全角・半角も判定するコードにした

C_TEXT:C284($1; $str)
$str:=$1
C_BOOLEAN:C305($0; $result)
$result:=False:C215

C_LONGINT:C283($i; $length)
$length:=Length:C16($str)

C_TEXT:C284($char)

For ($i; 1; $length)
	
	//i番目の文字を取り出す
	$char:=$str[[$i]]
	
	Case of 
		: ($char="0")
			$result:=True:C214
		: ($char="1")
			$result:=True:C214
		: ($char="2")
			$result:=True:C214
		: ($char="3")
			$result:=True:C214
		: ($char="4")
			$result:=True:C214
		: ($char="5")
			$result:=True:C214
		: ($char="6")
			$result:=True:C214
		: ($char="7")
			$result:=True:C214
		: ($char="8")
			$result:=True:C214
		: ($char="9")
			$result:=True:C214
		: ($char="０")
			$result:=False:C215
		: ($char="１")
			$result:=False:C215
		: ($char="２")
			$result:=False:C215
		: ($char="３")
			$result:=False:C215
		: ($char="４")
			$result:=False:C215
		: ($char="５")
			$result:=False:C215
		: ($char="６")
			$result:=False:C215
		: ($char="７")
			$result:=False:C215
		: ($char="８")
			$result:=False:C215
		: ($char="９")
			$result:=False:C215
		Else 
			$result:=False:C215
			//数字以外
	End case 
	
End for 

$0:=$result
