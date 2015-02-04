<?php
	include 'functions.php';
// данные доступа к базе данных 
	$db_host="localhost"; // обычно не нужно изменять 
	$db_user="785258"; // имя пользователя БД 
	$db_password="lasttonightfy"; // пароль БД 
	$db_name = "785258"; // имя БД 
	$table_name = "785258"; 

	$p = $_POST;



	$viewer_id = $p['user_id'];
	$name = $p['name'];
	$city = $p['city'];
	$photo = $p['photo'];
	
	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	// $query = 'INSERT INTO `users`(`id`) VALUES (5646464)';
	// $sql1 = mysql_query($query);
	
	
	$query = 'SELECT * FROM `users`  where  `id` = '.$viewer_id.';';
	$sql1 = mysql_query($query);
	if(mysql_num_rows($sql1) == 0)
	{
		$query = 'INSERT INTO `users` (`id`,`name`,`city`,`photos`) VALUES ('.$viewer_id.',"'.$name.'","'.$city.'","'.$photo.'");'; 
		$sql = mysql_query($query);
		echo '0&';
	}
	else
	{
		echo '1&';
	}
	
	$query = 'SELECT * FROM `users`  where  `id` = '.$viewer_id.';';
	$sql1 = mysql_query($query);
	
	echo returnResult(mysql_fetch_array($sql1));
		/* while($row = mysql_fetch_array($sql1))
		{
			echo 'skills:'.$row['skills'].',';
			echo 'learnings:'.$row['posts'].',';
			echo 'userReqs:'.$row['posts'].',';
			echo 'groupReqs:'.$row['posts'].',';
			echo 'portfolio:'.$row['posts'].'';
		} */
	

	function returnResult($r)
	{
		return stringify($r);
		
	}
?>