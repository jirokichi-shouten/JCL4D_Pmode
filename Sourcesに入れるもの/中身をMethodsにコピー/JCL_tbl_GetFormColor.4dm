//%attributes = {}
//JCL_tbl_GetFormColor
//20221006 hisa wat
//生成したテーブルフォームの色を取得、タイトルのバックにあるレクトから
//ex: vFO01_rectTitleのような名前のフォームオブジェクト

C_TEXT:C284($1; $table_name)
$table_name:=$1
C_LONGINT:C283($0; $color)
$color:=0
C_TEXT:C284($tbl_prefix)
C_TEXT:C284($rec_name; $frmPrefix; $form_name)
C_LONGINT:C283($tblNr)
C_POINTER:C301($tblPtr)

//プレフィックス
$tbl_prefix:=JCL_tbl_GetPrefix_fromStructure($table_name)

$rec_name:="v"+$tbl_prefix+"01_rectTitle"
$frmPrefix:=$tbl_prefix+"01"
$form_name:=$frmPrefix+"_List"
$tblNr:=JCL_tbl_GetNumber($table_name)
$tblPtr:=Table:C252($tblNr)

$exist:=JCL_frm_isExist($tblPtr; $form_name)
If ($exist=True:C214)
	FORM LOAD:C1103($tblPtr->; $form_name)
	OBJECT GET RGB COLORS:C1074(*; $rec_name; $color)
	FORM UNLOAD:C1299
	
End if 

$0:=$color
