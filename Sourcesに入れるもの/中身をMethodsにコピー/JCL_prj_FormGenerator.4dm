//%attributes = {}
  //JCL_prj_FormGenerator
  //20210127 ike wat
  //20210202 ike wat
  //フォームジェネレータ、テキストファイルからテンプレートを読み込んでテキストファイルを書き出す、プロジェクトフォーム用
  //20210217 ike wat rename

ARRAY TEXT:C222($aryFieldName;0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType;0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryFieldLength;0)  //文字長さの配列
ARRAY TEXT:C222($aryFieldIndex;0)

C_TEXT:C284($prefix;$inputFrmName;$inputTblName)
C_LONGINT:C283($pos)
$inputFrmName:=Request:C163("フォーム名を入力：PM03_Listとか")  //フォーム名
$pos:=Position:C15("_";$inputFrmName)
$prefix:=Substring:C12($inputFrmName;1;$pos-1)  //フォーム名のプリフィックス
$inputTblName:=Request:C163("PM03にTAのリストを作る時、テーブル名を入力：taikaiとか")  //テーブル名
If (OK=1)
	  //テーブルからプリフィックスを取得、
	JCL_tbl_Fields_withAttr ($inputTblName;->$aryFieldName;->$aryFieldType;->$aryFieldLength;->$aryFieldIndex)
	$sizeOfAry:=Size of array:C274($aryFieldName)
	If ($sizeOfAry>0)
		JCL_fields_cache 
	End if 
	C_LONGINT:C283($pos)
	C_TEXT:C284($tbl_prefix)
	$pos:=Position:C15("_";$aryFieldName{1})
	$tbl_prefix:=Substring:C12($aryFieldName{1};1;$pos-1)  //テーブル名のプリフィックス
	
	  //フォーム作成
	JCL_prj_FG_frm ($tbl_prefix;$prefix;$inputFrmName;$inputTblName;->$aryFieldName;->$aryFieldType;->$aryFieldLength)
	
	  //フォームメソッドを作成
	JCL_prj_FG_frmMethod ($prefix;$inputFrmName)
	
	  //メソッド群を作成
	JCL_prj_FG_methods_list ($prefix;$inputFrmName;$inputTblName;->$aryFieldName;->$aryFieldType)
	  //JCL_prj_FG_methods_form($prefix;$inputFrmName;$inputTblName;->$aryFieldName;->$aryFieldType)
	  //JCL_prj_FG_methods_model($prefix;$inputFrmName;$inputTblName;->$aryFieldName;->$aryFieldType)
	
End if 

ALERT:C41("end")
