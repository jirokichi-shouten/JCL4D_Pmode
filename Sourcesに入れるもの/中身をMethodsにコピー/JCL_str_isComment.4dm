//%attributes = {}
  //JCL_str_isComment
  //20210117 wat
  //コメント行かどうかを判定

C_TEXT:C284($1;$inMethod)
$inMethod:=$1
C_BOOLEAN:C305($0;$ret)
$ret:=False:C215
C_TEXT:C284($method;$firstTwoChar)

  //タブコードと空白を除く
$method:=Replace string:C233($inMethod;"\t";"")
$method:=Replace string:C233($inMethod;" ";"")

$firstTwoChar:=Substring:C12($method;1;2)  //最初の２文字が//だったらコメント
If ($firstTwoChar="//")
	$ret:=True:C214
	
End if 

$0:=$ret
