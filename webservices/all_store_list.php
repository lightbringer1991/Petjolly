<?php
header('content-type:application/json');
include_once("include/config.php");
mysql_query("SET NAMES 'UTF8'");

$info = mysql_query("SELECT d.id,first_name,middle_name,last_name,title,medical_degree,doctor_photo_thumb,doctor_photo,default_visit_price,a.id as a_id,a.address FROM meda_doctor_addresses as a join  meda_doctors as d on a.doctor_id=d.id") or die(mysql_error());

$data = array();
while($a=mysql_fetch_array($info))
{
	$data[] = $a;
}

echo json_encode($data);


?>