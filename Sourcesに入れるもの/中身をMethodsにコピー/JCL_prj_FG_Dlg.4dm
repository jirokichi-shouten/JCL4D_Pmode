//%attributes = {}
//JCL_prj_FG_Dlg
//D01_Input
//20210607 wat
//FG ダイアログを表示
//20220430 wat 色選びにこだわってしまうことがある。その時に効率がいいように５色から選ぶようにした。

C_OBJECT:C1216($1; $objFrm)
$objFrm:=$1
C_LONGINT:C283($0; $dlgOk)

//プロセス変数
JCL_D01_DefInit

//画面表示
$dlgOk:=JCL_D01_Display
If ($dlgOk=1)
	//フォームのサイズを返す
	$objFrm.tblName:=vJCL_D01_objFrm.tblName
	$objFrm.width:=vJCL_D01_objFrm.width
	$objFrm.height:=vJCL_D01_objFrm.height
	$objFrm.color_text:=vJCL_D01_objFrm.color_text
	
End if 


$0:=$dlgOk
