<?php
include 'functions.php'; 
	$db_host="localhost"; // ???±N‹N‡???? ???µ ??N??¶???? ???·???µ??N?N‚N? 
	$db_user="785258"; // ????N? ?????»N??·?????°N‚?µ?»N? ?‘?” 
	$db_password="lasttonightfy"; // ???°Nˆ???»N? ?‘?” 
	$db_name = "785258"; // ????N? ?‘?” 
	$table_name = "785258"; 

	$p = $_POST;

	mysql_connect($db_host, $db_user, $db_password) or die (mysql_error()); 
	mysql_select_db($db_name) or die (mysql_error()); 
	mysql_query("SET NAMES 'utf8'"); 
	
	// $query = 'INSERT INTO `users`(`id`) VALUES (5646464)';
	// $sql1 = mysql_query($query);
	


	// $prof = $p['profile'];
	
        echo '<'.$prof.'>';
	// $prof = json_decode($prof);
	
	$props = array();
	array_push($props,"city = '".$p['city']."'");
	array_push($props,"cityChangeReady = '".$p['cityChangeReady']."'");
	array_push($props,"countryChangeReady = '".$p['countryChangeReady']."'");
	// array_push($props,"getInstrumentTypes = '".$p['getInstrumentTypes']."'");
	array_push($props,"goals = '".$p['goals']."'");
	// array_push($props,"groupReqs = '".$p['groupSearchReqs']."'");
	// array_push($props,"id = '".$p['id']."'");
	array_push($props,"info = '".$p['info']."'");
	array_push($props,"instruments = '".$p['instruments']."'");
	// array_push($props,"isMusician = '".$p['isMusician']."'");
	array_push($props,"localTours = '".$p['localTours']."'");
	array_push($props,"localToursReady = '".$p['localToursReady']."'");
	array_push($props,"name = '".$p['name']."'");
	array_push($props,"passport = '".$p['passport']."'");
	array_push($props,"photos = '".$p['photos']."'");
	array_push($props,"searchForGroup = '".$p['searchForGroup']."'");
	array_push($props,"searchForMusician = '".$p['searchForMusician']."'");
	array_push($props,"stageExperience = '".$p['stageExperience']."'");
	array_push($props,"styles = '".$p['styles']."'");
	// array_push($props,"userReqs = '".$p['userSearchReqs']."'");
	array_push($props,"worldTours = '".$p['worldTours']."'");
	array_push($props,"worldToursReady = '".$p['worldToursReady']."'");
	array_push($props,"writeExperience = '".$p['writeExperience']."'");
	
	
	/* $prof = array(
            'English' => array(
                'type' =>'One',
                'value' => 'val'
            )); */
      
        // echo '<'.$prof.'>';
/* 	foreach($prof as $key => $prop)
	{
		 echo '[ '.$key;
		 echo ' = '.$prop->value.' ]';
		 echo $prop->type.', ';
	 	if($prop->type == 'string') array_push($props, '`'.$key.'` = "'.$prop->value.'"');
		if($prop->type == 'number') array_push($props, '`'.$key.'` = '.$prop->value.'');
		if($prop->type == 'bool') array_push($props, '`'.$key.'` = '.$prop->value.'');
		if($prop->type == 'list')
		{
			$list = $prop->value;
            // array_push($props, "`".$key."` = '".json_encode($prop->value)."'");
			echo '-'.$list[0].'--'.count($list).'--';

			if(count($list) >0)
			{
				array_push($props, "`".$key."` = ' \"".implode('","',$list)."\"'");
			}
			else
			{
				array_push($props, "`".$key."` = ''");
			}
		}
	//} //*/
	$props = implode(',',$props);
	
	$query = 'UPDATE `users` SET '.$props.' WHERE `id` ='.$p['id']; 
	$sql = mysql_query($query);
	echo $query;
	
?>			