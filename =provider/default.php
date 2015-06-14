<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <meta charset="utf-8">
 <meta name="keywords" content="<?php echo str_replace("ApPHP","IngageMd",Application::Get('tag_keywords')); ?>" meta name="description" content="<?php echo str_replace("ApPHP","IngageMd",Application::Get('tag_description'));  ?>" />
   

    <title><?php echo str_replace("ApPHP","IngageMd",Application::Get('tag_title'));  ?></title>

  <meta property="og:site_name" content="-CUSTOMER VALUE-">
  <meta property="og:title" content="-CUSTOMER VALUE-">
  <meta property="og:description" content="-CUSTOMER VALUE-">
  <meta property="og:type" content="website">
  <meta property="og:image" content="-CUSTOMER VALUE-"><!-- link to image for socio -->
  <meta property="og:url" content="-CUSTOMER VALUE-">

  <link rel="shortcut icon" href="favicon.ico">

  <!-- Fonts START -->
  <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|PT+Sans+Narrow|Source+Sans+Pro:200,300,400,600,700,900&amp;subset=all" rel="stylesheet" type="text/css">
  <!-- Fonts END -->

  <!-- Global styles START -->          
  <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="assets/global/plugins/bootstrap/css/bootstrap.css" rel="stylesheet">
  <!-- Global styles END --> 
   
  <!-- Page level plugin styles START -->
  <link href="assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
  <link href="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.css" rel="stylesheet">
  <link href="assets/global/plugins/slider-revolution-slider/rs-plugin/css/settings.css" rel="stylesheet">
  <!-- Page level plugin styles END -->

  <!-- Theme styles START -->
  <link href="assets/global/css/components.css" rel="stylesheet">
  <link href="assets/frontend/layout/css/style.css" rel="stylesheet">
  <link href="assets/frontend/pages/css/style-revolution-slider.css" rel="stylesheet"><!-- metronic revo slider styles -->
  <link href="assets/frontend/layout/css/style-responsive.css" rel="stylesheet">
  <link href="assets/frontend/layout/css/themes/red.css" rel="stylesheet" id="style-color">
  <link href="assets/frontend/layout/css/custom.css" rel="stylesheet">
  <!-- Theme styles END -->
   <link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('provider_template');?>/css/style.css" type="text/css" rel="stylesheet"/>
   <link href="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('provider_template');?>/css/stylesheet.css" type="text/css" rel="stylesheet"/>
 

	<!-- Opacity Module -->
	<link href="<?php echo APPHP_BASE; ?>modules/opacity/opacity.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>modules/opacity/opacity.js"></script>

	<script type="text/javascript" src="<?php echo APPHP_BASE; ?>js/main.js"></script>


		<script src="<?php echo APPHP_BASE; ?>templates/<?php echo Application::Get('provider_template');?>/css/jquery-latest.js"></script>
		<script>
			jQuery(function($) {
				var current_menu = '<?php echo $_GET["provider"];?>';
				$("ul#topnav li a[rel="+current_menu+"]").addClass("active");
				$("ul#topnav li a[rel="+current_menu+"]").parent().parent().addClass("active");
				$("ul#topnav li a[rel="+current_menu+"]").parent().css({"display":"block"});
				$("ul#topnav li").hover(function() {
						
					$(this).find("span").css({"display":"block"});
					$(this).find("span").show();
					if($(this).attr('class')!='active')
						$("ul#topnav li a[rel="+current_menu+"]").parent().css({"display":"none"});
				} , function() {			
					
					$(this).find("span").hide();
					$("ul#topnav li a[rel="+current_menu+"]").parent().css({"display":"block"});
					
				});
				$("ul#topnav li span").hover(function() {
					$(this.parentNode).find("a").css({"color":"#666666"});
					$(this).find("span").show();
					if($(this).parent().attr('class')!='active')
						$("ul#topnav li a[rel="+current_menu+"]").parent().css({"display":"none"});
				} , function() {	
					
					$(this.parentNode).find("a").css({"color":"#FFFFFF"});
					$(this).find("span").hide();
					$("ul#topnav li a[rel="+current_menu+"]").parent().css({"display":"block"});
					
				});
			});
		</script>
</head>

<body>
<div class="main-area">
 <?php 
  

				include_once 'templates/'.Application::Get('provider_template').'/header.php'; 
				if(Application::Get('page') == 'home' && Application::Get('provider') == '' && Application::Get('member') == '' && Application::Get('doctor') == '' && 		Application::Get('provider_template') != 'admin'  && Application::Get('patient') == '')
				{ 					
		 
					include_once('page/home.php');
				}
				else
				{

?>
    <div class="main">
      <div class="container" style="min-height:600px">
      <?php

                if(Application::Get('page') != '' && Application::Get('page') != 'home'){   
                    if(file_exists('page/'.Application::Get('page').'.php')){	 
                        include_once('page/'.Application::Get('page').'.php');
                    }else{
                        include_once('page/404.php');
                    }
				
				}else if(Application::Get('doctor') != ''){
                    if(file_exists('doctor/'.Application::Get('doctor').'.php')){	
						include_once('doctor/'.Application::Get('doctor').'.php');
					}else{
						include_once('doctor/404.php');
					}					
				}else if(Application::Get('provider') != ''){
                    if(file_exists('provider/'.Application::Get('provider').'.php')){	
						include_once('provider/'.Application::Get('provider').'.php');
					}else{
						include_once('provider/404.php');
					}	
								
									
				}else if((Application::Get('admin') != '') && file_exists('admin/'.Application::Get('admin').'.php')){
					include_once('admin/'.Application::Get('admin').'.php');
				}else{
					if(Application::Get('provider_template') == 'admin'){
						include_once('admin/home.php');
					}else{
						include_once('page/pages.php');										
					}
				}
			?>
            </div>
            </div>
<?php
				}
				include_once 'templates/'.Application::Get('provider_template').'/footer.php'; 
?>
 <script src="assets/global/plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="assets/global/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      
    <script src="assets/frontend/layout/scripts/back-to-top.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->

    <!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
    <script src="assets/global/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script><!-- pop up -->
    <script src="assets/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.min.js" type="text/javascript"></script><!-- slider for products -->

    <!-- BEGIN RevolutionSlider -->
  
    <script src="assets/global/plugins/slider-revolution-slider/rs-plugin/js/jquery.themepunch.plugins.min.js" type="text/javascript"></script>
    <script src="assets/global/plugins/slider-revolution-slider/rs-plugin/js/jquery.themepunch.revolution.min.js" type="text/javascript"></script> 
    <script src="assets/frontend/pages/scripts/revo-slider-init.js" type="text/javascript"></script>
    <!-- END RevolutionSlider -->
	
	<!-- Start Google Address Suggestion box -->
	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=true&libraries=places">  </script>
	<script src="assets/frontend/layout/scripts/googleAddressSuggestion/src/js/jquery.placepicker.js"></script>
	<!-- End Google Address Suggestion box -->
	
	<script type="text/javascript" src="/assets/frontend/layout/scripts/sceditor/jquery.sceditor.bbcode.min.js"></script>
	
    <script src="assets/frontend/layout/scripts/layout.js" type="text/javascript"></script>
    <script src="js/jquery/jquery.fileuploadmulti.min.js" type="text/javascript"></script>	
    <script type="text/javascript">
        jQuery(document).ready(function() {
            Layout.init();    
            Layout.initOWL();
            RevosliderInit.initRevoSlider();
            Layout.initTwitter();
            //Layout.initFixHeaderWithPreHeader(); /* Switch On Header Fixing (only if you have pre-header) */
            //Layout.initNavScrolling(); 
		// start code for the registration steps popup which is display after login	
			<?php if($open_popup){ // this variable defined inside my_account.php file ?>
			
			<?php } ?>
        });
    </script>
    <!-- END PAGE LEVEL JAVASCRIPTS -->

</div>
</body>
</html>
