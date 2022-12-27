//%attributes = {"shared":true}
//JCL_method_GenerateOne
//20130322 yabe

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_TEXT:C284($2; $inTableName)
$inTableName:=$2  //テーブル名
C_LONGINT:C283($3; $inStartLineNr)
$inStartLineNr:=$3  //テーブル定義始まりの行番号,スタート行番号
C_TEXT:C284($4; $inPrefix)
$inPrefix:=$4  //フィールドのプリフィックス
C_POINTER:C301($5; $aryFileNamePtr)
$aryFileNamePtr:=$5
C_POINTER:C301($6; $aryFileContentsPtr)
$aryFileContentsPtr:=$6

C_LONGINT:C283($0)
ARRAY TEXT:C222($lineAry; 0)
ARRAY TEXT:C222($itemAry; 0)
C_LONGINT:C283($numOfLines; $numOfItems)
ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryCharLength; 0)  //文字長さの配列
C_TEXT:C284($methodName)
C_TEXT:C284($method)
$method:=""

C_DATE:C307($date)
$date:=Current date:C33
C_TIME:C306($time)
$time:=Current time:C178
C_TEXT:C284($yearStr; $monthStr; $dayStr; $dateTimeStr; $dateStr; $timeStr)

//日付文字
$yearStr:=String:C10(Year of:C25($date); "####")
$monthStr:=String:C10(Month of:C24($date); "00")
$dayStr:=String:C10(Day of:C23($date); "00")
$dateStr:=$yearStr+$monthStr+$dayStr

//時刻
$timeStr:=String:C10($time)
$timeStr:=Replace string:C233($timeStr; ":"; "")

//所定文字列を作成
$dateTimeStr:=$dateStr+" "+$timeStr

ARRAY LONGINT:C221($propertiesArray; 7)
$propertiesArray{1}:=1  //メソッドが表示の時1、非表示なら0。
$propertiesArray{2}:=0  //メソッドが4DACTION、4DMETHOD、4DSCRIPTから利用可能であれば1、そうでなければ0。
$propertiesArray{3}:=0  //メソッドをWebサービスとして提供する場合1、そうでなければ0。
$propertiesArray{4}:=0  //propertiesArray{3}=1のとき、メソッドをWSDLで公開する場合1、そうでなければ0。
$propertiesArray{5}:=0  //メソッドをコンポーネントとホストデータベースで共有する場合1、そうでなければ0。
$propertiesArray{6}:=0  //メソッドがSQLから利用可能であれば1、そうでなければ0。
$propertiesArray{7}:=0  //メソッドに"サーバ上で実行"属性を設定する場合は1、そうでなければ0。

//改行で切り分ける
$numOfLines:=JCL_str_Extract_byReturn($inFileText; ->$lineAry)  //add_ikeda 20221227

//スタート行番号の次の行からフィールド定義を得る
For ($i; $inStartLineNr+1; $numOfLines)
	
	DELETE FROM ARRAY:C228($itemAry; 1; Size of array:C274($itemAry))
	$numOfItems:=JCL_str_Extract($lineAry{$i}; Char:C90(Tab:K15:37); ->$itemAry)
	If (3<=$numOfItems)
		
		If ($itemAry{1}#"_")
			//最初のセルが＿（アンダーバー）じゃなかったらフィールド情報取得
			APPEND TO ARRAY:C911($aryFieldName; $itemAry{1})  //フィールド名
			APPEND TO ARRAY:C911($aryFieldType; $itemAry{2})  //タイプ
			APPEND TO ARRAY:C911($aryCharLength; $itemAry{3})  //文字長さ
			
		Else 
			//最初のセルが＿（アンダーバー）だったらフィールド情報取得は終わり
			$i:=$numOfLines+1  //ループを抜ける
			
		End if 
	Else 
		$i:=$numOfLines+1  //ループを抜ける
		
	End if 
End for 

For ($i; 1; Size of array:C274($aryFileNamePtr->))
	//メソッド名生成
	$methodName:=$aryFileNamePtr->{$i}
	$methodName:=Replace string:C233($methodName; "[--TABLE]"; $inTableName)
	$methodName:=Replace string:C233($methodName; "[--PREFIX]"; $inPrefix)
	
	$date_time:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
	//メソッド生成
	$method:=$aryFileContentsPtr->{$i}
	$method:=Replace string:C233($method; "[--DATE]"; $dateTimeStr)
	$method:=Replace string:C233($method; "[--TABLE]"; $inTableName)
	$method:=Replace string:C233($method; "[--PREFIX]"; $inPrefix)
	
	$pos:=Position:C15("[--FIELD]"; $method)
	If ($pos#0)
		$len:=Length:C16($method)
		$row:=""
		$newmethod:=""
		
		For ($h; 1; $len)
			$chr:=Substring:C12($method; $h; 1)
			$row:=$row+$chr
			
			If (JCL_str_IsCharRetrurn($chr))  //add_ikeda 20221227
				
				$pos:=Position:C15("[--FIELD]"; $row)
				If ($pos#0)
					
					For ($k; 1; Size of array:C274($aryFieldName))
						
						//フィールド名を置換
						$fieldName:=$inPrefix+"_"+$aryFieldName{$k}  //20130501
						//$newRow:=""
						$newRow:=Replace string:C233($row; "[--FIELD]"; $fieldName)
						
						//データ型を置換
						$dataType:=JCL_tbl_DataType($aryFieldType{$k})
						$newRow:=Replace string:C233($newRow; "[--DATATYPE]"; $dataType)
						
						//初期値を置換
						$initValue:=JCL_tbl_InitValue($aryFIeldType{$k})
						$newRow:=Replace string:C233($newRow; "[--INITVALUE]"; $initValue)
						
						$newmethod:=$newmethod+$newRow
						
					End for 
				Else 
					$newmethod:=$newmethod+$row
					
				End if 
				
				$row:=""
				
			End if 
		End for 
		
		$method:=$newmethod
		
	End if 
	
	//v14で不要になった
	//SET BLOB SIZE($blob;0)
	//TEXT TO BLOB($method;$blob;Mac C string)
	
	//メソッドがなければ作成
	//v14
	METHOD SET CODE:C1194($methodName; $method)
	
	//If (AP Does method exist($methodName)=0)
	//AP Create method($methodName;$propertiesArray;$blob)
	//Else 
	//AP Modify method($methodName;$blob)  //20130501
	//End if 
	
End for 
