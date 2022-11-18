//%attributes = {"shared":true}
  //JCL_Add_byInitValues_generate
  //20140810 yabe

C_LONGINT:C283($i;$k)
C_TEXT:C284($tableName)
C_TEXT:C284($fieldName)

C_LONGINT:C283($type)
C_LONGINT:C283($len)
C_BOOLEAN:C305($index)
C_BOOLEAN:C305($unique)
C_BOOLEAN:C305($visible)

ARRAY TEXT:C222($aryExtract;0)
C_TEXT:C284($prefix)
C_TEXT:C284($methodName)
C_TEXT:C284($method)
C_TEXT:C284($fieldMethod)
C_TEXT:C284($initValue)

C_BLOB:C604($blob)
ARRAY LONGINT:C221($propertiesArray;7)
$propertiesArray{1}:=1  //メソッドが表示の時1、非表示なら0。
$propertiesArray{2}:=0  //メソッドが4DACTION、4DMETHOD、4DSCRIPTから利用可能であれば1、そうでなければ0。
$propertiesArray{3}:=0  //メソッドをWebサービスとして提供する場合1、そうでなければ0。
$propertiesArray{4}:=0  //propertiesArray{3}=1のとき、メソッドをWSDLで公開する場合1、そうでなければ0。
$propertiesArray{5}:=0  //メソッドをコンポーネントとホストデータベースで共有する場合1、そうでなければ0。
$propertiesArray{6}:=0  //メソッドがSQLから利用可能であれば1、そうでなければ0。
$propertiesArray{7}:=0  //メソッドに"サーバ上で実行"属性を設定する場合は1、そうでなければ0。

For ($i;1;Get last table number:C254)
	  //For ($i;1;1)
	
	If (Is table number valid:C999($i)=True:C214)
		
		$tableName:=Table name:C256($i)
		$prefix:=""
		$method:=""
		$fieldMethod:=""
		
		For ($k;1;Get last field number:C255($i))
			
			If (Is field number valid:C1000($i;$k)=True:C214)
				
				$fieldName:=Field name:C257($i;$k)
				
				GET FIELD PROPERTIES:C258($i;$k;$type;$len;$index;$unique;$visible)
				
				DELETE FROM ARRAY:C228($aryExtract;1;Size of array:C274($aryExtract))
				
				If (($type#Is picture:K8:10) & ($type#Is subtable:K8:11) & ($type#Is BLOB:K8:12))
					Case of 
						: ($type=Is date:K8:7)
							$initValue:="!0000/00/00!"
						: ($type=Is time:K8:8)
							$initValue:="Time(\"00:00:00\")"
						Else 
							If ((Position:C15("CREATE_DATEMARK";$fieldName)#0) | (Position:C15("UPDATE_DATEMARK";$fieldName)#0))
								$initValue:="JCL_str_Datemark (Current date;Current time)"
							Else 
								$initValue:=JCL_tbl_InitValue (JCL_tbl_Type ($type))
							End if 
					End case 
					$fieldMethod:=$fieldMethod+"["+$tableName+"]"+$fieldName+":="+$initValue+Char:C90(Carriage return:K15:38)
				End if 
				
				JCL_str_Extract ($fieldName;"_";->$aryExtract)
				
				If (Size of array:C274($aryExtract)>=1)
					$prefix:=$aryExtract{1}
				End if 
				
			End if 
			
		End for 
		
		If ($prefix#"")
			
			$methodName:=$prefix+"_Add_byInitValues"
			
			$method:=$method+"//"+$prefix+"_Add_byInitValues"+Char:C90(Carriage return:K15:38)
			$method:=$method+"//method_generator"+Char:C90(Carriage return:K15:38)
			$method:=$method+"//"+$tableName+" レコード追加、初期値代入"+Char:C90(Carriage return:K15:38)
			$method:=$method+Char:C90(Carriage return:K15:38)
			$method:=$method+"C_LONGINT($0;$"+$prefix+"_id)"
			$method:=$method+Char:C90(Carriage return:K15:38)
			$method:=$method+"//新規レコード作成"+Char:C90(Carriage return:K15:38)
			$method:=$method+"$"+$prefix+"_id:=JCL_Sequence number (\""+$prefix+"_ID\";\""+$tableName+"\")"+Char:C90(Carriage return:K15:38)
			$method:=$method+"CREATE RECORD(["+$tableName+"])"+Char:C90(Carriage return:K15:38)
			$method:=$method+Char:C90(Carriage return:K15:38)
			$method:=$method+$fieldMethod
			$method:=$method+"["+$tableName+"]"+$prefix+"_ID:=$"+$prefix+"_id"+Char:C90(Carriage return:K15:38)
			$method:=$method+Char:C90(Carriage return:K15:38)
			$method:=$method+"SAVE RECORD(["+$tableName+"])"+Char:C90(Carriage return:K15:38)
			$method:=$method+Char:C90(Carriage return:K15:38)
			$method:=$method+"$0:=$"+$prefix+"_id"+Char:C90(Carriage return:K15:38)
			
			SET BLOB SIZE:C606($blob;0)
			TEXT TO BLOB:C554($method;$blob;Mac C string:K22:7)
			
			  //メソッドがなければ作成
			  //v14
			METHOD SET CODE:C1194($methodName;$method)
			  //If (AP Does method exist($methodName)=0)
			  //AP Create method($methodName;$propertiesArray;$blob)
			  //Else 
			  //AP Modify method($methodName;$blob)
			  //End if 
			
		End if 
		
	End if 
	
End for 

ALERT:C41("完了")
