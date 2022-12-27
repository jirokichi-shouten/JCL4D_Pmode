//%attributes = {}
//JCL_prj_FG_methods_One
//20210224 ike wat
//FormGenerator, 一つのメソッドファイルを作成

C_TEXT:C284($1; $inFileText)
$inFileText:=$1  //読み込んだファイルの中身
C_TEXT:C284($2; $inTableName)
$inTableName:=$2  //テーブル名
C_TEXT:C284($3; $inFrmPrefix)
$inFrmPrefix:=$3  //フォームのプリフィックス
C_TEXT:C284($4; $templateFileName)
$templateFileName:=$4
C_POINTER:C301($5; $aryFieldNamePtr)
$aryFieldNamePtr:=$5
C_POINTER:C301($6; $aryFieldTypePtr->)
$aryFieldTypePtr->:=$6
C_LONGINT:C283($0)
C_TEXT:C284($tbl_prefix)
C_LONGINT:C283($pos; $pos_method; $pos_row)
C_TEXT:C284($dateTimeStr)
C_TEXT:C284($newmethod)

//フィールド名のプリフィックス
//$tbl_prefix:=JCL_tbl_Prefix ($aryFieldNamePtr)
$pos:=Position:C15("_"; $aryFieldNamePtr->{1})
$tbl_prefix:=Substring:C12($aryFieldNamePtr->{1}; 1; $pos-1)

//日付時刻文字列を作成
$dateTimeStr:=JCL_str_dateTime(Current date:C33; Current time:C178)

//メソッド名生成
$methodName:=$templateFileName
$methodName:=Replace string:C233($methodName; "[--TABLE]"; $inTableName)
$methodName:=Replace string:C233($methodName; "[--FRM_PREFIX]"; $inFrmPrefix)
$methodName:=Replace string:C233($methodName; "[--TBL_PREFIX]"; $tbl_prefix)

$dateTimeStr:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
//メソッド生成
$method:=$inFileText
$method:=Replace string:C233($method; "[--DATE]"; $dateTimeStr)
$method:=Replace string:C233($method; "[--TABLE]"; $inTableName)
$method:=Replace string:C233($method; "[--TBL_PREFIX]"; $tbl_prefix)
$method:=Replace string:C233($method; "[--FRM_PREFIX]"; $inFrmPrefix)

$pos_method:=Position:C15("[--FIELD]"; $method)
//If ($pos_method#0)
$len:=Length:C16($method)
$row:=""
$newmethod:=""
For ($h; 1; $len)
	$chr:=Substring:C12($method; $h; 1)
	$row:=$row+$chr
	
	If (JCL_str_IsCharRetrurn($chr))  //add_ikeda 20221227
		
		$pos_row:=Position:C15("[--FIELD]"; $row)
		If ($pos_row#0)
			For ($k; 1; Size of array:C274($aryFieldNamePtr->))
				//フィールド名を置換
				$fieldName:=$aryFieldNamePtr->{$k}  //20130501
				$newRow:=Replace string:C233($row; "[--FIELD]"; $fieldName)
				
				//データ型を置換
				$dataType:=JCL_tbl_DataType($aryFieldTypePtr->{$k})
				$newRow:=Replace string:C233($newRow; "[--DATATYPE]"; $dataType)
				
				//初期値を置換
				$initValue:=JCL_tbl_InitValue($aryFieldTypePtr->{$k})
				$newRow:=Replace string:C233($newRow; "[--INITVALUE]"; $initValue)
				$newmethod:=$newmethod+$newRow
				
			End for 
		Else 
			$newmethod:=$newmethod+$row
			
		End if 
		
		$row:=""
		
	End if 
End for 

//所定のフォルダに書き出す
$folderPath:=JCL_file_MakeFilePath(Get 4D folder:C485(Database folder:K5:14); "Project")
$folderPath:=JCL_file_MakeFilePath($folderPath; "Sources")
$folderPath:=JCL_file_MakeFilePath($folderPath; "Methods")
$outFilePath:=JCL_file_MakeFilePath($folderPath; $methodName+".4dm")
TEXT TO DOCUMENT:C1237($outFilePath; $newmethod)

C_TEXT:C284($m)
$m:="JCL_prj_FG_methods_One"
$m:=$m+": $outFilePath=["+$outFilePath+"], "
//$m:=$m+": $newmethod=["+$newmethod+"]"
//JCL_file_Logout($m)
