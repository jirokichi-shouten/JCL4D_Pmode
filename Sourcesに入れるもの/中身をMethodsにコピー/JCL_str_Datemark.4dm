//%attributes = {"shared":true}
  //JCL_str_Datemark
  //$1: date; $2: time
  //20100701 wat, 20121207 wat replace string
  //じろ日付（デイトマーク）の文字列を作成する

C_DATE:C307($1;$date)
$date:=$1
C_TIME:C306($2;$time)
$time:=$2
C_TEXT:C284($0;$datemarkStr;$dateStr;$timeStr)

  //日付文字
$yearStr:=String:C10(Year of:C25($date);"####")
$monthStr:=String:C10(Month of:C24($date);"00")
$dayStr:=String:C10(Day of:C23($date);"00")
$dateStr:=$yearStr+$monthStr+$dayStr

  //時刻
  //$timeStr:=JCL_str_StripChar(String($time);":")
$timeStr:=String:C10($time)
$timeStr:=Replace string:C233($timeStr;":";"")

  //所定文字列を作成
$datemarkStr:=$dateStr+$timeStr

$0:=$datemarkStr
