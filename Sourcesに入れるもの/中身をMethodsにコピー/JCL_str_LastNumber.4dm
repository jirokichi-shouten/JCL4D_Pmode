//%attributes = {}
//JCL_str_LastNumber
//20211221 wat
//伝票番号のように、Receipt-001の001部分を取得
//20211222 wat 数字だけの時を考慮
//20220421 rename

C_TEXT:C284($1; $bangou)
$bangou:=$1
C_OBJECT:C1216($2; $objBangou)
$objBangou:=$2
C_LONGINT:C283($0)
C_TEXT:C284($buf)
$buf:=""
C_LONGINT:C283($len; $i)

//初期値
$objBangou.prefix:=""
$objBangou.last_numbers:=""
$objBangou.pos:=0

//文字列を一文字ずつ評価、区切り文字を探す
$len:=Length:C16($bangou)
For ($i; $len; 1; -1)
	//最後の文字から評価していく
	$chr:=Substring:C12($bangou; $i; 1)
	$isNumber:=JCL_str_IsNumber($chr)
	If ($isNumber=True:C214)
		//数字ならバッファにアペンド
		$buf:=$chr+$buf
		$objBangou.last_numbers:=$buf
		$objBangou.pos:=$i
		
	Else 
		//はじめて数字じゃない文字を検出
		$prefix:=Substring:C12($bangou; 1; $i)
		
		//返すオブジェクト変数に代入
		$objBangou.prefix:=$prefix
		$objBangou.last_numbers:=$buf
		$objBangou.pos:=$i
		
		$i:=1  //ループ終了
		
	End if 
End for 

$0:=$objBangou.pos
