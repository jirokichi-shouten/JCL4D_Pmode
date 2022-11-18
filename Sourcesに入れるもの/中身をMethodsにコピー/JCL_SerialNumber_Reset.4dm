//%attributes = {"shared":true}
  //JCL_SerialNumber_Reset
  //20180206 wat
  //シリアル番号を初期化、テーブルポインタをもらって、番号をゼロに戻す

C_POINTER:C301($1;$tblPtr)
$tblPtr:=$1  //テーブルのポインタ

SET DATABASE PARAMETER:C642($tblPtr->;Table sequence number:K37:31;0)
