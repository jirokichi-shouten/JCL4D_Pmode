//%attributes = {}
  //JCL_str_byResources
  //20171124 wat
  //リソースフォルダからテキストファイルの内容を取得
  // 20171125 wat エラー処理を追加
  // 20181019 hisa wat ローカルリソースを使用するため、

C_TEXT:C284($1;$file_name)
$file_name:=$1
C_TEXT:C284($2;$encoding)
$encoding:=$2
C_TEXT:C284($fileText;$0)
C_TEXT:C284($folder_Path;$file_path)
C_BLOB:C604($fileBlob)
C_TEXT:C284($fileText)  //読み込んだファイルの内容
$fileText:=""

  //リソースフォルダ取得
$folder_Path:=Get 4D folder:C485(Current resources folder:K5:16)+"jiro"  // mod_hisa wat 20181019
  //$folder_Path:=JCL_file_MakeFilePath (Get 4D folder(Current resources folder);"jiro")
$file_path:=$folder_Path+Folder separator:K24:12+$file_name  // mod_hisa wat 20181019
  //$file_path:=JCL_file_MakeFilePath ($folder_Path;$file_name)

  //ファイルの内容を読み込んで　エンコード
DOCUMENT TO BLOB:C525($file_path;$fileBlob)
If (Ok=1)
	
	$fileText:=Convert to text:C1012($fileBlob;$encoding)
	
End if 

  // 新しいレコードを作成
  //KV_VALUE_save ($file_name;$fileText)

$0:=$fileText
