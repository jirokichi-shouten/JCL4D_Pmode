//%attributes = {"preemptive":"capable"}
//JCL_str_Extract_mp
//20221016 wat
//JCL_str_Extract
//zz_ExtractText
//20110317 wat
//20121001 wat rename
//文字列ブロックを区切り文字で切り出す

C_TEXT:C284($1; $block)
$block:=$1  //対象文字列ブロック
C_TEXT:C284($2; $separator)
$separator:=$2  //区切り文字
C_POINTER:C301($3; $outAryPtr)
$outAryPtr:=$3  //返す配列
C_LONGINT:C283($0; $sizeOfAry)
$sizeOfAry:=0
C_TEXT:C284($str)
C_LONGINT:C283($len)
C_LONGINT:C283($pos; $nextPos)

$len:=Length:C16($separator)
$pos:=1
$nextPos:=1

Repeat 
	
	$foundPos:=Position:C15($separator; $block; $pos)
	If ($foundPos#0)
		$str:=Substring:C12($block; $pos; $foundPos-$pos)
		$pos:=$foundPos+$len
	Else 
		$str:=Substring:C12($block; $pos)
	End if 
	
	//配列に追加
	APPEND TO ARRAY:C911($outAryPtr->; $str)
	$sizeOfAry:=$sizeOfAry+1
	
Until ($foundPos=0)

$0:=$sizeOfAry
