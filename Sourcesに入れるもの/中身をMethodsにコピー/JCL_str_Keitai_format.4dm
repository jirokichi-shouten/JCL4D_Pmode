//%attributes = {"shared":true}
  //JCL_str_FormatKeitai 
  //20130606 yabe
  //携帯番号をフォーマット（ハイフンを入れる）

C_TEXT:C284($1;$keitai)
$keitai:=$1

C_TEXT:C284($0;$formatKeitai)
$formatKeitai:=""

C_TEXT:C284($part1;$part2;$part3)

If (Length:C16($keitai)#0)
	
	$part1:=Substring:C12($keitai;1;3)
	$part2:=Substring:C12($keitai;4;4)
	$part3:=Substring:C12($keitai;8)
	
	$formatKeitai:=$part1+"-"+$part2+"-"+$part3
	
End if 

$0:=$formatKeitai
