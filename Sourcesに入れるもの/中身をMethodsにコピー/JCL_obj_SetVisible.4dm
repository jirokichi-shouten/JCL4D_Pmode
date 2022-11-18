//%attributes = {"shared":true}
  //JCL_obj_SetVisible
  //20130530 wat
  //オブジェクトを隠す，オブジェクト名を使う

C_TEXT:C284($1;$objName)
$objName:=$1
C_BOOLEAN:C305($2;$inBool)
$inBool:=$2  //ブール値

  //引数が真ならオブジェクトは表示、偽なら非表示
OBJECT SET VISIBLE:C603(*;$objName;$inBool)
