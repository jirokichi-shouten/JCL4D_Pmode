//%attributes = {}
//JCL_D01_lstTB
//20220430 wat
//テーブル名をクリックして選択できる

C_LONGINT:C283($frmEvnt)

$frmEvnt:=Form event code:C388
Case of 
	: ($frmEvnt=On Clicked:K2:4)
		$tblName:=JCL_lst_Selected_Str(->vD01_lstTB; ->vD01_lstTB_NAME)
		
		$index:=Find in array:C230(vJCL_D01_aryTableName; $tblName)
		If ($index#-1)
			vJCL_D01_aryTableName:=$index
			
		End if 
		
		vJCL_D01_objFrm.tblName:=$tblName
		
		
End case 