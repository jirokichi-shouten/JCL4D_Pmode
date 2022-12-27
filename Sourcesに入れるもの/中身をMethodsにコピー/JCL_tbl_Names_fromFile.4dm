//%attributes = {"shared":true}
//JCL_tbl_Names_fromFile
//JCL_tbl_GetNames
//20111005 wat
//20121001 wat rename, 20130429 wat mod , 20130430 mod
//20150826 yabe フォーム作成フラグ追加
//テーブル名の配列を得る

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_POINTER:C301($2; $outAryTableNamePtr)
$outAryTableNamePtr:=$2  //テーブル名の配列のポインタ
C_POINTER:C301($3; $outAryStartLineNrPtr)
$outAryStartLineNrPtr:=$3  //テーブル定義始まりの行番号の配列のポインタ
C_POINTER:C301($4; $outAryPrefixPtr)
$outAryPrefixPtr:=$4  //フィールド名のプリフィックスの配列のポインタ
C_POINTER:C301($5; $outAryFormsFlagPtr)
$outAryFormsFlagPtr:=$5  //20150826 フォーム作成フラグの配列のポインタ
C_LONGINT:C283($0; $cnt)
ARRAY TEXT:C222($lineAry; 0)
ARRAY TEXT:C222($itemAry; 0)
C_LONGINT:C283($numOfLines; $numOfItems)

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$lineAry)  //add_ikeda 20221227

//最初のテーブル名を取得
$numOfItems:=JCL_str_Extract($lineAry{1}; Char:C90(Tab:K15:37); ->$itemAry)
APPEND TO ARRAY:C911($outAryTableNamePtr->; $itemAry{1})
//APPEND TO ARRAY($outAryPrefixPtr->;$itemAry{2}+"_")//外部ファイルに＿は不要
APPEND TO ARRAY:C911($outAryPrefixPtr->; $itemAry{2})  //20130501 使うときに＿をつける
APPEND TO ARRAY:C911($outAryFormsFlagPtr->; $itemAry{3})  //20150826 フォーム作成フラグ
APPEND TO ARRAY:C911($outAryStartLineNrPtr->; 1)
$cnt:=$cnt+1

//ヘッダなし、１行目からテーブル名を探す
For ($i; 2; $numOfLines-1)
	
	DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
	$numOfItems:=JCL_str_Extract($lineAry{$i}; Char:C90(Tab:K15:37); ->$itemAry)
	If ($itemAry{1}="_")
		
		//＿（アンダースコア）の次の行からテーブル名を取得
		DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
		$numOfItems:=JCL_str_Extract($lineAry{$i+1}; Char:C90(Tab:K15:37); ->$itemAry)
		If ($itemAry{1}#"")
			
			APPEND TO ARRAY:C911($outAryTableNamePtr->; $itemAry{1})
			//APPEND TO ARRAY($outAryPrefixPtr->;$itemAry{2}+"_")//外部ファイルに＿は不要
			APPEND TO ARRAY:C911($outAryPrefixPtr->; $itemAry{2})  //20130501 使うときに＿をつける
			APPEND TO ARRAY:C911($outAryFormsFlagPtr->; $itemAry{3})  //20150826 フォーム作成フラグ
			APPEND TO ARRAY:C911($outAryStartLineNrPtr->; $i+1)
			$cnt:=$cnt+1
			
		End if 
		
	End if 
	
End for 

$0:=$cnt
