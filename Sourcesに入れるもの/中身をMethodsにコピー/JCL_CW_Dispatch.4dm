//%attributes = {}
//JCL_CW_Dispatch
//20221010 wat
//Call Worker Dispather スレッド数のCWを呼び出す
//元ネタ：CW_RIM_pick_MD_Init //20171228 yabe
//20221016 wat 引数でフォーム情報をもらって、ライブラリー化

C_TEXT:C284($1; $methodName)
$methodName:=$1
C_OBJECT:C1216($2; $objParams)
$objParams:=$2
C_POINTER:C301($3; $aryCW_NAME_ptr)  //ワーカー名の配列、ワーカー作成で使う
$aryCW_NAME_ptr:=$3
C_LONGINT:C283($sizeOfAry; $i)
C_LONGINT:C283($winRef; $i; $myNum)


$winRef:=Current form window:C827  //進捗を表示するウインドウ

$sizeOfAry:=Size of array:C274($aryCW_NAME_ptr->)
For ($i; 1; $sizeOfAry)
	//スレッド数分のワーカーを作成
	$cw_name:=$aryCW_NAME_ptr->{$i}
	$myNum:=$i-1  //それぞれのワーカーの受け持ちワーク番号
	
	//オブジェクト変数にまとめて引数に渡す
	$objParams.num_of_thread:=$sizeOfAry
	$objParams.win_ref:=$winRef
	$objParams.cw_name:=$cw_name
	$objParams.my_num:=$myNum
	CALL WORKER:C1389($cw_name; $methodName; $objParams)
	
	C_TEXT:C284($m)
	$m:="CW_Dispatch"
	$m:=$m+": my_num=["+String:C10($myNum)+"]"+Char:C90(Tab:K15:37)
	$m:=$m+": $i=["+String:C10($i)+"]"+Char:C90(Tab:K15:37)
	$m:=$m+": $cw_name=["+$cw_name+"]"+Char:C90(Tab:K15:37)
	$m:=$m+": $winRef=["+String:C10($winRef)+"]"+Char:C90(Tab:K15:37)
	//JCL_file_Logout_mp($m)
	
End for 
