//%attributes = {"shared":true}
  //JCL_prt_PageBreak
  //20100916 wat new
  //印刷対象が複数ページにまたがるときのページブレーク

C_LONGINT:C283($1;$nombre)
$nombre:=$1  //ページ番号
C_LONGINT:C283($2;$numOfPages)
$numOfPages:=$2  //総ページ数

If ($nombre<$numOfPages)
	
	PAGE BREAK:C6(>)  //途中のページを印刷
	
Else 
	
	If ($nombre=$numOfPages)
		
		PAGE BREAK:C6  //最後のページを印刷
		
	End if 
	
End if 
