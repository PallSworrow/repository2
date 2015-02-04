<?php
$db_host="localhost"; // обычно не нужно изменять 
	$db_user="785258"; // имя пользователя БД 
	$db_password="lasttonightfy"; // пароль БД 
	$db_name = "785258"; // имя БД 
	$table_name = "785258"; 
	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	$cities = array();
	$instTags = array();
	$goals = array();
	$styles = array();
	$instruments = array();
	
	$query = 'SELECT * FROM `users` ;';
	$sql = mysql_query($query);

	
	$result = array();
	 // echo '<'.$template->instrumentType.' '.$template->skillLevel.'>';
	// echo count($sql);
	
	while($row = mysql_fetch_array($sql))
	{
	//cities:
		if(array_search($row['city'],$cities) == false && $row['city'] != '') 
		{
			array_push($cities, '"'.$row['city'].'"');
		}
	//goals:	
		$arr = explode(', ',$row['goals']);
		foreach($arr as $item)
		{
			if(array_search($item,$goals) == false && $item != '' && $item != '""') array_push($goals, ''.$item.'');
		}
	//styles:
		$arr = explode(', ',$row['styles']);
		foreach($arr as $item)
		{
			if(array_search($item,$styles) == false && $item != '') array_push($styles, ''.$item.'');
		}
	//instruments
		$arr = explode(', ',$row['instruments']);
		foreach($arr as $item)
		{
			$skill = simplexml_load_string($item);
			foreach($skill->tags->item as $tag)
			{
				//inst tags:
				if(array_search($tag,$instTags) == false && (string)$tag != '') array_push($instTags, '"'.(string)$tag.'"');
			
			}
			//inst types
			if(array_search($skill->type,$instruments) == false && $skill->type != '') array_push($instruments, '"'.$skill->type.'"');
		}
	}
	echo '{';
	//cities:
	$res = join(',',$cities);
	echo '"cities":['.$res.'],';
	//goals:
	$res = join(',',$goals);
	echo '"goals":['.$res.'],';
	//inst tags:
	$res = join(',',$instTags);
	echo '"instTags":['.$res.'],';
	//inst types:
	$res = join(',',$instruments);
	echo '"instruments":['.$res.'],';
	//styles:
	$res = join(',',$styles);
	echo '"styles":['.$res.']';
	echo '}';
	

?>