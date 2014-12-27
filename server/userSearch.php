<?php
	include 'functions.php';
	$db_host="localhost"; // обычно не нужно изменять 
	$db_user="785258"; // имя пользователя БД 
	$db_password="lasttonightfy"; // пароль БД 
	$db_name = "785258"; // имя БД 
	$table_name = "785258"; 
	function boolToInt($val)
	{
		if($val == 'true') return 1;
		else return 0;
	}
	function checkSkill($skillList, $temp)
	{
		
		echo '<$temp->type '.$temp->instrumentType.'>';
		foreach($skillList as $skill)
		{
			$skill = json_decode($skill);
			echo '$skill->type:'.$skill->type;
			
			if($skill->type == $temp->instrumentType)
			{
			echo '->check';
				if( 
						checkListFullMatch($skill->tags, $temp->instrumentTagsG) &&
						checkListCrossing($skill->tags, $temp->instrumentTagsY) &&
						checkException($skill->tags, $temp->instrumentTagsR) &&
						(
							$temp->skillLevel[0]==0 || 
							$skill->level == $temp->skillLevel
						) &&
						(
							($temp->reqPortfolio == 0) ||
							($temp->reqPortfolio == 1 && count($skill->audio)>0) ||
							($temp->reqPortfolio == 2 && count($skill->video)>0) ||
							($temp->reqPortfolio == 3 && (count($skill->audio)>0 || count($skill->video)>0))
						)
					
					)
					return 1;
					
			}
		}
		return 0;
	
	}
	function checkListFullMatch($listDB, $listTemp)
	{
		if(count($listTemp) == 0) return 1;
		$c = count(array_intersect($listDB, $listTemp));
		if($c >= count($listTemp)) return 1;
		else return 0;
		
	}
	function checkListCrossing($styleList, $listTemp)
	{
		if(count($listTemp) == 0) return 1;
		$c = count(array_intersect($styleList, $listTemp));
		if($c > 0) return 1;
		else return 0;
	}
	function checkException($styleList, $listTemp)
	{
		if(count($listTemp) == 0) return 1;
		$c = count(array_intersect($styleList, $listTemp));
		if($c > 0) return 0;
		else return 1;
	}
	
	
	function returnResult($r)
	{
	
		return stringify($r);
	}
	
	
	
	
	
	$p = $_POST;



	$viewer_id = $p['user_id'];
	$template = $p['request'];
	 // echo '   '.$template.'   ';
	
	$template = json_decode($template);
	
	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	// $query = 'INSERT INTO `users`(`id`) VALUES (5646464)';
	// $sql1 = mysql_query($query);
	//template:
	$req = '';
	if($template->city && count($template->city) >0)
	{
		$req = $req.'(';
		foreach($template->cityY as $city)
		{
			$req = 	$req.'`city` = "'.$city.'" ||';
			$req = substr($req,0,strlen($req)-2);
		}
		$req = $req.')&&';
	}
	
	if($template->localTours && $template->localTours !='false') $req = 		$req.'`localTours` = "'.boolToInt($template->localTours).'" &&';
	if($template->worldTours && $template->worldTours !='false') $req = 		$req.'`worldTours` = "'.boolToInt($template->worldTours).'" &&';
	if($template->readyForLocalTours && $template->readyForLocalTours !='false')$req = $req.'`localTourReady` = "'.boolToInt($template->readyForLocalTours).'" &&';
	if($template->readyForWorldTours && $template->readyForWorldTours !='false')$req = $req.'`worldToursReady` = "'.boolToInt($template->readyForWorldTours).'" &&';
	if($template->isForFree && $template->isForFree !='false') $req = 			$req.'`ForFree` = "'.boolToInt($template->isForFree).'" &&';
	$req = substr($req,0,strlen($req)-2);
	//echo gettype($template->skill);
	
	// if(gettype($template->skill) == integer) echo $req;

	//lists:
	/* $styles
	$goals
	$template->skill
	$template->instrumentType */
	
	
	if(strlen($req) >0) $query = 'SELECT * FROM `users` where  '.$req.';';
	else $query = 'SELECT * FROM `users`;';
	 echo $query.'      ';
	$sql = mysql_query($query);

	
	$result = array();
	 // echo '<'.$template->instrumentType.' '.$template->skillLevel.'>';
	   
	while($row = mysql_fetch_array($sql))
	{
		$styles = explode(',',$row['styles']);
		$goals =  explode(',',$row['goals']);
		if(checkListFullMatch($goals,$template->goalsG) 
		&& checkListCrossing($goals,$template->goalsY)
		&& checkException($goals,$template->goalsR)
		&& checkListFullMatch($styles,$template->stylesG)
		&& checkListCrossing($styles,$template->stylesY)
		&& checkException($styles,$template->stylesR))
		{
			if($template->instrumentType!='')
			{		
				if(checkSkill(explode(';',$row['instruments']),$template) === 1 )
				{
					$result[] = returnResult($row);
				}
			}
			else
			{
				 $result[] = returnResult($row);
			}
		}
	} 
	
	
	// echo 'RESULT:';
	$result = implode('&&', $result);
	
	echo '====';
	echo  $result;

?>