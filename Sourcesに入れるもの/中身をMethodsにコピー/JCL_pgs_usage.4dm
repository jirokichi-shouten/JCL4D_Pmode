//%attributes = {"shared":true}
//JCL_pgs_usage
//20111127 wat
//JCL_dlg　プログレスバー 使用方法
//プログレスバーをテストする

//usage1: whileループ

C_BOOLEAN:C305($done)
C_LONGINT:C283($progress)

JCL_pgs_DefInit

JCL_pgs_Show("プログレスバーテスト")

$progress:=0

While (($progress<=1000) & ($done=False:C215))
	
	JCL_pgs_SetValue(($progress/1000)*100; "あ"+String:C10($progress); $progress; 1000)
	
	DELAY PROCESS:C323(Current process:C322; 1)
	
	$done:=JCL_pgs_IsCancel
	$progress:=$progress+1
	
End while 

JCL_pgs_Cancel
ALERT:C41("end")
