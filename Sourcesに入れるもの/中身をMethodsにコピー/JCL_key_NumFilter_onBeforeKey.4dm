//%attributes = {"shared":true}
  //JCL_key_NumFilter_onBeforeKey
  //20180825 wat
  //A05_lstJO_DEBIT_onBeforeKey
  //20170310 wat
  // キーが押されて、セルに値が入力される前に実行


Case of 
	: (Position:C15(Keystroke:C390;"0123456789.-")>0)
		
	: (Keystroke:C390=Char:C90(Tab:K15:37))  // タブキーで次の列に移動
		
	: (Keystroke:C390=Char:C90(Backspace:K15:36))
		
	: (Keystroke:C390=Char:C90(Backspace key:K12:29))
		
	Else 
		
		FILTER KEYSTROKE:C389("")
		
End case 
