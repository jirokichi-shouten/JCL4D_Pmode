//%attributes = {}
//A01_Display
//20210123 jirokichi
//メイン画面をウインドウに表示

C_LONGINT:C283($winRef)
C_TEXT:C284($title)
C_TEXT:C284($frmName)
$frmName:="A01_Main"
$title:="メイン("+$frmName+")"

//クローズボックスなし、タイトルバー付のウインドウを作成する
$winRef:=Open form window:C675($frmName; Plain dialog box:K34:4; Horizontally centered:K39:1; Vertically centered:K39:4; *)

SET WINDOW TITLE:C213($title)

DIALOG:C40($frmName)  //ウインドウにフォームを表示する
CLOSE WINDOW:C154  //ウインドウを閉じる
