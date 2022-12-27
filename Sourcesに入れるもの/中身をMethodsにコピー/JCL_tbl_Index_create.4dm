//%attributes = {"shared":true}
//JCL_tbl_Index_create
//JCL_tbl_CreatIndex
//20121001 wat rename, 20130430 mod
//テーブルを作成

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_TEXT:C284($2; $inTableName)
$inTableName:=$2  //テーブル名
C_LONGINT:C283($3; $inStartLineNr)
$inStartLineNr:=$3  //テーブル定義始まりの行番号,スタート行番号
C_TEXT:C284($4; $inPrefix)
$inPrefix:=$4  //フィールドのプリフィックス
C_LONGINT:C283($0; $cnt)
ARRAY TEXT:C222($lineAry; 0)
ARRAY TEXT:C222($itemAry; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryCharLength; 0)  //文字長さの配列
ARRAY TEXT:C222($aryIndex; 0)  //インデックス
C_POINTER:C301($fldPtr)
C_TEXT:C284($fldName)
C_LONGINT:C283($retCode)
ARRAY POINTER:C280($fldAry; 0)

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$lineAry)  //add_ikeda 20221227

//スタート行番号の次の行からフィールド定義を得る
For ($i; $inStartLineNr+1; $numOfLines)
	
	DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
	$numOfItems:=JCL_str_Extract($lineAry{$i}; Char:C90(Tab:K15:37); ->$itemAry)
	If (4<=$numOfItems)
		
		If ($itemAry{1}#"_")
			
			//最初のセルが＿（アンダーバー）じゃなかったらフィールド情報取得
			APPEND TO ARRAY:C911($aryFieldName; $itemAry{1})  //フィールド名
			APPEND TO ARRAY:C911($aryFieldType; $itemAry{2})  //タイプ
			APPEND TO ARRAY:C911($aryCharLength; $itemAry{3})  //文字長さ
			APPEND TO ARRAY:C911($aryIndex; $itemAry{4})  //インデックス
			
			//インデックス作成
			If ($itemAry{4}="1")
				
				$tblPtr:=JCL_tbl_Ptr_byName($inTableName)
				$fldName:=$inPrefix+"_"+$itemAry{1}  //20130501
				$retCode:=JCL_tbl_Fld_GetPtr($tblPtr; $fldName; ->$fldPtr)
				If ($retCode=0)
					
					DELETE FROM ARRAY:C228($fldAry; 1; Size of array:C274($fldAry))
					APPEND TO ARRAY:C911($fldAry; $fldPtr)
					
					$indexName:=$inPrefix+$itemAry{1}+"index"
					CREATE INDEX:C966($tblPtr->; $fldAry; 0; $indexName)
					
				End if 
				
			End if 
			
		Else 
			
			//最初のセルが＿（アンダーバー）だったらフィールド情報取得は終わり
			$i:=$numOfLines+1  //ループを抜ける
			
		End if 
		
	Else 
		
		$i:=$numOfLines+1  //ループを抜ける
		
	End if 
	
End for 

$0:=$cnt
