//%attributes = {}
//JCL_pgs_usage2
//20230109 wat
//プログレスバーをテストする
//usage2: forループ

C_TEXT:C284($message)
$message:="メッセージ"

//プログレスバー
C_BOOLEAN:C305($done)
C_LONGINT:C283($i; $cnt)
C_LONGINT:C283($denominator)
JCL_pgs_DefInit
JCL_pgs_Show("引当データを抽出しています...")

// リストボックス配列作成  //サーバ上で実行
//$cnt:=xxx_onServer
$cnt:=1000

//リストボックスのプロセス変数へ転送
//...

JCL_pgs_Show("引当データを表示しています...")
$denominator:=JCL_pgs_GetDenominator($cnt)
$denominator:=100  //for debug
For ($i; 1; $cnt)
	If (Mod:C98($i; $denominator)=0)
		JCL_pgs_SetValue(($i/$cnt)*100; String:C10($i)+"行目："+$message; $i; $cnt)
		DELAY PROCESS:C323(Current process:C322; 1)
	End if 
	
	//サーバ上でゲットした内容をリストボックスに代入、ここで転送が起こる
	//...
	
	$done:=JCL_pgs_IsCancel
	If ($done=True:C214)
		//キャンセルされたらループから抜ける
		$i:=$cnt+1
	End if 
End for 
JCL_pgs_Cancel
ALERT:C41("end")
