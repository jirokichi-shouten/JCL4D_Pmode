//JCL_file_SelectFolder_forWrite
  //20220916 hisa wat
  //フォルダ選択ダイアログを表示して
  //選択されたかどうか・選択されたフォルダのパスを返す

C_POINTER($1)  //フォルダパスのポインタ
C_LONGINT($0;$open_ok)
C_TEXT($folder_Path)

  //エラーコール
ON ERR CALL("JCL_file_OnErrorCall")

  //フォルダ選択ダイアログを表示
$folder_Path:=Select folder
$open_ok:=OK


  //エラーコール終了
ON ERR CALL("")

$1->:=$folder_Path
$0:=$open_ok
