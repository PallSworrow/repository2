<?php

function stringify($row)
{
		$res;
		$res = '{';
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
		$res = $res.'"forFree":"'.$row['ForFree'].'"}';
		return $res;

}
function parseUserProfile($str)
{
	$res = array();
	
}

?>