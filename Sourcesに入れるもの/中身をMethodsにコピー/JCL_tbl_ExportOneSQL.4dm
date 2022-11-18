//%attributes = {"shared":true}
  //JCL_tbl_ExportOneSQL
  //20130109 wat
  //テーブル定義をテキストファイルに書き出す、アペンド

C_TEXT:C284($1;$inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_TEXT:C284($2;$inTableName)
$inTableName:=$2  //テーブル名
C_LONGINT:C283($3;$inStartLineNr)
$inStartLineNr:=$3  //テーブル定義始まりの行番号,スタート行番号
C_TEXT:C284($4;$inPrefix)
$inPrefix:=$4  //フィールドのプリフィックス
ARRAY TEXT:C222($lineAry;0)
ARRAY TEXT:C222($itemAry;0)
C_LONGINT:C283($numOfLines;$numOfItems;$sizeOfAry)
ARRAY TEXT:C222($aryFieldName;0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType;0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryCharLength;0)  //文字長さの配列
C_TEXT:C284($sql)

  //改行で切り分ける
$numOfLines:=JCL_str_Extract ($inFileText;Char:C90(Carriage return:K15:38);->$lineAry)

  //スタート行番号の次の行からフィールド定義を得る
For ($i;$inStartLineNr+1;$numOfLines)
	
	DELETE FROM ARRAY:C228($itemAry;1;Size of array:C274($itemAry))
	$numOfItems:=JCL_str_Extract ($lineAry{$i};Char:C90(Tab:K15:37);->$itemAry)
	If (4<=$numOfItems)
		
		APPEND TO ARRAY:C911($aryFieldName;$itemAry{2})  //フィールド名
		APPEND TO ARRAY:C911($aryFieldType;$itemAry{3})  //タイプ
		APPEND TO ARRAY:C911($aryCharLength;$itemAry{4})  //文字長さ
		
	Else 
		
		$i:=$numOfLines+1  //ループを抜ける
		
	End if 
	
End for 

  //テーブル作成
$sql:="CREATE TABLE "+$inTableName+"("
$sizeOfAry:=Size of array:C274($aryFieldName)
For ($i;1;$sizeOfAry)
	
	  //ＳＱＬのカラム定義節を組み立て
	$aryFieldName{$i}:=Replace string:C233($aryFieldName{$i};" ";"_")
	$aryFieldName{$i}:=$inPrefix+"_"+$aryFieldName{$i}  //20130501
	$typeStr:=JCL_tbl_Type_SQL ($aryFieldType{$i};$aryCharLength{$i})
	$sql:=$sql+$aryFieldName{$i}+$typeStr
	
End for 

  //最後のカンマを削除して括弧とセミコロンを追加
$sql:=Substring:C12($sql;1;Length:C16($sql)-1)
$sql:=$sql+");"

  //テキストファイルにアペンド
JCL_file_SQLOut ($sql)
