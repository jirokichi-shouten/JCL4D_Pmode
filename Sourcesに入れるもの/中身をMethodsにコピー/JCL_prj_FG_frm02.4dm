//%attributes = {}
  //  //JCL_prj_FG_frm02
  //  //20210330 ike wat
  //  //入力フォームを作成
  //  //JCL_prj_FG_frm
  //  //20210217 ike wat
  //  //フォーム作成
  //  //202010317 ike wat ボタンとテキストを配置OK
  //  //20210608 wat 引数をオブジェクト型に変更

  //C_OBJECT($1;$objFrm)
  //$objFrm:=$1
  //C_POINTER($2;$aryFieldNamePtr)
  //$aryFieldNamePtr:=$2
  //C_POINTER($3;$aryFieldTypePtr)
  //$aryFieldTypePtr:=$3
  //C_POINTER($4;$aryFieldLengthPtr)
  //$aryFieldLengthPtr:=$4
  //C_TEXT($folderPath;$filePath)
  //C_TEXT($body)
  //C_TEXT($title_body;$btn_body)
  //C_TEXT($lst_body)

  //  //ファイルの内容を読み込んで　エンコード
  //$folderPath:=JCL_file_MakeFilePath (Get 4D folder(Database folder);"Resources")
  //$folderPath:=JCL_file_MakeFilePath ($folderPath;"JCL4D_Resources")
  //$folderPath:=JCL_file_MakeFilePath ($folderPath;"frm_templates")
  //$filePath:=JCL_file_MakeFilePath ($folderPath;"frm02.txt")
  //$body:=Document to text($filePath;"UTF-8";Document with native format)

  //  //フォームのタイトル文字列
  //$title_body:=JCL_prj_FG_frm02_title ($folderPath;$objFrm)
  //$body:=Replace string($body;"[--frm_varTitle]";$title_body)

  //  //フォームのOKボタン
  //$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnOK.txt")  //template file name
  //$body:=Replace string($body;"[--frm_btnOK]";$btn_body)  //form_template tag
  //  //オブジェクトメソッドを作成
  //JCL_prj_FG_objMethod ($objFrm;"_btnOK")  //method generate

  //  //フォームのCancelボタン
  //$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnCancel.txt")
  //$body:=Replace string($body;"[--frm_btnCancel]";$btn_body)
  //  //オブジェクトメソッドを作成
  //JCL_prj_FG_objMethod ($objFrm;"_btnCancel")

  //  //フォームのDeleteボタン
  //$btn_body:=JCL_prj_FG_frm_obj ($folderPath;$objFrm.prefix;"frm_btnDelete.txt")
  //$body:=Replace string($body;"[--frm_btnDelete]";$btn_body)
  //  //オブジェクトメソッドを作成
  //JCL_prj_FG_objMethod ($objFrm;"_btnDelete")

  //  //名前を変えて保存、
  //C_TEXT($outPath;$outFolderPath;$outFilePath)
  //C_TEXT($frmName)
  //  //$frmName:="A00_test1"
  //$folderPath:=JCL_file_MakeFilePath (Get 4D folder(Database folder);"Project")
  //$folderPath:=JCL_file_MakeFilePath ($folderPath;"Sources")
  //$folderPath:=JCL_file_MakeFilePath ($folderPath;"Forms")
  //$outFolderPath:=JCL_file_MakeFilePath ($folderPath;$objFrm.frmName)
  //$outFilePath:=JCL_file_MakeFilePath ($outFolderPath;"form.4DForm")
  //TEXT TO DOCUMENT($outFilePath;$body)
