//%attributes = {}
//JCL_str_GetWareki
//20131125 wat
//和暦を取得
//20200227 ike wat 令和を追加
//20230104 wat rename

C_DATE:C307($1; $monthStart)
$monthStart:=$1
C_TEXT:C284($0; $warekiMonthStr)
$warekiMonth:=""

C_DATE:C307($taishouStart; $shouwaStart; $heiseiStart)
$taishouStart:=Date:C102("1912/7/30")
$shouwaStart:=Date:C102("1926/12/25")
$heiseiStart:=Date:C102("1989/1/8")
$reiwaStart:=Date:C102("2019/5/1")

C_LONGINT:C283($month; $year)
$year:=Year of:C25($monthStart)
$month:=Month of:C24($monthStart)

//令和時代
If ($reiwaStart<=$monthStart)
	$year:=$year-2018
	$warekiMonth:="(令和"+String:C10($year)+"年)"
	
End if 

//平成時代
If (($heiseiStart<=$monthStart) & ($monthStart<$reiwaStart))
	$year:=$year-1988
	$warekiMonth:="(平成"+String:C10($year)+"年)"
	
End if 

//昭和時代
If (($shouwaStart<=$monthStart) & ($monthStart<$heiseiStart))
	$year:=$year-1925
	$warekiMonth:="(昭和"+String:C10($year)+"年)"
	
End if 

//大正時代
If (($taishouStart<=$monthStart) & ($monthStart<$shouwaStart))
	$year:=$year-1911
	$warekiMonth:="(大正"+String:C10($year)+"年)"
	
End if 

$0:=$warekiMonth
