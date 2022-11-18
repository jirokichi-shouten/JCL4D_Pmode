//%attributes = {"shared":true}
  //jcl_method_export
  //20130429 yabe new

C_TEXT:C284($dir)  //メソッドを書き出すディレクトリ
C_TEXT:C284($folderName;$dateStr;$timeStr)  //メソッド入れるフォルダの名前
C_DATE:C307($date)
$date:=Current date:C33
$dateStr:=String:C10(Year of:C25($date);"####")
$dateStr:=$dateStr+String:C10(Month of:C24($date);"00")
$dateStr:=$dateStr+String:C10(Day of:C23($date);"00")
$timeStr:=Time string:C180(Current time:C178)
$timeStr:=Replace string:C233($timeStr;":";"")
$folderName:="method"+$dateStr+$timeStr

  //C_TIME($doc)
C_LONGINT:C283($i;$numOfMethod)
C_TEXT:C284($method)
C_TEXT:C284($methodFilePath)
ARRAY TEXT:C222($aryMethodName;0)
C_BLOB:C604($blob)

  //すべてのプロジェクトメソッド名を配列に取得
METHOD GET NAMES:C1166($aryMethodName)

$dir:=Select folder:C670("")

If (OK=1)
	
	  //セレクトフォルダは最後にパスセパレータを含む文字列を返す
	  //それを利用して、最後の文字をセパレータとして取得（OSを判定するコードは不要になる）
	$separator:=Substring:C12($dir;Length:C16($dir);1)
	
	  //選択されたディレクトリにフォルダ作成
	CREATE FOLDER:C475($dir+$folderName)
	
	$numOfMethod:=Size of array:C274($aryMethodName)
	
	For ($i;1;$numOfMethod)
		
		  //メソッドコードを取得
		METHOD GET CODE:C1190($aryMethodName{$i};$method)
		
		  //メソッドを保存するファイルパス作成
		$methodFilePath:=$dir+$folderName
		$methodFilePath:=$methodFilePath+$separator
		$methodFilePath:=$methodFilePath+$aryMethodName{$i}
		
		SET BLOB SIZE:C606($blob;0)
		TEXT TO BLOB:C554($method;$blob;UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($methodFilePath;$blob)
		
		  //ファイルを作成し、コードを書き込む
		  //$doc:=Create document($methodFilePath)
		  //SEND PACKET($doc;$method)
		  //CLOSE DOCUMENT($doc)
		
	End for 
	
	ALERT:C41("完了")
	
End if 
