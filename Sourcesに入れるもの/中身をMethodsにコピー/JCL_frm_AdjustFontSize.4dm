  //JCL_frm_AdjustFontSize
  //フォームオブジェクト　文字数によってフォントサイズを小さくする
  //20170905 yabe wat
  //20181124 wat 対象となるフィールドがいない場合は無限ループになるので注意
  //20220410 wat minekaで暴走、長い文字列を与えたらおかしくなった。→whileに条件を追加

C_TEXT($1;$fldName)
$fldName:=$1
C_LONGINT($font_size)
C_LONGINT($best_width;$best_height)
C_LONGINT($org_width;$org_height)
C_BOOLEAN($done)  //20220410

  //オブジェクトが存在するかどうか
C_POINTER($objPtr)
$objPtr:=OBJECT Get pointer(Object named;$fldName)
If ($objPtr#Null)
	  // プロパティで設定されているフォントサイズ
	$font_size:=OBJECT Get font size(*;$fldName)
	
	  // フォームエディタ上のオブジェクトサイズ
	JCL_frm_GetObjectSize ($fldName;->$org_width;->$org_height)
	
	  // 文字列描画後の　オフジェクトの最適サイズ
	$done:=False
	OBJECT GET BEST SIZE(*;$fldName;$best_width;$best_height)
	While (($org_width<=$best_width) & ($done=False))
		  // フォントサイズを一つ小さくする
		$font_size:=$font_size-1
		OBJECT SET FONT SIZE(*;$fldName;$font_size)
		
		  // フォント変更後、オフジェクトの最適サイズ　を取り直す
		OBJECT GET BEST SIZE(*;$fldName;$best_width;$best_height)
		
		$m:="JCL_frm_AdjustFontSize"
		$m:=$m+": $fldName=["+$fldName+"]"
		$m:=$m+": $org_width=["+String($org_width)+"]"
		$m:=$m+": $best_width=["+String($best_width)+"]"
		$m:=$m+": $font_size=["+String($font_size)+"]"
		  //JCL_file_Logout ($m)
		
		If ($font_size<3)  //20220410
			$done:=True
		End if 
	End while 
	
Else 
	C_TEXT($msg)
	$msg:="Object not found: JCL_frm_AdjustFontSize"+Char(Carriage return)
	$msg:=$msg+"$fldName=["+$fldName+"]"
	  //$msg:=$msg+"$objPtr=["+string($objPtr)+"]"
	ALERT($msg+": Null")
	
End if 
