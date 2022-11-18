//%attributes = {"shared":true}
  //JCL_num_GetTax
  //20170312 wat
  //税込金額から 消費税を得る 税率は％

C_REAL:C285($1;$amount)
$amount:=$1
C_REAL:C285($2;$rate)
$rate:=$2
C_REAL:C285($0;$tax)
$tax:=0
C_LONGINT:C283($tax_long)
C_REAL:C285($tmp)

$tmp:=$amount-(($amount/(100+$rate))*100)

  // 税は小数点以下を切り捨て
$tax_long:=$tmp*100
$tax:=$tax_long/100

C_TEXT:C284($m)
$m:="JCL_num_GetTax"
$m:=$m+": $amount=["+String:C10($amount)+"],"
$m:=$m+": $rate=["+String:C10($rate)+"],"
$m:=$m+": $tmp=["+String:C10($tmp)+"]"
$m:=$m+": $tax_long=["+String:C10($tax_long)+"]"
$m:=$m+": $tax=["+String:C10($tax)+"]"
  //JCL_file_Logout ($m)
  //ALERT($m)

$0:=$tax
