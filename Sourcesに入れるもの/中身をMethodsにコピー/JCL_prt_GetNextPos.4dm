//%attributes = {"shared":true}
  //JCL_prt_GetNextPos
  //現在の印刷位置から、次のセクションが印刷可能領域に収まるかを判断、収まらなければゼロを返す
  //20171029 wat

C_LONGINT:C283($1;$inPos)
$inPos:=$1
C_LONGINT:C283($2;$section_height)
$section_height:=$2
C_LONGINT:C283($0;$result_feed_pos)
C_LONGINT:C283($page_height)

GET PRINTABLE AREA:C703($page_height)
If (($inPos+$section_height)<$page_height)
	
	  //ページに残りの印刷領域がある場合は　続けて印刷
	$result_feed_pos:=$inPos+$section_height
	
Else 
	
	  //ページに残りの印刷領域がない場合は　ゼロを返す
	$result_feed_pos:=0
	
End if 

$0:=$result_feed_pos
