//%attributes = {}
  //JCL_lst_remake_byStructure
  //20210125 wat
  //テーブル名を元に、フィールド定義から、リストボックスの配列変数群を作成、フォームプリフィックスは手入力
  //usage
  // 1) リストボックスを作成、たとえばTA01のリストボックスTA01_lstTAをコピーして持ってきて、PM03_lstTAを作成
  // 2) オンロードメソッドPM03_frmOnloadに、PM03_frmDefInit_TA, PM03_lstTA_Make, PM03_lstTA_SetControlsValuesを追記
  // 3) リストボックスのオブジェクトメソッドを変更
  // 4) 選択行の$ta_idについてセッターゲッターを用意
  // 5) PM03_lstPM_Makeに$ta_idをゲッターで取得してクエリーに渡して絞り込む

C_TEXT:C284($msg)
C_LONGINT:C283($numOfCols)
C_LONGINT:C283($i;$sizeOfAry)
C_TEXT:C284($inputTblName;$inputFrmPrefix;$tablePrefix)
ARRAY TEXT:C222($aryFieldName;0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType;0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryFieldLength;0)  //文字長さの配列
ARRAY TEXT:C222($aryFieldIndex;0)
C_TEXT:C284($colName)

$inputFrmPrefix:=Request:C163("フォームのプリフィックスを入力：PM03とか")  //フィールド名のプリフィックス
$inputTblName:=Request:C163("PM03にTAのリストを作る時、テーブル名を入力：taikaiとか")  //テーブル名
If (OK=1)
	  //リストボックスの名前
	$tablePrefix:=JCL_tbl_GetPrefix_fromStructure ($inputTblName)
	$lstbxName:=$inputFrmPrefix+"lst"+$tablePrefix
	$objPtr:=OBJECT Get pointer:C1124(Object named:K67:5;$lstbxName)
	If ($objPtr#Null:C1517)
		  //リストボックスの列をすべて削除
		$numOfCols:=LISTBOX Get number of columns:C831(*;$lstbxName)
		LISTBOX DELETE COLUMN:C830(*;$lstbxName;1;$numOfCols)
		
		
		JCL_tbl_Fields_withAttr ($inputTblName;->$aryFieldName;->$aryFieldType;->$aryFieldLength;->$aryFieldIndex)
		$sizeOfAry:=Size of array:C274($aryFieldName)
		For ($i;1;$sizeOfAry)
			  //配列名を作成
			$colName:=$inputFrmPrefix+"lst"+$tablePrefix+$aryFieldName{$i}
			
			LISTBOX INSERT COLUMN:C829(*;$lstbxName;1;$colName;$aryFieldName;"H"+$colName;vDummy)
			  //LISTBOX INSERT COLUMN(*;$lstbxName;1;$colName;$aryFieldName;"H"+$colName;"H"+$colName)
			
		End for 
		
		$msg:="完了"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+"リストボックス「"+$lstbxName+"」に"+String:C10($sizeOfAry)+"個の列を挿入しました。"
		ALERT:C41($msg)
		
	Else 
		$msg:="リストボックス不明"+Char:C90(Carriage return:K15:38)
		$msg:=$msg+"リストボックス「"+$lstbxName+"」が見つかりませんでした。"
		ALERT:C41($msg)
		
	End if 
End if 
