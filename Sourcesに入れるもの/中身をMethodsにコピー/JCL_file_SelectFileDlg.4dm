//%attributes = {"shared":true}
  //JCL_file_SelectFileDlg
  //20121129 wat
  //ファイルオープンダイアログを表示してファイルの中身を返す

C_POINTER:C301($1)  //ブロブのポインタ
C_LONGINT:C283($0;$open_ok)

C_TIME:C306($fileRef)  //ドキュメント参照
C_LONGINT:C283($fileSize)  //読み込むファイルのサイズ
C_BLOB:C604($fileBlob)  //読み込んだファイルの内容
C_LONGINT:C283($maxFIleSize)
$maxFIleSize:=1024*1024*1024  //開くファイルサイズの上限

  //ブロブのサイズをゼロにする。何もしないとゴミがが入る
SET BLOB SIZE:C606($fileBlob;0)

  //エラーコール
ON ERR CALL:C155("JCL_file_OnErrorCall")

  //ファイルを読み込み専用で開く
$fileRef:=Open document:C264("";Read mode:K24:5)
$open_ok:=OK
If ($open_ok=1)
	
	  //上限サイズより大きいか？
	$fileSize:=Get document size:C479($fileRef)
	If ($fileSize<=$maxFileSize)
		
		  //ファイルの最後まで内容をブロブに取得
		RECEIVE PACKET:C104($fileRef;$fileBlob;$fileSize)
		
	End if 
	
	  //ファイルを閉じる
	CLOSE DOCUMENT:C267($fileRef)
	
End if 

  //エラーコール終了
ON ERR CALL:C155("")

$1->:=$fileBlob
$0:=$open_ok
