// JCL_model_saveLong
// 20220917 hisa
// テーブルとフィールドから数値を保存
// JCL_model_saveLong(->[ANKEN]; ->[ANKEN]AN_ID; $id; ->[ANKEN]AN_SA; $sa)

C_POINTER($1; $tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER($2; $IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_LONGINT($3; $id)
$id:=$3  //ＩＤ
C_POINTER($4; $NameFldPtr)
$NameFldPtr:=$4  //テキストフィールドのポインタ
C_LONGINT($5; $longValue)
$longValue:=$5  //テキスト値

READ WRITE($tblPtr->)
//IDで検索
QUERY($tblPtr->; $IDFldPtr->=$id)
FIRST RECORD($tblPtr->)

$numOfRecs:=Records in selection($tblPtr->)
If ($numOfRecs=1)
	$NameFldPtr->:=$longValue
	SAVE RECORD($tblPtr->)
	
End if 

UNLOAD RECORD($tblPtr->)
READ ONLY($tblPtr->)
