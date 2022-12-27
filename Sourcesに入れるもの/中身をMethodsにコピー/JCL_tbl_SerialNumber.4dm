//%attributes = {"shared":true}
//JCL_tbl_SerialNumber
//JCL_SerialNumber
//20180206 wat yabe
//シリアル番号を発行、テーブルポインタをもらって、最新の番号を返す
//20221015 wat rename

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1  //テーブルのポインタ
C_LONGINT:C283($0; $counter)
$counter:=0  //カウンターの値、戻り値

$counter:=Sequence number:C244($tblPtr->)

$0:=$counter  //新しいレコードＩD
