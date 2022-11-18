//%attributes = {}
  //JCL_method_cntLines
  //20210117 wat
  //メソッドの実行行数をカウントする。全体をカウントして、JCLをカウントして差し引く

C_LONGINT:C283($cnt;$jcl_cnt)
C_LONGINT:C283($i;$numOfMethod;$numOfJCLMethod)
C_TEXT:C284($method)
ARRAY TEXT:C222($aryMethodName;0)
C_LONGINT:C283($numOfYourExcecutableCode)
ARRAY TEXT:C222($lineAry;0)
C_LONGINT:C283($k;$line_count)  //$numOfLines

  //すべてのプロジェクトメソッド名を配列に取得
METHOD GET NAMES:C1166($aryMethodName)
$numOfMethod:=Size of array:C274($aryMethodName)
For ($i;1;$numOfMethod)
	  //メソッドコードを取得
	METHOD GET CODE:C1190($aryMethodName{$i};$method)
	
	  //行数を取得   //4DのMETHOD GET CODEで付加されるコメントを除き空行までを連結
	$line_count:=JCL_str_Extract ($method;Char:C90(Carriage return:K15:38);->$lineAry)
	For ($k;2;$line_count)
		  //空白以外の行
		$lineAry{$k}:=Replace string:C233($lineAry{$k};Char:C90(Line feed:K15:40);"")
		If ($lineAry{$k}#"")
			$isComment:=JCL_str_isComment ($lineAry{$k})
			If ($isComment=False:C215)
				  //カウントすべき
				$cnt:=$cnt+1
			End if 
		End if 
	End for 
End for 

  //JCLメソッド名を配列に取得
METHOD GET NAMES:C1166($aryMethodName;"JCL_@")
$numOfJCLMethod:=Size of array:C274($aryMethodName)
For ($i;1;$numOfJCLMethod)
	  //メソッドコードを取得
	METHOD GET CODE:C1190($aryMethodName{$i};$method)
	
	  //行数を取得   //4DのMETHOD GET CODEで付加されるコメントを除き空行までを連結
	$line_count:=JCL_str_Extract ($method;Char:C90(Carriage return:K15:38);->$lineAry)
	For ($k;2;$line_count)
		  //空白以外の行
		$lineAry{$k}:=Replace string:C233($lineAry{$k};Char:C90(Line feed:K15:40);"")
		If ($lineAry{$k}#"")
			$isComment:=JCL_str_isComment ($lineAry{$k})
			If ($isComment=False:C215)
				  //カウントすべき
				$jcl_cnt:=$jcl_cnt+1
			End if 
		End if 
	End for 
End for 

$numOfYourExcecutableCode:=$cnt-$jcl_cnt

C_TEXT:C284($msg)
$msg:="JCL_method_cntLines:"
$msg:=$msg+"$numOfMethod=["+String:C10($numOfMethod;"#,###,###,##0")+"]"+Char:C90(Carriage return:K15:38)
$msg:=$msg+"$numOfJCLMethod=["+String:C10($numOfJCLMethod;"#,###,###,##0")+"]"+Char:C90(Carriage return:K15:38)
$msg:=$msg+"$jcl_cnt=["+String:C10($jcl_cnt;"#,###,###,##0")+"]"+Char:C90(Carriage return:K15:38)
$msg:=$msg+"$cnt=["+String:C10($cnt;"#,###,###,##0")+"]"+Char:C90(Carriage return:K15:38)
$msg:=$msg+"$numOfYourExcecutableCode=["+String:C10($numOfYourExcecutableCode;"#,###,###,##0")+"]"+Char:C90(Carriage return:K15:38)
ALERT:C41("完了 "+$msg)
