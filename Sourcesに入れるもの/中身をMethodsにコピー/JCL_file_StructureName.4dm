//%attributes = {"shared":true}
  //JCL_file_structure_name
  //20170625 yabe
  //ストラクチャ名を取得

C_TEXT:C284($0;$structure_name)

C_TEXT:C284($structure_file_path)
$structure_file_path:=Structure file:C489

C_TEXT:C284($separator)
$separator:=JCL_file_GetDirSeparator 

ARRAY TEXT:C222($ary_dirs;0)
C_LONGINT:C283($dir_count)
$dir_count:=JCL_str_Extract ($structure_file_path;$separator;->$ary_dirs)

C_TEXT:C284($structure_file_name)
$structure_file_name:=$ary_dirs{$dir_count}

C_TEXT:C284($ext)
$ext:="."+JCL_file_Extension ($structure_file_name)

$structure_name:=Substring:C12($structure_file_name;1;Length:C16($structure_file_name)-Length:C16($ext))

$0:=$structure_name
