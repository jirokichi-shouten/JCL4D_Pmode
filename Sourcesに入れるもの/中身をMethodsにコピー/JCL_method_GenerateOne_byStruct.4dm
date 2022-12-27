//%attributes = {}
//JCL_method_GenerateOne_byStruct
//20210106 ike wat
//テーブル定義から、メソッド群を作成

C_TEXT:C284($1; $inFrmPrefix)
$inFrmPrefix:=$1  //テーブル名
C_TEXT:C284($2; $inTableName)
$inTableName:=$2  //テーブル名
C_TEXT:C284($3; $inPrefix)
$inPrefix:=$3  //フィールドのプリフィックス
C_POINTER:C301($4; $aryFileNamePtr)
$aryFileNamePtr:=$4
C_POINTER:C301($5; $aryFileContentsPtr)
$aryFileContentsPtr:=$5

C_LONGINT:C283($0)
ARRAY TEXT:C222($aryFieldName; 0)  //フィールド名の配列
ARRAY TEXT:C222($aryFieldType; 0)  //フィールドタイプの配列
ARRAY TEXT:C222($aryFieldLength; 0)  //文字長さの配列
ARRAY TEXT:C222($aryFieldIndex; 0)
C_TEXT:C284($methodName)
C_TEXT:C284($methodBody)
$methodBody:=""

JCL_tbl_Fields_withAttr($inTableName; ->$aryFieldName; ->$aryFieldType; ->$aryFieldLength; ->$aryFieldIndex)

//日付時刻文字列を作成
$dateTimeStr:=JCL_str_dateTime(Current date:C33; Current time:C178)

ARRAY LONGINT:C221($propertiesArray; 7)
$propertiesArray{1}:=1  //メソッドが表示の時1、非表示なら0。
$propertiesArray{2}:=0  //メソッドが4DACTION、4DMETHOD、4DSCRIPTから利用可能であれば1、そうでなければ0。
$propertiesArray{3}:=0  //メソッドをWebサービスとして提供する場合1、そうでなければ0。
$propertiesArray{4}:=0  //propertiesArray{3}=1のとき、メソッドをWSDLで公開する場合1、そうでなければ0。
$propertiesArray{5}:=0  //メソッドをコンポーネントとホストデータベースで共有する場合1、そうでなければ0。
$propertiesArray{6}:=0  //メソッドがSQLから利用可能であれば1、そうでなければ0。
$propertiesArray{7}:=0  //メソッドに"サーバ上で実行"属性を設定する場合は1、そうでなければ0。

//フィールド定義からメソッド生成
For ($i; 1; Size of array:C274($aryFileNamePtr->))
	//メソッド名生成
	$methodName:=$aryFileNamePtr->{$i}
	$methodName:=Replace string:C233($methodName; "[--FRM_PREFIX]"; $inFrmPrefix)
	$methodName:=Replace string:C233($methodName; "[--TABLE]"; $inTableName)
	$methodName:=Replace string:C233($methodName; "[--PREFIX]"; $inPrefix)
	
	$date_time:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
	//メソッド生成
	$methodBody:=$aryFileContentsPtr->{$i}
	$methodBody:=Replace string:C233($methodBody; "[--DATE]"; $dateTimeStr)
	$methodBody:=Replace string:C233($methodBody; "[--FRM_PREFIX]"; $inFrmPrefix)
	$methodBody:=Replace string:C233($methodBody; "[--TABLE]"; $inTableName)
	$methodBody:=Replace string:C233($methodBody; "[--PREFIX]"; $inPrefix)
	
	$pos:=Position:C15("[--FIELD]"; $methodBody)
	If ($pos#0)
		
		$len:=Length:C16($methodBody)
		$row:=""
		$newmethod:=""
		For ($h; 1; $len)
			
			$chr:=Substring:C12($methodBody; $h; 1)
			$row:=$row+$chr
			
			If (JCL_str_IsCharRetrurn($chr))  //add_ikeda 20221227
				
				$pos:=Position:C15("[--FIELD]"; $row)
				If ($pos#0)
					For ($k; 1; Size of array:C274($aryFieldName))
						//フィールド名を置換
						//$fieldName:=$inPrefix+"_"+$aryFieldName{$k}  //20130501
						$fieldName:=$aryFieldName{$k}  //20130501
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
		$methodBody:=$newmethod
		
	End if 
	
	//メソッドがなければ作成  //v14
	METHOD SET CODE:C1194($methodName; $methodBody)
	
End for 
