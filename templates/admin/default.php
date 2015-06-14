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

header('content-type: text/html; charset=utf-8');

$nav_panel_state = '1';
if($objLogin->IsLoggedInAsAdmin()){
	$nav_panel_state = (isset($_COOKIE['nav_panel_state']) && ($_COOKIE['nav_panel_state'] == 'collapsed')) ? '0' : '1';				
}

?>
<!DOCTYPE html>
<html>
<head>	
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<meta name="keywords" content="<?php echo $objSiteDescription->GetParameter('tag_keywords'); ?>" />
	<meta name="description" content="<?php echo $objSiteDescription->GetParameter('tag_description'); ?>" />
    <meta name="author" content="ApPHP Company - Advanced Power of PHP">
    <meta name="generator" content="ApPHP Medical Appointment v<?php echo CURRENT_VERSION; ?>">

    <title><?php echo $objSiteDescription->GetParameter('tag_title'); ?> :: <?php echo _ADMIN_PANEL; ?></title>

    <base href="<?php echo APPHP_BASE; ?>" /> 
	<link href="<?php echo APPHP_BASE; ?>images/icons/apphp.ico" rel="SHORTCUT ICON" />
	
	<link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('template');?>/css/style.css" type="text/css" rel="stylesheet" />
	<link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('template');?>/css/print.css" type="text/css" rel="stylesheet" media="print">
	<?php if(Application::Get('lang_dir') == 'rtl'){ ?>
		<link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('template');?>/css/style-rtl.css" type="text/css" rel="stylesheet" />
	<?php } ?>
	<!--[if IE]>
	<link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('template');?>/css/style-ie.css" type="text/css" rel="stylesheet" />
	<![endif]-->

	<link href="ajaxCalendar/css/smoothness/jquery-ui.css" rel="stylesheet" />

	<!-- jquery-ui-multiselect-widget -->
	<link rel="stylesheet" type="text/css" href="custom_libraries/jquery-ui-multiselect-widget/jquery.multiselect.css" />

	<!-- Theme styles START -->
	<link href="assets/global/css/components.css" rel="stylesheet">
	<link href="assets/global/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="assets/frontend/layout/css/style.css" rel="stylesheet">
	<link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('provider_template');?>/css/style.css" type="text/css" rel="stylesheet"/>
	
	<script src="assets/global/plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>js/main.js"></script>
	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('template'); ?>/js/menu.js"></script>	
	
	<script src="ajaxCalendar/lib/jquery-ui.min.js"></script>
	
	<!-- Opacity Module -->
	<link href="<?php echo APPHP_BASE; ?>modules/opacity/opacity.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>modules/opacity/opacity.js"></script>

	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>js/main.js"></script>

</head>    
<body dir="<?php echo Application::Get('lang_dir');?>">
<div id="mainWrapper">
<div id="headerWrapper">

	<?php include_once 'templates/'.Application::Get('template').'/header.php'; ?>

	<table id="contentMainWrapper" cellSpacing="0" cellPadding="0" border="0">
	<tbody>
	<tr>
		<td id="navColumnLeft" class="no_print">
			<div id="navColumnLeftWrapper">
				<!-- LEFT COLUMN -->
				<?php
					$objLogin->DrawLoginLinks();
					if(Application::Get('preview') != 'yes'){
						if(Application::Get('admin') == 'login'){
							echo '<br>'._LOGIN_PAGE_MSG;
						}else if(Application::Get('admin') == 'password_forgotten'){
							echo '<br>'._PASSWORD_FORGOTTEN_PAGE_MSG;
						}						
					}
				?>
				<!-- END OF LEFT COLUMN -->			
			</div>
	    </td>				
		<?php
			if($objLogin->IsLoggedInAsAdmin()){
				$output  = '<td id="navColumnIcon" class="no_print">';
				$output .= '<img id="imgCollapse" title="'._COLLAPSE_PANEL.'" onclick="toggle_navigation_panel(0);" src="templates/'.Application::Get('template').'/images/'.((Application::Get('lang_dir') == 'ltr') ? 'collapse_panel.gif' : 'expand_panel.gif').'" alt="collapse" />';
				$output .= '<img id="imgExpand" title="'._EXPAND_PANEL.'" onclick="toggle_navigation_panel(1);"  src="templates/'.Application::Get('template').'/images/'.((Application::Get('lang_dir') == 'ltr') ? 'expand_panel.gif' : 'collapse_panel.gif').'" alt="expand" />';
				$output .= '</td>';
				echo $output;
			}
		?>		
		<td id="navColumnMain" valign="top">		
			<?php
				if($objLogin->IsLoggedInAsAdmin()){
					echo '<script type="text/javascript">toggle_navigation_panel('.$nav_panel_state.');</script>';
				}
			?>
			<div id="indexDefault" class="center_column">
			<div id="indexDefaultMainContent">			
			<div class="center_box_wrapper">
				<!-- MAIN CONTENT -->
				<?php		
					if(Application::Get('page') == 'home' && $_GET["admin"]=="login")
						include_once('admin/login.php');
					if((Application::Get('patient') != '') && file_exists('patient/'.Application::Get('patient').'.php')){
						include_once('patient/'.Application::Get('patient').'.php');
					}else if((Application::Get('doctor') != '') && file_exists('doctor/'.Application::Get('doctor').'.php')){
						include_once('doctor/'.Application::Get('doctor').'.php');
					}else if((Application::Get('admin') != '') && !preg_match('/mod_/', Application::Get('admin')) && file_exists('admin/'.Application::Get('admin').'.php')){
						include_once('admin/'.Application::Get('admin').'.php');	
					}else if((Application::Get('admin') != '') && preg_match('/mod_/', Application::Get('admin')) && file_exists('admin/modules/'.Application::Get('admin').'.php')){
						include_once('admin/modules/'.Application::Get('admin').'.php');	
					}else{
						if(Application::Get('template') == 'admin'){
							include_once('admin/home.php');
						}else{										
							include_once('page/pages.php');										
						}
					}
				?>
			</div>
			</div>
			</div>			
		</td>		
	</tr>
	</tbody>
	</table>
</div>
</div>

	<script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      

	<!-- BEGIN jquery UI Multiselect -->
	<script type="text/javascript" src="custom_libraries/jquery-ui-multiselect-widget/src/jquery.multiselect.js"></script>
	<!-- END jquery UI Multiselect -->

	<!-- Start Google Address Suggestion box -->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true&libraries=places">  </script>
	<script src="assets/frontend/layout/scripts/googleAddressSuggestion/src/js/jquery.placepicker.js"></script>
	<!-- End Google Address Suggestion box -->
	
	<!-- BEGIN jquery-validation -->
	<script src="custom_libraries/jquery-validation-1.13.1/dist/jquery.validate.js"></script>
	<script src="custom_libraries/jquery-validation-1.13.1/dist/additional-methods.min.js"></script>
	<!-- END jquery-validation -->
	
	<script src="js/provider_setup.js" type="text/javascript"></script>
	
<?php
	if($objLogin->IsLoggedInAsAdmin()){
		echo '<script type="text/javascript">set_active_menu_count('.$objLogin->GetActiveMenuCount().');</script>';
	}
?>
</body>
</html>