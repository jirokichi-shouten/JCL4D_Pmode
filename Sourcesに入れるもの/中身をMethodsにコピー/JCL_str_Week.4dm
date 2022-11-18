//%attributes = {"shared":true}
  //JCL_str_GetWeek
  //20130605 wat
  //日付から　曜日文字列を返す

C_DATE:C307($1;$date)
$date:=$1
C_TEXT:C284($0;$weekStr)
C_LONGINT:C283($dayNumber)

$dayNumber:=Day number:C114($date)

  //英語モード
Case of 
	: ($dayNumber=1)
		$weekStr:="Sunday"
	: ($dayNumber=2)
		$weekStr:="Monday"
	: ($dayNumber=3)
		$weekStr:="Tuesday"
	: ($dayNumber=4)
		$weekStr:="Wednesday"
	: ($dayNumber=5)
		$weekStr:="Thursday"
	: ($dayNumber=6)
		$weekStr:="Friday"
	: ($dayNumber=7)
		$weekStr:="Saturday"
End case 

  //日本語　モード
Case of 
	: ($dayNumber=1)
		$weekStr:="日"
	: ($dayNumber=2)
		$weekStr:="月"
	: ($dayNumber=3)
		$weekStr:="火"
	: ($dayNumber=4)
		$weekStr:="水"
	: ($dayNumber=5)
		$weekStr:="木"
	: ($dayNumber=6)
		$weekStr:="金"
	: ($dayNumber=7)
		$weekStr:="土"
End case 

$0:=$weekStr
