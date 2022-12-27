//%attributes = {}
//JCL_tbl_DelAll
//20171228 wat
//ポインタをもらって、テーブルのレコードを削除

C_POINTER:C301($1; $tblPtr)
$tblPtr:=$1


READ WRITE:C146($tblPtr->)
ALL RECORDS:C47($tblPtr->)
DELETE SELECTION:C66($tblPtr->)
READ ONLY:C145($tblPtr->)

