//%attributes = {"shared":true}
  //JCL_file_SelectFolder
  //20140602 yabe
  //フォルダ選択ダイアログを表示して
  //選択されたかどうか・選択されたフォルダのパス・選択されたフォルダの中身を返す

C_POINTER:C301($1)  //フォルダパスのポインタ
C_POINTER:C301($2;$aryFileListPtr)  //ファイル名配列のポインタ
$aryFileListPtr:=$2

C_LONGINT:C283($0;$open_ok)

C_TEXT:C284($folder_Path)

  //エラーコール
ON ERR CALL:C155("JCL_file_OnErrorCall")

  //フォルダ選択ダイアログを表示
$folder_Path:=Select folder:C670
$open_ok:=OK
If ($open_ok=1)
	
	DOCUMENT LIST:C474($folder_Path;$aryFileListPtr->)
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

$1->:=$folder_Path
$0:=$open_ok
