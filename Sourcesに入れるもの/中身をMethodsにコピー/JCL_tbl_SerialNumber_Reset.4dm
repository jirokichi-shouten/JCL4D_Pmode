//%attributes = {"shared":true}
//JCL_tbl_SerialNumber_Reset
//JCL_SerialNumber_Reset
//20180206 wat
//シリアル番号を初期化、テーブルポインタをもらって、番号をゼロに戻す
//20221015 wat rename

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1  //テーブルのポインタ

SET DATABASE PARAMETER:C642($tblPtr->; Table sequence number:K37:31; 0)
