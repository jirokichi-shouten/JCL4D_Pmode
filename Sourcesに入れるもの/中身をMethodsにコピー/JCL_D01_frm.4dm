//%attributes = {}
  //JCL_D01_frm
  //20210607 WAT
  //フォームジェネレータのダイアログ、テーブル名とサイズ（黄金比を選択）を入力

  //フォームメソッド

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		JCL_D01_frmOnLoad 
		
End case 
