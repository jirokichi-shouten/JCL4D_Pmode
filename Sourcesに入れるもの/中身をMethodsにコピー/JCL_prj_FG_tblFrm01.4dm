//%attributes = {}
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
$filePath:=JCL_file_MakeFilePath ($folderPath;"frm01.txt")
$body:=Document to text:C1236($filePath;"UTF-8";Document with native format:K24:19)

  //フォームのタイトル文字列
$title_body:=JCL_prj_FG_frm_title ($folderPath;$objFrm)
$body:=Replace string:C233($body;"[--frm_title]";$title_body)

  //フォームの件数文字列
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_varNumOfRecs.txt")
$body:=Replace string:C233($body;"[--frm_varNumOfRecs]";$btn_body)

  //フォームのAddボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnAdd.txt")
$body:=Replace string:C233($body;"[--frm_btnAdd]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnAdd")

  //フォームのModボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnMod.txt")
$body:=Replace string:C233($body;"[--frm_btnMod]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnMod")

  //フォームのDelボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnDel.txt")
$body:=Replace string:C233($body;"[--frm_btnDel]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnDel")

  //フォームのCloseボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnClose.txt")
$body:=Replace string:C233($body;"[--frm_btnClose]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnClose")

  //フォームのExportボタン
$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnExport.txt")
$body:=Replace string:C233($body;"[--frm_btnExport]";$btn_body)
  //オブジェクトメソッドを作成
JCL_prj_FG_tblObjMethod ($objFrm;"_btnExport")

  //リストボックス用の文字列を作成、リストボックス部を置き換え
$lst_body:=JCL_prj_FG_frm_lst ($folderPath;$objFrm.prefix;$aryFieldNamePtr;$aryFieldTypePtr;$aryFieldLengthPtr)
$body:=Replace string:C233($body;"[--frm_lst]";$lst_body)
JCL_prj_FG_tblObjMethod ($objFrm;"_lst"+$objFrm.tbl_prefix)

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
