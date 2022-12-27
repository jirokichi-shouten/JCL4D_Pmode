//%attributes = {}
//JCL_wait_SampleCode
//20130606 yabe
//ウェイトダイアログをテストする

C_BOOLEAN:C305($done)
C_LONGINT:C283($progress)

JCL_wait_DefInit

JCL_wait_Show("ウェイトダイアログテスト")

$progress:=0

While (($progress<=1000) & ($done=False:C215))
	
	JCL_wait_SetValue("あ"+String:C10($progress); $progress; 1000)
	
	DELAY PROCESS:C323(Current process:C322; 1)
	
	$done:=JCL_wait_IsCancel
	$progress:=$progress+1
	
End while 

JCL_wait_Cancel
ALERT:C41("end")
