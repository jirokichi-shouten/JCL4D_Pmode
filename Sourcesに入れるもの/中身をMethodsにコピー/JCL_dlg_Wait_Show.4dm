//%attributes = {}
//Jiro_dlg_Wait_Show
//WaitDialogの表示
//$1:メッセーッジ
// 20211227 hisa wat ike

_O_C_STRING:C293(80; $1)
_O_C_STRING:C293(80; $msg)
$msg:=$1

C_LONGINT:C283(<>g50_Counter)
<>g50_Counter:=0

//新しいプロセスに、ダイアログを表示, 20101206 wat スタックサイズを32->512に変更
If (<>gWaitDialog_ProcID=0)
	
	<>gWaitDialog_ProcID:=New process:C317("Jiro_dlg_Wait_Open"; 0; "Jiro_dlg_Wait_Open"; $msg)
	
End if 
