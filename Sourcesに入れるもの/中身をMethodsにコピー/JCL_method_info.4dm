//%attributes = {"shared":true}
//JCL_method_info
//20170625 yabe
//メソッド名、更新日時、コメント（最初のから行まで）をタブ区切りでデスクトップに書き出す

ARRAY TEXT:C222($ary_method_names; 0)

//すべてのメソッド名を配列に取得
METHOD GET NAMES:C1166($ary_method_names)

//メソッドの更新日時を配列に取得し、並び替え
ARRAY DATE:C224($ary_method_dates; 0)
ARRAY LONGINT:C221($ary_method_times; 0)
METHOD GET MODIFICATION DATE:C1170($ary_method_names; $ary_method_dates; $ary_method_times)
MULTI SORT ARRAY:C718($ary_method_dates; <; $ary_method_times; <; $ary_method_names; >)

$structure_name:=JCL_file_StructureName

//ストラクチャ名・デイトマークをつけたファイル名で保存先を開く
C_TEXT:C284($folderPath; $filePath)
$folderPath:=System folder:C487(Desktop:K41:16)
C_TEXT:C284($output_file_name)
C_TIME:C306($FileRef)  //ファイル参照
$output_file_name:=$structure_name+"_"+JCL_str_Datemark(Current date:C33; Current time:C178)+".txt"
$filePath:=JCL_file_MakeFilePath($folderPath; $output_file_name)
$open_ok:=JCL_file_OpenForWrite($filePath; ->$FileRef)

C_TEXT:C284($method)
ARRAY TEXT:C222($ary_lines; 0)
C_LONGINT:C283($line_count)
C_TEXT:C284($out_method_line)

//ファイルに書き出す
If ($open_ok=1)
	
	For ($i; 1; Size of array:C274($ary_method_names))
		
		If (Size of array:C274($ary_lines)>0)
			DELETE FROM ARRAY:C228($ary_lines; 1; Size of array:C274($ary_lines))
		End if 
		
		$out_method_line:=""
		
		//メソッドの中身を取得し改行で切り分ける
		METHOD GET CODE:C1190($ary_method_names{$i}; $method)
		$line_count:=JCL_str_Extract($method; Char:C90(Carriage return:K15:38); ->$ary_lines)
		
		//4DのMETHOD GET CODEで付加されるコメントを除き空行までを連結
		//念のためLine feedを削除
		For ($k; 2; $line_count)
			
			If ($ary_lines{$k}="")
				$k:=$line_count
			Else 
				$out_method_line:=$out_method_line+Replace string:C233($ary_lines{$k}; Char:C90(Line feed:K15:40); "")+Char:C90(Tab:K15:37)
			End if 
			
		End for 
		
		//タブ区切りで書き出す
		JCL_file_WriteSJIS($FileRef; $ary_method_names{$i})
		JCL_file_WriteTab($FileRef)
		JCL_file_WriteSJIS($FileRef; String:C10($ary_method_dates{$i}))
		JCL_file_WriteTab($FileRef)
		JCL_file_WriteSJIS($FileRef; Time string:C180($ary_method_times{$i}))
		JCL_file_WriteTab($FileRef)
		JCL_file_WriteSJIS($FileRef; $out_method_line)
		JCL_file_WriteCRLF($FileRef)
		
	End for 
	
	//ファイルを閉じる
	CLOSE DOCUMENT:C267($FileRef)
	
End if 

ALERT:C41($filePath+"を保存しました。")
