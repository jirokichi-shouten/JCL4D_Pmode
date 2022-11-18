//%attributes = {"shared":true}
  //JCL_prt_PageSetup
  //20160311 wat 
  //Jiro_prt_PageSetup
  //20101212 wat new
  //ページセットアップをラップ

C_TEXT:C284($1;$formStr)
$formStr:=$1  //フォーム名
C_LONGINT:C283($0;$dlg_ok)

  //フォームの用紙設定を適用
_O_PAGE SETUP:C299($formStr)

  //印刷設定ダイアログを表示
PRINT SETTINGS:C106

  //ＯＫされたかどうかは環境変数から取得
$dlg_ok:=OK

$0:=$dlg_ok
