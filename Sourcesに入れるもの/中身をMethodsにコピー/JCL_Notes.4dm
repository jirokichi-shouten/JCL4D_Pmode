//%attributes = {"shared":true}
  //JCL_Notes
  //20160504 wat
  //リリースノートとか、お読みくださいとか、Webエリアで見られるように

  // 一覧ウインドウ表示は、本来_Displayだがモジュール化をしないで展開

C_LONGINT:C283($wref)
C_LONGINT:C283($0)
C_TEXT:C284($title)

$wref:=Open form window:C675("N01_List";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
$title:="N01_List"
DIALOG:C40("N01_List")
CLOSE WINDOW:C154($Wref)  //ウィンドウを閉じる 

$0:=OK
