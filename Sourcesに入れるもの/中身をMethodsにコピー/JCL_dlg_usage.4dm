//%attributes = {"shared":true}
// JCL_dlg_usage
//20150911 wat
//JCL_dlg　使用方法

C_TEXT:C284($text)

JCL_dlg_YesNo("タイトルABC"; "メッセージ"; "ok"; "cancel")

JCL_dlg_NoYes("タイトル文字列"; "メッセージ"; "OK"; "Cancel")

JCL_dlg_Inform("タイトル文字列"; "メッセージ"; "ok")

JCL_dlg_Surprise("タイトル文字列"; "メッセージ"; "ok")

$text:="default value by text"
JCL_dlg_InputOne("タイトル文字列"; "プロンプト文字列"; "ok"; "cancel"; ->$text)
ALERT:C41("入力テキスト="+$text)
