<?php

/**

* @project ApPHP Medical Appointment

* @copyright (c) 2012 - 2014 ApPHP

* @author ApPHP <info@apphp.com>

* @license http://www.gnu.org/licenses/

*/



// *** Make sure the file isn't accessed directly

defined('APPHP_EXEC') or die('Restricted Access');

//--------------------------------------------------------------------------



$doctor_id = isset($_REQUEST['docid']) ? (int)$_REQUEST['docid'] : '';



//draw_title_bar(_DOCTOR_INFO);



//draw_content_start();

//if(empty($doctor_id)){

//    draw_important_message(_WRONG_PARAMETER_PASSED);

//}else{

//    Doctors::DrawDoctorInfo($doctor_id);

//}

//draw_content_end();



if(Modules::IsModuleInstalled('ratings') == 'yes'){

    $info_type = 'long';



    if($objLogin->IsLoggedInAsAdmin() || ($objLogin->IsLoggedInAsDoctor() && $doctor_id == $objLogin->GetLoggedID())) $mode = 'demo';

    if($info_type == 'long' || ($info_type == 'short' && !defined('RATING_INCLUDED'))){

        $output .= '<link href="modules/ratings/css/'.(($mode == 'demo') ? 'ratings.demo.css' : 'ratings.css').'" rel="stylesheet" type="text/css" />';

        if(Application::Get('lang_dir') == 'rtl') $output .= '<link href="modules/ratings/css/ratings-rtl.css" rel="stylesheet" type="text/css" />';

        $ratings_lang = (file_exists('modules/ratings/langs/'.Application::Get('lang').'.js')) ? Application::Get('lang') : 'en';

        $output .= '<script src="modules/ratings/langs/'.$ratings_lang.'.js" type="text/javascript"></script>';

        $output .= '<script src="modules/ratings/js/'.(($mode == 'demo') ? 'ratings.demo.js' : 'ratings.js').'" type="text/javascript"></script>';

        define('RATING_INCLUDED', true);

    }

}





if(!empty($doctor_id)){

    $doc = Doctors::GetDoctorInfoById($doctor_id);

    $doc = $doc[0];

}



$address = DoctorAddresses::GetAddresses($doctor_id, ($objLogin->IsLoggedIn() ? 'all' : 'public'));

$specialities = DoctorSpecialities::GetSpecialities($doctor_id);







if(isset($doc)):?>

    <div class="col-md-12" style="top: 128px; position: absolute; background-position: 0; left: 0; height: 400px; background-image: url(https://demo.astoundify.com/listify/wp-content/uploads/sites/39/2014/11/EOZpjI3oSqKPNnF2S4Tp_Untitled.jpg);">

        <div style="margin-top: 200px; margin-left: 100px; color: white;">

            <h1 style="font-size: 34px; font-weight: 600;"><?php echo $doc['first_name'].' '.$doc['middle_name'].' '.$doc['last_name']?></h1>

            <div style="font-size: 15px; font-weight: bold;"><?php echo $address[0][0]['address']?></div>

            <div style="font-size: 15px; font-weight: bold; margin-top: 15px;"><?php echo $specialities[0][0]['name']?></div>

            <div style="margin-top: 30px;">

                <?php if(Modules::IsModuleInstalled('ratings') == 'yes'){

                    $rating .= '<td width="150px" align="center" valign="top">';

                    $rating .= '<div class="ratings_stars" id="rt_doctor_'.$doctor_id.'"></div>';

                    $rating .= '</td>';

                }



                echo $rating;

                ?>

            </div>

        </div>

    </div>

    <div class="col-md-12" style="background: #f5f5f5; height: 370px; margin-top: 380px; position: absolute; left: 0;">

        <div class="col-md-5" style="min-width: 500px;"><?php Doctors::DrawDoctorMap($doctor_id); ?></div>

        <div class="col-md-4">

            <div style="margin-top: 100px;">

                <?php echo $address[0][0]['address']?>

            </div>

            <div><?php echo $address[0][0]['phone']?></div>

            <div><a href="mailto:<?php echo $doc['email']?>"><?php echo $doc['email']?></a></div>

        </div>



    </div>



    <div class="col-md-12" style="height: 750px; visibility: hidden"></div>



<?php endif;?>











