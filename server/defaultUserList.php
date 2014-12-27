<?php
	include 'functions.php';
	$db_host="localhost"; // обычно не нужно изменять 
	$db_user="785258"; // имя пользователя БД 
	$db_password="lasttonightfy"; // пароль БД 
	$db_name = "785258"; // имя БД 
	$table_name = "785258"; 
	
	
	
	$viewer_id = $p['user_id'];
	$template = $p['request'];
	 // echo '   '.$template.'   ';
	
	$template = json_decode($template);
	
	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	
	
	$query = 'SELECT * FROM `users` ORDER BY RAND() LIMIT 2';
	
	$sql = mysql_query($query);
	$result = array();
	while($row = mysql_fetch_array($sql))
	{
		array_push($result,stringify($row));
	} 
	
	
	// echo 'RESULT:';
	$result = implode('&&', $result);
	
	echo '====';
	echo  $result;
?>