//%attributes = {"shared":true}
  //JCL_method_import
  //20150524 yabe wat v14対応
  //20150911 wat コンポーネントで共有

C_TEXT:C284($dir)  //メソッドを読み込むディレクトリ
C_LONGINT:C283($i;$numOfFile)
C_TEXT:C284($filePath)
ARRAY TEXT:C222($aryFileList;0)

ARRAY LONGINT:C221($propertiesArray;7)
$propertiesArray{1}:=1  //メソッドが表示の時1、非表示なら0。
$propertiesArray{2}:=0  //メソッドが4DACTION、4DMETHOD、4DSCRIPTから利用可能であれば1、そうでなければ0。
$propertiesArray{3}:=0  //メソッドをWebサービスとして提供する場合1、そうでなければ0。
$propertiesArray{4}:=0  //propertiesArray{3}=1のとき、メソッドをWSDLで公開する場合1、そうでなければ0。
$propertiesArray{5}:=0  //メソッドをコンポーネントとホストデータベースで共有する場合1、そうでなければ0。
$propertiesArray{6}:=0  //メソッドがSQLから利用可能であれば1、そうでなければ0。
$propertiesArray{7}:=0  //メソッドに"サーバ上で実行"属性を設定する場合は1、そうでなければ0。

C_TEXT:C284($methodName;$method)
$method:=""
C_BLOB:C604($blob)
C_TEXT:C284($retText)
$retText:="end"

$dir:=Select folder:C670("")

If (OK=1)
	
	DOCUMENT LIST:C474($dir;$aryFileList)
	
	$numOfFile:=Size of array:C274($aryFileList)
	
	  //4Dにメソッドが認識されるように、はじめに空のメソッドを作成しておく
	For ($i;1;$numOfFile)
		
		$methodName:=$aryFileList{$i}
		$method:=""
		METHOD SET CODE:C1194($methodName;$method)
		
	End for 
	
	For ($i;1;$numOfFile)
		
		$filePath:=$dir+$aryFileList{$i}
		$methodName:=$aryFileList{$i}
		
		  //v14
		DOCUMENT TO BLOB:C525($filePath;$blob)
		$method:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
		
		
		METHOD SET CODE:C1194($methodName;$method)
		
		METHOD SET ATTRIBUTE:C1192($methodName;Attribute shared:K72:10;True:C214)  // 20150911 wat
		
	End for 
	
	ALERT:C41($retText)
	
End if 
