//%attributes = {}
  //JCL_fields_Import_toRes
  //20210202 ike wat
  //フィールズをリソースフォルダにコピー

C_LONGINT:C283($dlg_ok)
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_TEXT:C284($fileText)  //読み込んだファイル

  //定義ファイル「fields」を選択
  //ファイルオープンダイアログ
$dlg_ok:=JCL_file_SelectFileDlg (->$fileBlob)
If ($dlg_ok=1)
	
	C_TEXT:C284($outPath;$outFilePath)
	C_TEXT:C284($frmName)
	  //リソースフォルダにコピーを保存
	$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Resources")
	$outFilePath:=JCL_file_MakeFilePath ($folderPath;"JCL4D_Resources")
	  //$outFilePath:=JCL_file_MakeFilePath ($outFilePath;"tbl_definitions")
	$outFilePath:=JCL_file_MakeFilePath ($outFilePath;"fields.txt")
	
	$fileText:=BLOB to text:C555($fileBlob;UTF8 text without length:K22:17)
	TEXT TO DOCUMENT:C1237($outFilePath;$fileText)
	
End if 
