//%attributes = {"shared":true}
  //JCL_file_csv_ReadRow
  //20130718
  //JCL_file_tab_ReadRow
  //20101220 wat new
  //タブ区切りテキストファイルから読み込み、配列に返す
  //usage: JCL_file_tab_ReadRow($fileRef;->$ary;$numOfCols)

C_TIME:C306($1;$FileRef)
$FileRef:=$1  //ファイル参照
C_LONGINT:C283($2;$numOfCols)
$numOfCols:=$2  //1行から切り出す文字列の数（列数）
C_POINTER:C301($3;$ary_ptr)
$ary_ptr:=$3  //配列を第二引数ポインタに返す
C_LONGINT:C283($0;$receive_ok)  //レシーブがあれば１，なければゼロ
C_TEXT:C284($str)

For ($i;1;$numOfCols)
	
	If ($i<$numOfCols)
		  //ファイルからひとつ読み込む
		  //$receive_ok:=JCL_file_ReadSJIS ($FileRef;Char(44);->$str)
		$receive_ok:=JCL_file_ReadSJIS ($FileRef;",";->$str)
	Else 
		  //最後に改行まで読み込む
		$receive_ok:=JCL_file_ReadSJIS ($FileRef;Char:C90(Carriage return:K15:38);->$str)
	End if 
	
	If ($receive_ok=1)
		
		  //$str:=Replace string($str;Char(34);"")  `「"」をトル
		$str:=Replace string:C233($str;"\"";"")  //「"」をトル
		
		  //配列に追加
		APPEND TO ARRAY:C911($ary_ptr->;$str)
		
	End if 
	
End for 

$0:=$receive_ok
