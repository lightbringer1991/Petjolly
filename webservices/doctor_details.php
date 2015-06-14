<?php
header('content-type:application/json');
include_once("include/config.php");
mysql_query("SET NAMES 'UTF8'");

if(!isset($_REQUEST["doctor_id"]))
{
	echo "please provide Doctor Id as 'doctor_id'";
	exit;
}

$info = mysql_query("SELECT *  FROM meda_doctors where id = '".$_REQUEST["doctor_id"]."'") or die(mysql_error());

$data = array();
$count = mysql_num_rows($info);
if($count > 0)
{
	while($a=mysql_fetch_array($info))
	{
		$data[] = $a;
	}


$info = mysql_query("select * from meda_doctor_addresses where doctor_id=" . $_REQUEST["doctor_id"] . " and id=" . $_REQUEST["a_id"]);

$data1 = array();
while($a=mysql_fetch_array($info))
{

	$info_time = mysql_query("select * from meda_schedule_timeblocks where doctor_address_id=0 or doctor_address_id=" . $a["id"]) or die(mysql_error());
	$data_time = array();
	while($b=mysql_fetch_array($info_time))
	{
		$data_time[] = $b;
	}
	
	$data_week = array();
	$data_week[1] = array();
	$data_week[2] = array();
	$data_week[3] = array();
	$data_week[4] = array();
	$data_week[4] = array();
	$data_week[6] = array();
	$data_week[7] = array();
	for($i=0;$i<sizeof($data_time);$i++)
	{
		$x["time_from"] = $data_time[$i]["time_from"];
		$x["time_to"] = $data_time[$i]["time_to"];
		$x["schedule_id"] = $data_time[$i]["schedule_id"];
		$x["id"] = $data_time[$i]["id"];
		$data_week[$data_time[$i]["week_day"]][] =  $x;
	}
	
	$a["time_slots"] = $data_week;
	$data1[] = $a;
	

	
}
$data[0]["addresses"] = $data1;

$info = mysql_query("select * from meda_appointments join meda_patients on meda_patients.id=meda_appointments.patient_id where meda_appointments.doctor_id=" . $_REQUEST["doctor_id"] . " and appointment_date = CURDATE() order by appointment_time");
$data1 = array();
while($a=mysql_fetch_array($info))
{
	$data1[] = $a;
}
$data[0]["appointments"] = $data1;
	
  echo json_encode($data);
}
else
{
  echo "No Information available";	

}
?>