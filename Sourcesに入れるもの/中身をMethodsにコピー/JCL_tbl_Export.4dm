//%attributes = {"shared":true}
  //JCL_tbl_export 
  //フィールドプロパティをタブ区切りで書き出し
  //20080807　矢部　新規作成
  //20130430　矢部　JCL4Dに追加

C_LONGINT:C283($i;$numOfTables)

ARRAY TEXT:C222($aryTableName;0)
ARRAY TEXT:C222($aryFieldName;0)
ARRAY TEXT:C222($aryFieldType;0)
ARRAY TEXT:C222($aryFieldLength;0)
ARRAY TEXT:C222($aryFieldIndex;0)

  //ファイル保存ダイアログ表示
$doc:=Create document:C266("";"TEXT")
If ((OK=1) & ($doc#0))
	
	JCL_tbl_Names_fromStructure (->$aryTableName)
	$numOfTables:=Size of array:C274($aryTableName)
	
	For ($i;1;$numOfTables)
		
		JCL_tbl_Fields_withAttr ($aryTableName{$i};->$aryFieldName;->$aryFieldType;->$aryFieldLength;->$aryFieldIndex)
		
		JCL_tbl_ExportTable ($doc;$aryTableName{$i};->$aryFieldName;->$aryFieldType;->$aryFieldLength;->$aryFieldIndex)
		
	End for 
	
	  //ファイルを閉じる
	CLOSE DOCUMENT:C267($doc)
	
	  //終了メッセージ
	ALERT:C41("出力が終わりました。")
	
End if 
