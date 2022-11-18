//%attributes = {"shared":true}
  //zz_obj_LeftTop
  //20160307 wat
  //オブジェクトの左と上を取得、スクリーン絶対座標

C_POINTER:C301($1;$inObjPtr)
$inObjPtr:=$1  //対象となるボタンのポインタ
C_POINTER:C301($2;$3)
C_LONGINT:C283($top;$left)

  //カレンダーダイアログのサイズは、398 x 441
  //ダイアログのサイズは、外からもらうようにした
C_LONGINT:C283($4;$dlg_width)
$dlg_width:=$4
C_LONGINT:C283($5;$dlg_height)
$dlg_height:=$5

C_LONGINT:C283($fw_left;$fw_top;$fw_right;$fw_bottom)
C_LONGINT:C283($objLeft;$objTop;$objRight;$objBottom)
C_LONGINT:C283($scr_height;$scr_width)
C_LONGINT:C283($over_x;$over_y)

  //フロントウインドウの座標
GET WINDOW RECT:C443($fw_left;$fw_top;$fw_right;$fw_bottom)

  //クリックされたボタンの座標
OBJECT GET COORDINATES:C663($inObjPtr->;$objLeft;$objTop;$objRight;$objBottom)

  //スクリーンないに表示されているか、計算して、調整 20160313
$scr_height:=Screen height:C188
$scr_width:=Screen width:C187

  //ライトとボトムを評価、スクリーンからはみ出していたら移動量を求める
$over_x:=($objRight+$fw_left+$dlg_width)-$scr_width
$over_y:=($objBottom+$fw_top+$dlg_height)-$scr_height

If ($over_x<=0)
	  //スクリーン内に表示されている
	$left:=$objRight+$fw_left
	
Else 
	  //スクリーン内に表示されていないので、左へ移動
	$left:=$objRight+$fw_left-$over_x
	
End if 

If ($over_y<=0)
	  //スクリーン内に表示されている
	$top:=$objBottom+$fw_top
	
Else 
	  //スクリーン内に表示されていないので、上へ移動
	$top:=$objBottom+$fw_top-$over_y
	
End if 

$2->:=$left
$3->:=$top
