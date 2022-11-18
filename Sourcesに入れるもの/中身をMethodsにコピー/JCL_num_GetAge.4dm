//%attributes = {}
  //JCL_num_GetAge
  //zz_GetAge
  //20140707 wat
  //年齢を求める
  // 20140828 wat mod 日付まで考慮

C_DATE:C307($1;$birthday)
$birthday:=$1
C_DATE:C307($2;$theDay)
$theDay:=$2
C_LONGINT:C283($0;$age)
C_LONGINT:C283($theM;$birthM;$thD;$birthD)

  //20151220 wat 日付が空ならば今日が基準
If ($theDay=!00-00-00!)
	$theDay:=Current date:C33
	
End if 

$age:=Year of:C25($theDay)-Year of:C25($birthday)-1

$theM:=Month of:C24($theDay)
$birthM:=Month of:C24($birthday)
$thD:=Day of:C23($theDay)
$birthD:=Day of:C23($birthday)
Case of 
	: ($birthM<$theM)
		  //当月以前
		$age:=$age+1
		
	: ($birthM=$theM)
		  //当月は日付を考慮
		If ($thD>=$birthD)
			
			$age:=$age+1
			
		End if 
End case 

$0:=$age
