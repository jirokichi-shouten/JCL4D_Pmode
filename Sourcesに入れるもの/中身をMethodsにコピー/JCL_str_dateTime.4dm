//%attributes = {}
  //JCL_str_dateTime
  //20210303 ike wat
  //日付時刻文字列、メソッドジェネレータ用

C_DATE:C307($1;$date)
$date:=$1
C_TIME:C306($2;$time)
$time:=$2
C_TEXT:C284($dateTimeStr;$0)
C_TEXT:C284($yearStr;$monthStr;$dayStr;$dateTimeStr;$dateStr;$timeStr)

  //日付文字
$yearStr:=String:C10(Year of:C25($date);"####")
$monthStr:=String:C10(Month of:C24($date);"00")
$dayStr:=String:C10(Day of:C23($date);"00")
$dateStr:=$yearStr+$monthStr+$dayStr

  //時刻
$timeStr:=String:C10($time)
$timeStr:=Replace string:C233($timeStr;":";"")

  //所定文字列を作成
$dateTimeStr:=$dateStr+" "+$timeStr

$0:=$dateTimeStr
