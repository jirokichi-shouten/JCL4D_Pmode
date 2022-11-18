//%attributes = {}
//JCL_str_NextNumber
//20220421 hisa wat
//伝票番号のように、Receipt-001の001部分を取得 //次の番号を返す

C_TEXT:C284($1; $bangou)
$bangou:=$1
C_TEXT:C284($0; $new_bangou)
C_LONGINT:C283($new_num)
C_OBJECT:C1216($objBangou)
$objBangou:=New object:C1471

//最後の番号を取得
JCL_str_LastNumber($bangou; $objBangou)

//元の番号にプラス１
$new_num:=1+Num:C11($objBangou.last_numbers)

//文字列に変換、プリフィックスも考慮
$new_bangou:=$objBangou.prefix+String:C10($new_num)

$0:=$new_bangou