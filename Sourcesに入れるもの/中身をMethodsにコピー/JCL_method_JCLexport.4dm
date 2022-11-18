//%attributes = {"shared":true}
  //JCL_method_JCLexport
  // フォルダ選択ダイアログを表示して、JCLメソッドだけを書き出す。
  //20170627 yabe wat
  //20180521 wat JCLv16_Generalフォルダに出力する

C_TEXT:C284($dir)  //メソッドを書き出すディレクトリ

  //C_TIME($doc)
C_LONGINT:C283($i;$numOfMethod)
C_TEXT:C284($method)
C_TEXT:C284($methodFilePath)
ARRAY TEXT:C222($aryMethodName;0)
C_BLOB:C604($blob)

  //すべてのプロジェクトメソッド名を配列に取得
METHOD GET NAMES:C1166($aryMethodName;"JCL_@")

$dir:=Select folder:C670("")
If (OK=1)
	
	$numOfMethod:=Size of array:C274($aryMethodName)
	For ($i;1;$numOfMethod)
		
		  //メソッドコードを取得
		METHOD GET CODE:C1190($aryMethodName{$i};$method)
		
		  // 最初の１行は除く　次のような１行が出力されるため
		$pos:=Position:C15(Char:C90(Carriage return:K15:38);$method)
		$method:=Substring:C12($method;$pos+1)
		
		  //メソッドを保存するファイルパス作成
		$methodFilePath:=$dir+$aryMethodName{$i}+".txt"
		
		SET BLOB SIZE:C606($blob;0)
		TEXT TO BLOB:C554($method;$blob;UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($methodFilePath;$blob)
		
	End for 
	
	ALERT:C41("完了")
	
End if 
