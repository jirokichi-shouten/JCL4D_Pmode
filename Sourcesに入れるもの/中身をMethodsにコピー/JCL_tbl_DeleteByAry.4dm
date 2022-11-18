//%attributes = {"shared":true}
  //JCL_tbl_DeleteByAry
  //20130311 wat
  //テーブルと検索対象フィールドを与えて、配列の要素で検索して物理削除

  //CL01_DeleteMany
  //20130311
  //複数を物理削除

C_POINTER:C301($1;$tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER:C301($2;$IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_POINTER:C301($3;$IDAryPtr)
$IDAryPtr:=$3  //ＩＤの配列

C_LONGINT:C283($i;$sizeOfAry)
C_LONGINT:C283($0;$delCnt)
$delCnt:=0

READ WRITE:C146($tblPtr->)

  //リストボックスのすべての行について
$sizeOfAry:=Size of array:C274($IDAryPtr->)
For ($i;1;$sizeOfAry)
	
	  //IDで検索して物理削除
	QUERY:C277($tblPtr->;$IDFldPtr->=$IDAryPtr->{$i})
	FIRST RECORD:C50($tblPtr->)
	DELETE SELECTION:C66($tblPtr->)
	
	$delCnt:=$delCnt+1
	
End for 
UNLOAD RECORD:C212($tblPtr->)
READ ONLY:C145($tblPtr->)

$0:=$delCnt
