//%attributes = {}
//JCL_fields_cache
//20210210 ike wat
//キャッシュからラベルを取得

C_LONGINT:C283($i; $numOfLines)
C_TEXT:C284($fldName; $label; $prefix)
ARRAY TEXT:C222(vJCL_fields_tblName; 0)
ARRAY TEXT:C222(vJCL_fields_tblLabel; 0)
ARRAY TEXT:C222(vJCL_fields_name; 0)
ARRAY TEXT:C222(vJCL_fields_label; 0)
C_LONGINT:C283($numOfItems)
ARRAY TEXT:C222($lineAry; 0)
ARRAY TEXT:C222($itemAry; 0)

//リソースフォルダからフィールズを読み込む
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Resources")
$outFilePath:=JCL_file_MakeFilePath($folderPath; "JCL4D_Resources")
//$outFilePath:=JCL_file_MakeFilePath ($outFilePath;"tbl_definitions")
$outFilePath:=JCL_file_MakeFilePath($outFilePath; "fields.txt")

$fileText:=Document to text:C1236($outFilePath; UTF8 text without length:K22:17)
If ($fileText#"")
	
	//改行コードをLFに統一
	$fileText:=JCL_str_ReplaceReturn($fileText)  //add_ikeda 20221228
	
	//改行で切り分ける
	$numOfLines:=JCL_str_Extract_byReturn($fileText; ->$lineAry)  //add_ikeda 20221227
	
	
	//最初のテーブル名を取得
	$numOfItems:=JCL_str_Extract($lineAry{1}; Char:C90(Tab:K15:37); ->$itemAry)
	APPEND TO ARRAY:C911(vJCL_fields_tblName; $itemAry{1})  // テーブル名
	$prefix:=$itemAry{2}
	APPEND TO ARRAY:C911(vJCL_fields_tblLabel; $itemAry{6})  // ラベル
	
	//ヘッダなし、１行目からテーブル名を探す
	For ($i; 2; $numOfLines-1)
		
		DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
		$numOfItems:=JCL_str_Extract($lineAry{$i}; Char:C90(Tab:K15:37); ->$itemAry)
		If ($itemAry{1}="_")
			//＿（アンダースコア）の次の行からテーブル名を取得
			DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
			$numOfItems:=JCL_str_Extract($lineAry{$i+1}; Char:C90(Tab:K15:37); ->$itemAry)
			If ($itemAry{1}#"")
				
				APPEND TO ARRAY:C911(vJCL_fields_tblName; $itemAry{1})  // テーブル名
				$prefix:=$itemAry{2}
				APPEND TO ARRAY:C911(vJCL_fields_tblLabel; $itemAry{6})  // ラベル
				$i:=$i+1  //20210210 次の行はテーブル名なので飛ばす
				
			End if 
		Else 
			//アンダーバーじゃなかったらフィールド名の配列に追加
			$fldName:=$prefix+"_"+$itemAry{1}
			$label:=$itemAry{6}
			
			APPEND TO ARRAY:C911(vJCL_fields_name; $fldName)  //フィールド名
			APPEND TO ARRAY:C911(vJCL_fields_label; $label)  //フィールドラベル
			
		End if 
	End for 
	
End if 
//ALERT("end")
