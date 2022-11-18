//%attributes = {}
  //JCL_prj_fg_fldNextPos
  //20210606 wat
  //次のフィールドの位置（top, left, ）を返す

C_OBJECT:C1216($1;$inObj)
$inObj:=$1
C_OBJECT:C1216($0;$outObj)
$outObj:=$inObj

C_LONGINT:C283($top;$left)

C_LONGINT:C283($first_top)
$first_top:=90
C_LONGINT:C283($v_interval;$h_interval)
$v_interval:=26
$h_interval:=246
$h_interval:=398
C_LONGINT:C283($form_height)
$form_height:=674
$form_height:=178  //debug


$top:=$inObj.top+$v_interval
$top:=$inObj.top+$v_interval
If ($top>=$form_height)
	  //フォームの高さからはみ出している。次の列の一番上の座標
	$outObj.top:=$first_top
	$outObj.left:=$inObj.left+$h_interval
	$outObj.label_left:=$inObj.label_left+$h_interval
	
Else 
	  //はみ出さなければ、一つ下の座標
	$outObj.top:=$inObj.top+$v_interval
	$outObj.left:=$inObj.left
	$outObj.label_left:=$inObj.label_left
	
End if 

$0:=$outObj
