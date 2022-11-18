//%attributes = {"shared":true}
  //JCL_str_Remove_LeftSpace
  //20180801 wat
  //会計ジロウで作成、行頭のスペースを取り除く

C_TEXT:C284($1;$inText)
$inText:=$1  //テキスト
C_TEXT:C284($0;$buf)
$buf:=""
C_TEXT:C284($LF)
  //$CRLF:=Char(Carriage return)+Char(Line feed)
$LF:=Char:C90(Line feed:K15:40)
C_LONGINT:C283($len)
C_TEXT:C284($chr)
C_TEXT:C284($mode)
$mode:=""

$len:=Length:C16($inText)
For ($i;1;$len)
	
	$chr:=Substring:C12($inText;$i;1)
	If ($chr=$LF)
		  //改行なら行頭モード
		$mode:="left"
		$buf:=$buf+$chr
		
	Else 
		
		If ($chr=" ")
			  //行頭スペースなら取り除く
			If ($mode="left")
				  //このときだけバフに追加しない
				
			Else 
				$buf:=$buf+$chr
				
			End if 
			
		Else 
			  //スペース以外の文字が来たら、行頭モードを解除
			$mode:="mid"
			$buf:=$buf+$chr
			
		End if 
	End if 
End for 

$0:=$buf
