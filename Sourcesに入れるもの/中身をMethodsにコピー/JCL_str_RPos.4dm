//%attributes = {"shared":true}
  //JCL_str_RPos
  //20170711 yabe
  //JCL_str_RPosは、aStringの中でfindが最後に現われる位置を
  //aStringの中にfindが見つからない場合は、JCL_str_RPosはゼロ(0)を返します。
  //findが見つかると、aStringの中に検索文字列が最初に表示され
  //空のstringに対して空のfindを指定すると、JCL_str_RPos はゼロ(0) を返します。

C_TEXT:C284($1;$find)
$find:=$1
C_TEXT:C284($2;$inStr)
$inStr:=$2
C_LONGINT:C283($0;$pos)
$pos:=0

If ((Length:C16($find)>0) & (Length:C16($inStr)>0))
	
	ARRAY LONGINT:C221($ary_pos;0)
	$pos:=Position:C15($find;$inStr)
	While ($pos#0)
		APPEND TO ARRAY:C911($ary_pos;$pos)
		$pos:=Position:C15($find;$inStr;$pos+1)
	End while 
	
	If (Size of array:C274($ary_pos)#0)
		
		$pos:=$ary_pos{Size of array:C274($ary_pos)}
		
	End if 
	
End if 

$0:=$pos
