<?php
	include 'functions.php';
	$db_host="localhost"; // обычно не нужно изменять 
	$db_user="785258"; // имя пользователя БД 
	$db_password="lasttonightfy"; // пароль БД 
	$db_name = "785258"; // имя БД 
	$table_name = "785258"; 
	$p = $_POST;



	$viewer_id = $p['user_id'];
	$template = $p['request'];
	 // echo '   '.$template.'   ';
	
	
	$template = json_decode($template,true);
	 // echo 'DECODED   '.$template->isForFree.'   ';
	//single value params names
	$ValueParamNames = array('stageExpirience','writeExpirience','localTours','worldTours','localToursReady','worldToursReady','cityChangeReady','passport','searchForMusician','searchForGoup','forFree');
	//list params names
	$ListParamNames =array('city','learnings','styles','goals');
	
	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	$req = generateValueTemplate($ValueParamNames,$template);
	echo '  [GVT result: '.$req.' '.count($req).' ]  ';
	$req = implode(' && ',$req);
	if(strlen($req) >0) $query = 'SELECT * FROM `users` where  '.$req.';';
	else $query = 'SELECT * FROM `users`;';
	echo $query.'  \n ';
	$sql = mysql_query($query);

	
	$result = array();
	 // echo '<'.$template->instrumentType.' '.$template->skillLevel.'>';

	while($row = mysql_fetch_array($sql))
	{
		// echo'TEMPLATE: '.$template;
		$listCheck = checkListParams($row,$template,$ListParamNames);
		// echo 'LIST CHECK RES: '.$listCheck;
		if($listCheck==1)
		{
			// echo'  <<LISTS CHECK = true>> ';
			if($template->instrumentType!=''&& false)
			{	
				//instruments: [skill,skill,skill]			
				if(checkSkill(explode(', ',$row['instruments']),$template) === 1 )
				{
					$result[] = stringify($row);
				}
			}
			else
			{
				 $result[] = stringify($row);
			}
		}
		else
		{
			// echo'  <<LISTS CHECK = false>> ';
		}
	} 
	
	
	// echo 'RESULT:';
	$result = implode('&&', $result);
	
	echo '====';
	echo  $result;

?>