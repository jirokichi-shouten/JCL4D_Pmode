//%attributes = {}
  //JCL_prj_FG_tblFrm02
  //20210603 wat
  //JCL_prj_FG_tblFrm01
  //20210330 ike wat
  //テーブルフォーム作成
  //20210608 wat 引数をオブジェクト型に変更

C_OBJECT:C1216($1;$objFrm)
$objFrm:=$1
C_POINTER:C301($2;$aryFieldNamePtr)
$aryFieldNamePtr:=$2
C_POINTER:C301($3;$aryFieldTypePtr)
$aryFieldTypePtr:=$3
C_POINTER:C301($4;$aryFieldLengthPtr)
$aryFieldLengthPtr:=$4
C_TEXT:C284($folderPath;$filePath)
C_TEXT:C284($body)
C_TEXT:C284($title_body;$btn_body)
C_TEXT:C284($lst_body)

  //ファイルの内容を読み込んで　エンコード
$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Resources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"JCL4D_Resources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"frm_templates")
$filePath:=JCL_file_MakeFilePath ($folderPath;"frm02.txt")
$body:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

  //フォームのタイトル文字列
$title_body:=JCL_prj_FG_frm02_title ($folderPath;$objFrm)
$body:=Replace string:C233($body;"[--frm_varTitle]";$title_body)

  //フォームのOKボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnOK.txt")  //template file name
$body:=Replace string:C233($body;"[--frm_btnOK]";$btn_body)  //form_template tag
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnOK")  //method generate

  //フォームのCancelボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnCancel.txt")
$body:=Replace string:C233($body;"[--frm_btnCancel]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnCancel")

  //フォームのDeleteボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnDelete.txt")
$body:=Replace string:C233($body;"[--frm_btnDelete]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnDelete")

  //フィールド用の文字列を作成、複数フィールドを作成
$lst_body:=JCL_prj_FG_frm_flds ($folderPath;$objFrm.prefix;$aryFieldNamePtr;$aryFieldTypePtr;$aryFieldLengthPtr)
$body:=Replace string:C233($body;"[--frm_flds]";$lst_body)

  //名前を変えて保存、
C_TEXT:C284($outPath;$outFolderPath;$outFilePath)
C_TEXT:C284($frmName)
C_LONGINT:C283($tblNr)
C_TEXT:C284($tblNrText)
  //$frmName:="A00_test1"
$folderPath:=JCL_file_MakeFilePath (Get 4D folder:C485(Database folder:K5:14);"Project")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"Sources")
$folderPath:=JCL_file_MakeFilePath ($folderPath;"TableForms")
$tblNr:=JCL_tbl_GetNumber ($objFrm.tblName)  //テーブル番号
$tblNrText:=String:C10($tblNr)
$folderPath:=JCL_file_MakeFilePath ($folderPath;$tblNrText)
$outFolderPath:=JCL_file_MakeFilePath ($folderPath;$objFrm.frmName)
$outFilePath:=JCL_file_MakeFilePath ($outFolderPath;"form.4DForm")
TEXT TO DOCUMENT:C1237($outFilePath;$body)
