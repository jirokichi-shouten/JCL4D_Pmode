//%attributes = {"shared":true}
  //JCL_tbl_GetNumOfRecs
  //20180114 wat
  //レコードが何件あるか

C_POINTER:C301($1;$tblPtr)
$tblPtr:=$1
C_LONGINT:C283($0;$numOfRecs)

READ ONLY:C145($tblPtr->)
ALL RECORDS:C47($tblPtr->)

$numOfRecs:=Records in selection:C76($tblPtr->)

$0:=$numOfRecs
