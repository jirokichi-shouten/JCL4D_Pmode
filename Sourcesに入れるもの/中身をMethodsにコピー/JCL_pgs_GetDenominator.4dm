//%attributes = {}
//JCL_pgs_GetDenominator
//20230109 wat
//プログレスバーを表示する頻度を分母で指定、繰り返し回数で決める

C_LONGINT:C283($1; $cnt)
$cnt:=$1
C_LONGINT:C283($0; $denominator)
$denominator:=10

Case of 
	: ($cnt<100)
		$denominator:=10
		
	: ((101<$cnt) & ($cnt<1000))
		$denominator:=100
		
	: ((1001<$cnt) & ($cnt<10000))
		$denominator:=100
		
	: ((10001<$cnt) & ($cnt<100000))
		$denominator:=1000
		
	: ((100001<$cnt) & ($cnt<100000))
		$denominator:=10000
		
	Else 
		$denominator:=100000
		
End case 

$0:=$denominator
