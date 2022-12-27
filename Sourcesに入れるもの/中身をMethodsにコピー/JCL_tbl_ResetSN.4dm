//%attributes = {}
//JCL_tbl_ResetSN
//20171228 wat
//キーとテーブル名を与えて、レコードを削除

C_TEXT:C284($1; $key_word)
$key_word:=$1  //キーコード
C_TEXT:C284($2; $table_name)
$table_name:=$2  //テーブル名


READ WRITE:C146(vSNptr->)  //リードライトモードにする

QUERY:C277(vSNptr->; vSN_KEY_CODEptr->=$key_word; *)
QUERY:C277(vSNptr->;  & ; vSN_TABLE_NAMEptr->=$table_name)

DELETE SELECTION:C66(vSNptr->)

READ ONLY:C145(vSNptr->)  //リードオンリーに戻す
