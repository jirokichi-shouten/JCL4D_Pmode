//%attributes = {}
//JCL_wait_IsCancel
//20111127 wat
//プログレスバー表示プロセスがキャンセルされたかどうかを返す
//20080605　矢部　新規作成

C_BOOLEAN:C305($0)

$0:=<>D50_Cancel
