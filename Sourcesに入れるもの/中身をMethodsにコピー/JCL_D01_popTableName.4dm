//%attributes = {}
  //JCL_D01_popTableName
  //20210607 wat
  //テーブル名 ポップアップ

C_TEXT:C284($selStr)

$selStr:=vJCL_D01_aryTableName{vJCL_D01_aryTableName}

vJCL_D01_objFrm.tblName:=$selStr
