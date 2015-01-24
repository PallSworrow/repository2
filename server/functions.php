<?php

function stringify($row)
{
		$res  = json_encode($row);
		$arr = array();
		// foreach($row as $key->$value)
		/* $res = '{';
		$res = $res.'"id":"'.$row['id'].'",';
		$res = $res.'"city":"'.$row['city'].'",';
		$res = $res.'"info":"'.$row['info'].'",';
		
		$res = $res.'"localTours":"'.$row['localTours'].'",';
		$res = $res.'"worldTours":"'.$row['worldTours'].'",';
		$res = $res.'"localToursReady":"'.$row['localToursReady'].'",';
		$res = $res.'"worldToursReady":"'.$row['worldToursReady'].'",';
		$res = $res.'"cityChangeReady":"'.$row['cityChangeReady'].'",';
		$res = $res.'"countryChangeReady":"'.$row['countryChangeReady'].'",';
		$res = $res.'"passport":"'.$row['passport'].'",';
		
		
		$res = $res.'"photos":['.$row['photos'].'],';
		$res = $res.'"name":"'.$row['name'].'",';
		$res = $res.'"instruments":['.$row['instruments'].'],';
		$res = $res.'"learnings":['.$row['learnings'].'],';
		$res = $res.'"styles":['.$row['styles'].'],';
		$res = $res.'"forFree":"'.$row['ForFree'].'"}'; */
		return $res;

}
function generateValueTemplate($flagNames, $temp)//:array [flag = 1|0]
{
	$res = array();
	$value;
	echo '<<generateValueTemplate: names: ['.$flagNames.']  temp: ['.$temp.'] >>';
	foreach($flagNames as $name)
	{
		$value = $temp[$name];
		echo '  <<GVT '.$name.' = '.$value.'>>  ';
		if(($value && $value !='false'))
		{
			echo 'INCLUDE';
			if($value == 'true')$value = 1;
			array_push($res,'`'.$name.'`="'.$value.'"');
		}
	}
	return $res;
}
function checkListParams($row,$temp,$names)//:1|0
{
	$listValue;
	$fullMatch;//G
	$crossing;//Y
	$except;//R
	
	$res = 1;
	foreach($names as $name)
	{
		$listValue = explode(', ',$row[$name]);
		// echo 'TEMP: '.$temp;
		// echo '<<name: '.$name.'  value = ['.$listValue.'] G = ['.$temp[$name.'G'].'] Y = ['.$temp[$name.'Y'].'] R = ['.$temp[$name.'Y'].']  >>';
		$fullMatch = checkListFullMatch($listValue,$temp[$name.'G']);
		$crossing = checkListCrossing($listValue,$temp[$name.'Y']);
		$except = checkException($listValue,$temp[$name.'R']);
		echo'<<LIST CHECK '.$name.':['.$fullMatch.','.$crossing.','.$except.']>>';
		if($fullMatch + $crossing + $except <3)
		{
			echo ' -> false!   ';
			$res = 0;
		}			
	}
	
	return $res;
}

function checkListFullMatch($listDB, $listTemp)
{
	if(!$listTemp) return 1;
	if(count($listTemp) == 0) return 1;
	$c = count(array_intersect($listDB, $listTemp));
	if($c >= count($listTemp)) return 1;
	else return 0;
	
}
function checkListCrossing($listDB, $listTemp)
{
	if(!$listTemp) return 1;
	if(count($listTemp) == 0) return 1;
	$c = count(array_intersect($listDB, $listTemp));
	if($c > 0) return 1;
	else return 0;
}
function checkException($listDB, $listTemp)
{
	if(!$listTemp) return 1;
	if(count($listTemp) == 0) return 1;
	$c = count(array_intersect($listDB, $listTemp));
	if($c > 0) return 0;
	else return 1;
}
function checkSkill($skillList, $temp)//:1|0   skill list - array(skill,skill...)
{
	
	// echo '<$temp->type '.$temp->instrumentType.'>';
	foreach($skillList as $skill)
	{
		$skill = simplexml_load_string($skill);
		echo '$skill->type:'.$skill->type;
		
		if($skill->type == $temp->instrumentType)
		{
		echo '->check';
			if( 
					checkListFullMatch($skill->tags, $temp->instrumentTagsG) &&
					checkListCrossing($skill->tags, $temp->instrumentTagsY) &&
					checkException($skill->tags, $temp->instrumentTagsR) &&
					(
						$temp->skillLevel==0 || 
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
?>