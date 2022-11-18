// JCL_model_saveReal
// 20220917 hisa
// テーブルとテキストフィールドからリアル値を保存
// JCL_model_saveReal(->[ANKEN]; ->[ANKEN]AN_ID; $id; ->[ANKEN]AN_CH; $ch)

C_POINTER($1; $tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER($2; $IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_LONGINT($3; $id)
$id:=$3  //ＩＤ
C_POINTER($4; $NameFldPtr)
$NameFldPtr:=$4  //テキストフィールドのポインタ
C_REAL($5; $realValue)
$realValue:=$5  //テキスト値

READ WRITE($tblPtr->)
//IDで検索
QUERY($tblPtr->; $IDFldPtr->=$id)
FIRST RECORD($tblPtr->)

$numOfRecs:=Records in selection($tblPtr->)
If ($numOfRecs=1)
	$NameFldPtr->:=$realValue
	SAVE RECORD($tblPtr->)
	
End if 

UNLOAD RECORD($tblPtr->)
READ ONLY($tblPtr->)
