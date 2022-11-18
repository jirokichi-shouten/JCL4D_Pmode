//%attributes = {"shared":true}
//JCL_all_export
//20140810 yabe
//20150902 yabe jiro_dlg対応

C_LONGINT:C283($open_dlg_ok)
C_TEXT:C284($folder_Path)
ARRAY TEXT:C222($aryFileList; 0)

//フォルダダイアログ表示
$open_dlg_ok:=JCL_file_SelectFolder(->$folder_Path; ->$aryFileList)
If ($open_dlg_ok=1)  //フォルダが選択された？
	
	C_BOOLEAN:C305($done)
	JCL_pgs_DefInit
	JCL_pgs_Show("全データ書き出し中")
	
	C_LONGINT:C283($i; $k)
	
	C_TEXT:C284($name)
	C_LONGINT:C283($type)
	C_LONGINT:C283($len)
	C_BOOLEAN:C305($index)
	C_BOOLEAN:C305($unique)
	C_BOOLEAN:C305($visible)
	
	C_LONGINT:C283($open_ok)
	C_TEXT:C284($fileName)
	C_TIME:C306($FileRef)
	C_TEXT:C284($field)
	
	$i:=1
	While (($i<=Get last table number:C254) & ($done=False:C215))
		
		If (Is table number valid:C999($i)=True:C214)
			
			$fileName:=$folder_Path+Table name:C256($i)+".txt"
			$open_ok:=JCL_file_OpenForWrite($fileName; ->$FileRef)
			
			If ($open_ok=1)
				
				// 20140923 「ID」という文字がファイルの先頭にあるとエクセルがSYLKファイルと勘違いするため先頭に空白を出力
				JCL_file_WriteSJIS($FileRef; " ")
				
				$tablePrt:=Table:C252($i)
				READ ONLY:C145($tablePrt->)
				ALL RECORDS:C47($tablePrt->)
				FIRST RECORD:C50($tablePrt->)
				$numOfAllRecs:=Records in selection:C76($tablePrt->)
				
				//フィールド名を書き出し
				For ($k; 1; Get last field number:C255($i))
					
					If (Is field number valid:C1000($i; $k)=True:C214)
						
						$fieldPtr:=Field:C253($i; $k)
						$name:=Field name:C257($i; $k)
						
						JCL_file_WriteSJIS($FileRef; $name)
						JCL_file_WriteTab($FileRef)
						
					End if 
					
				End for 
				
				JCL_file_WriteCRLF($FileRef)
				
				//レコードを書き出し
				$recCount:=1
				While ((Not:C34(End selection:C36($tablePrt->))) & ($done=False:C215))
					//While (Not(End selection($tablePrt->)))
					
					For ($k; 1; Get last field number:C255($i))
						
						If (Is field number valid:C1000($i; $k)=True:C214)
							
							$fieldPtr:=Field:C253($i; $k)
							GET FIELD PROPERTIES:C258($i; $k; $type; $len; $index; $unique; $visible)
							Case of 
								: ($type=Is alpha field:K8:1)
									$field:=$fieldPtr->
									$field:=Replace string:C233($field; Char:C90(Carriage return:K15:38); "<br>")
									$field:=Replace string:C233($field; Char:C90(Line feed:K15:40); "<br>")
								: ($type=Is text:K8:3)
									$field:=$fieldPtr->
									$field:=Replace string:C233($field; Char:C90(Carriage return:K15:38); "<br>")
									$field:=Replace string:C233($field; Char:C90(Line feed:K15:40); "<br>")
								: ($type=Is real:K8:4)
									$field:=String:C10($fieldPtr->)
								: ($type=Is integer:K8:5)
									$field:=String:C10($fieldPtr->)
								: ($type=Is longint:K8:6)
									$field:=String:C10($fieldPtr->)
								: ($type=Is date:K8:7)
									$field:=String:C10($fieldPtr->)
								: ($type=Is time:K8:8)
									$field:=String:C10($fieldPtr->)
								: ($type=Is boolean:K8:9)
									If ($fieldPtr->=True:C214)
										$field:="True"
									Else 
										$field:="False"
									End if 
								: ($type=Is picture:K8:10)
									//書き出ししない
								: ($type=Is subtable:K8:11)
									//書き出ししない
								: ($type=Is BLOB:K8:12)
									//書き出ししない
							End case 
							
							JCL_file_WriteSJIS($FileRef; $field)
							JCL_file_WriteTab($FileRef)
							
							JCL_pgs_SetValue(($i/Get last table number:C254)*100; Table name:C256($i); $recCount; $numOfAllRecs)
							$done:=JCL_pgs_IsCancel
							
						End if 
						
					End for 
					
					JCL_file_WriteCRLF($FileRef)
					NEXT RECORD:C51($tablePrt->)
					$recCount:=$recCount+1
					
				End while 
				
			End if 
			
			//ファイルを閉じる
			JCL_file_Close($FileRef)
			
		End if 
		
		$i:=$i+1
		
	End while 
	
	JCL_pgs_Cancel
	
	//終了メッセージ
	If ($done=True:C214)
		ALERT:C41("出力がキャンセルされました。")
	Else 
		ALERT:C41("出力が終わりました。")
	End if 
	
End if 
