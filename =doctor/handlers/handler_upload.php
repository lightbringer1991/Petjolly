<?php

$output_dir = "images/doctors/";
 
if(isset($_FILES["myfile"]))
{

	$ret = array();
 
	$error =$_FILES["myfile"]["error"];
   {
 
    	if(!is_array($_FILES["myfile"]['name'])) //single file
    	{
            $RandomNum   = time();
 
            $ImageName      = str_replace(' ','-',strtolower($_FILES['myfile']['name']));
            $ImageType      = $_FILES['myfile']['type']; //"image/png", image/jpeg etc.
 
            $ImageExt = substr($ImageName, strrpos($ImageName, '.'));
            $ImageExt       = str_replace('.','',$ImageExt);
            $ImageName      = preg_replace("/\.[^.\s]{3,4}$/", "", $ImageName);
            $NewImageName = $ImageName.'-'.$RandomNum.'.'.$ImageExt;
 
       	 	move_uploaded_file($_FILES["myfile"]["tmp_name"],$output_dir. $NewImageName);
			if($objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_registration') == 'yes')){
				$doc_id = (int)$objLogin->GetLoggedID();
			$sql = 'INSERT INTO '.TABLE_DOCTOR_IMAGES.'(`doctor_id`,`item_file`,`image_title`,`item_file_thumb`,`priority_order`,`is_active` ) VALUES ( '.$doc_id.', "'.encode_text($NewImageName).'","'.$_FILES["myfile"]["name"].'","'.encode_text($NewImageName).'","0", "1");'; 
				mysql_query($sql);
			}
       	 	 //echo "<br> Error: ".$_FILES["myfile"]["error"];
 
	       	 	 $ret[$fileName]= $output_dir.$NewImageName;
    	}
    	else
    	{
            $fileCount = count($_FILES["myfile"]['name']);
    		for($i=0; $i < $fileCount; $i++)
    		{
                $RandomNum   = time();
 
                $ImageName      = str_replace(' ','-',strtolower($_FILES['myfile']['name'][$i]));
                $ImageType      = $_FILES['myfile']['type'][$i]; //"image/png", image/jpeg etc.
 
                $ImageExt = substr($ImageName, strrpos($ImageName, '.'));
                $ImageExt       = str_replace('.','',$ImageExt);
                $ImageName      = preg_replace("/\.[^.\s]{3,4}$/", "", $ImageName);
                $NewImageName = $ImageName.'-'.$RandomNum.'.'.$ImageExt;
 
                $ret[$NewImageName]= $output_dir.$NewImageName;
    		    move_uploaded_file($_FILES["myfile"]["tmp_name"][$i],$output_dir.$NewImageName );
				if($objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_registration') == 'yes')){
				$doc_id = (int)$objLogin->GetLoggedID();
				$sql =  'INSERT INTO '.TABLE_DOCTOR_IMAGES.'(`doctor_id`,`item_file`,`image_title`,`item_file_thumb`,`priority_order`,`is_active` ) VALUES ( '.$doc_id.', "'.encode_text($NewImageName).'","'.$_FILES["myfile"]["name"].'","'.encode_text($NewImageName).'","0", "1");'; 
				mysql_query($sql);
			}
			
    		}
    	}
    }
    echo json_encode($ret);
} 
exit;
?>