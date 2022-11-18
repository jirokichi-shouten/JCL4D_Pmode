//%attributes = {"shared":true}
  //JCL_lstMake_Join
  //CL01_lstCL_Make_Join
  //20130309
  //別テーブルから名前をジョイン

C_POINTER:C301($1;$tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER:C301($2;$IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_POINTER:C301($3;$NameFldPtr)
$NameFldPtr:=$3  //名前フィールドのポインタ
C_POINTER:C301($4;$IDAryPtr)
$IDAryPtr:=$4  //ＩＤの配列
C_POINTER:C301($5;$NameAryPtr)
$NameAryPtr:=$5  //返す、名前の配列
ARRAY LONGINT:C221($aryID;0)
ARRAY TEXT:C222($aryName;0)
C_LONGINT:C283($i;$sizeOfAry)

  //キャッシュ対象のテーブルからIDと名前を配列に取得
READ ONLY:C145($tblPtr->)
ALL RECORDS:C47($tblPtr->)
FIRST RECORD:C50($tblPtr->)
SELECTION TO ARRAY:C260($IDFldPtr->;$aryID)
SELECTION TO ARRAY:C260($NameFldPtr->;$aryName)

$sizeOfAry:=Size of array:C274($IDAryPtr->)
For ($i;1;$sizeOfAry)
	
	$pos:=Find in array:C230($aryID;$IDAryPtr->{$i})
	If ($pos>0)
		
		$NameAryPtr->{$i}:=$aryName{$pos}
		
	Else 
		$NameAryPtr->{$i}:=""
		
	End if 
	
End for 
