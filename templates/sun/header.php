 <!-- BEGIN TOP BAR -->
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>
 <style type="text/css">
.sticky {
    position: fixed;
    width: 100%;
    left: 0;
    top: 0;
    z-index: 100;
    border-top: 0;
}
</style>
<?php /*?>    <div class="pre-header">
        <div class="container">
            <div class="row">
                <!-- BEGIN TOP BAR LEFT PART -->
                <div class="col-md-6 col-sm-6 additional-shop-info">
                    <ul class="list-unstyled list-inline">
                        <li><i class="fa fa-phone"></i><span>+1 456 6717</span></li>
                        <li><i class="fa fa-envelope-o"></i><span>info@petdaddy.com</span></li>
                    </ul>
                </div>
                <!-- END TOP BAR LEFT PART -->
                <!-- BEGIN TOP BAR MENU -->
                <div class="col-md-6 col-sm-6 additional-nav">
                <ul class="list-unstyled list-inline pull-right">
<?php if(!$login->IsLoggedIn()){ ?>                    
                        <li><a href="index.php?provider=login">Log In</a></li>
                        <li><a href="index.php?provider=create_account">For Business</a></li>
                    
                    <?php
} else
{
					?>
 <li><a href="index.php?submit_logout=logout">Log Out</a></li>                   
                    <?php
}
					?>
                    </ul>
                </div>
                <!-- END TOP BAR MENU -->
            </div>
        </div>        
    </div><?php */?>
    <!-- END TOP BAR -->
    <!-- BEGIN HEADER -->
    <div class="header">
      <div class="container">
        <a class="site-logo" href="index.php"><img src="assets/frontend/layout/img/logos/logo_new.png" alt="Metronic FrontEnd"></a>

        <a href="javascript:void(0);" class="mobi-toggler"><i class="fa fa-bars"></i></a>

        <!-- BEGIN NAVIGATION -->
        <div class="header-navigation pull-right font-transform-inherit">
          <ul>
          
          <?php if($login->IsLoggedInAsDoctor()){ ?>
          
          
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">
                General 
                <i class="fa fa-angle-down"></i>
              </a>
                
              <ul class="dropdown-menu">
                <li><a href="index.php?provider=home">Dashboard</a></li>
                <li><a href="index.php?provider=setup">Setup</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">
                Profile Details 
                <i class="fa fa-angle-down"></i>
              </a>
                
              <ul class="dropdown-menu">
                <li><a href="index.php?provider=my_account">Edit My Profile</a></li>
                <li><a href="index.php?provider=my_specialities">My Specialities</a></li>
                <li><a href="index.php?provider=doctors&docid=<?php echo $login->GetLoggedID(); ?>">View Profile</a></li>
              </ul>
            </li>
             <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">
               Membership Info 
                <i class="fa fa-angle-down"></i>
              </a>
                
              <ul class="dropdown-menu">
                <li><a href="index.php?provider=membership_plans">Membership Plans</a></li>
                <li><a href="index.php?provider=my_orders">My Orders</a></li>
                <li><a href="index.php?provider=my_images_upload">My Images</a></li>
                <li><a href="index.php?provider=my_addresses">My Addresses</a></li>                
              </ul>
            </li>
             <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">
              Appointsment Management
                <i class="fa fa-angle-down"></i>
              </a>
                
              <ul class="dropdown-menu">
                <li><a href="index.php?provider=appointments">Appointments</a></li>
                <li><a href="index.php?provider=schedules_management">Schedules</a></li>
                <li><a href="index.php?provider=timeoff_management">Timeoffs</a></li>
              </ul>
            </li>
<?php
		  }
		  
?>
            <?php if($login->IsLoggedInAsPatient()){ ?>
          
          
            <li>
              <a  href="index.php?patient=home">
                Dashboard 
         
              </a>
            </li>
            <li>
              <a  href="index.php?patient=my_account">
                My Account 
         
              </a>
            </li>
            <li>
              <a  href="index.php?patient=my_appointments">
                My Appointments 
         
              </a>
            </li>
            <li>
              <a  data-toggle="dropdown" data-target="#" href="index.php?patient=my_pets">
                My Pets 
         
              </a>
            </li>
         
         
<?php
		  }
		  
?>

 <?php if((!$login->IsLoggedInAsPatient()) && (!$login->IsLoggedInAsDoctor())){ ?>
          
          
            <li>
              <a  href="index.php">
                Home 
         
              </a>
            </li>
            <?php /*?>
             <li>
              <a  href="index.php?page=pages&system_page=gallery">
               Gallery
         
              </a>
            </li>   
            <li>
              <a  href="index.php?page=pages&system_page=about_us">
               How Its Works
              </a>
            </li><?php 
            <li>
              <a  href="index.php?page=pages&system_page=our_staff">
               Out Staff
         
              </a>
            </li>   */ ?>

            <li>

            <?php if($_GET["provider"]=="login") { ?>
              <a  href="index.php?provider=create_account">
               Become A Member
              </a>			
			<?php } else { ?>
              <a  href="index.php?provider=login">
               Login
              </a>
             <?php } ?> 
            </li>
         
         
<?php
		  }
		  
?>
          
            

            <!-- BEGIN TOP SEARCH -->
            <?php /*
            <li class="menu-search">
              <span class="sep"></span>
              <i class="fa fa-search search-btn"></i>
              <div class="search-box">
                <form action="#">
                  <div class="input-group">
                    <input type="text" placeholder="Search" class="form-control">
                    <span class="input-group-btn">
                      <button class="btn btn-primary" type="submit">Search</button>
                    </span>
                  </div>
                </form>
              </div> 
            </li>
            */ ?>
            <!-- END TOP SEARCH -->
          </ul>
        </div>
        <!-- END NAVIGATION -->
      </div>
<!--Start of Zopim Live Chat Script-->
<script type="text/javascript">
window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute("charset","utf-8");
$.src="//v2.zopim.com/?31qgwo7XInHV8v5bRjjIgWKyZfwiTlZE";z.t=+new Date;$.
type="text/javascript";e.parentNode.insertBefore($,e)})(document,"script");
</script>
<!--End of Zopim Live Chat Script-->
    </div>
    <!-- Header END -->
    <script type="text/javascript">
                       jQuery(document).ready(function() {
                       var stickyNavTop = jQuery('.header').offset().top;
               var stickyNav = function(){
                var scrollTop = jQuery(window).scrollTop();
                if (scrollTop > stickyNavTop) {
                    jQuery('.header').addClass('sticky');
                } else {
                    jQuery('.header').removeClass('sticky');
                }
            };

            stickyNav();
            jQuery(window).scroll(function() {
                stickyNav();
            });
        });
             
</script>