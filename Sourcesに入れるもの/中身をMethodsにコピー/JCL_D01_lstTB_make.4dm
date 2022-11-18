//%attributes = {}
//JCL_D01_lstTB_make
//20220425 hisa wat
//カラーテーブル
//20221006 hisa wat

C_TEXT:C284($table_name)
ARRAY TEXT:C222($aryTblNames; 0)
C_LONGINT:C283($sizeOfAry; $i)
C_LONGINT:C283($color)

//すべてのテーブル
JCL_tbl_Names_fromStructure(->$aryTblNames)

COPY ARRAY:C226($aryTblNames; vD01_lstTB_NAME)

$sizeOfAry:=Size of array:C274(vD01_lstTB_NAME)
ARRAY LONGINT:C221(vD01_lstTB_Nr; $sizeOfAry)
ARRAY LONGINT:C221(vD01_lstTB_COLOR; $sizeOfAry)
For ($i; 1; $sizeOfAry)
	//配列を追加
	vD01_lstTB_Nr{$i}:=$i
	
	$table_name:=vD01_lstTB_NAME{$i}
	
	//生成したテーブルフォームの色を取得、タイトルのバックにあるレクトから
	$color:=JCL_tbl_GetFormColor($table_name)
	
	//リストボックスに適用
	If ($color#0)
		//ゼロは白なのでスキップ、実行すると黒になるため
		LISTBOX SET ROW COLOR:C1270(*; "vD01_lstTB_COLOR"; $i; $color; lk background color:K53:25)
		
	End if 
	
	vD01_lstTB_COLOR{$i}:=$color
	
End for 
