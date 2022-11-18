// JCL_model_saveText
// 20220916 hisa wat
// テーブルとテキストフィールドからテキスト値を保存
// JCL_model_saveText(->[ANKEN]; ->[ANKEN]AN_ID; $id; ->[ANKEN]AN_NAME; $text)

C_POINTER($1; $tblPtr)
$tblPtr:=$1  //テーブルポインタ
C_POINTER($2; $IDFldPtr)
$IDFldPtr:=$2  //ＩＤフィールドのポインタ
C_LONGINT($3; $id)
$id:=$3  //ＩＤ
C_POINTER($4; $NameFldPtr)
$NameFldPtr:=$4  //テキストフィールドのポインタ
C_TEXT($5; $text)
$text:=$5  //テキスト値

READ WRITE($tblPtr->)
//IDで検索
QUERY($tblPtr->; $IDFldPtr->=$id)
FIRST RECORD($tblPtr->)

$numOfRecs:=Records in selection($tblPtr->)
If ($numOfRecs=1)
	$NameFldPtr->:=$text
	SAVE RECORD($tblPtr->)
	
End if 

UNLOAD RECORD($tblPtr->)
READ ONLY($tblPtr->)
