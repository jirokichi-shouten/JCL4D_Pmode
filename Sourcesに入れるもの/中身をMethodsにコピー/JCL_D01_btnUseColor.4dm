//%attributes = {}
//JCL_D01_btnUseColor
//20210607 wat
//別の色を使う
//20220430 wat 色選びにこだわってしまうことがある。その時に効率がいいように５色から選ぶようにした。
//20221011 hisa wat バージョン確認作業　GitHubにアップ

C_TEXT:C284($btnNname; $numStr; $rectName)
C_TEXT:C284($color_text)

//クリックされたボタン名から、色付き四角形の名前を推定して、色を取得
$btnNname:=OBJECT Get name:C1087(Object current:K67:2)
$numStr:=Substring:C12($btnNname; Length:C16($btnNname); 1)
$rectName:="vJCL_D01_rectColor"+$numStr

OBJECT GET RGB COLORS:C1074(*; $rectName; $color_text)

//サンプルとして、このダイアログのタイトルレクトにセット
OBJECT SET RGB COLORS:C628(*; "vJCL_D01_rectTitle"; $color_text; $color_text)

//呼び出し元に戻すためのプロセス変数に代入
vJCL_D01_objFrm.color_text:=$color_text
