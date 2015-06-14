<div class="top-section">

		<div class="top-logo">Petdaddy.com</div>
        <div class="top-right"><div class="right-text">Signed in as <span style="color:#FFFFFF; font-weight:bold; font-size:13px;"> <?php echo $objLogin->GetLoggedFirstName()." ".$objLogin->GetLoggedLastName();?></span></div>
        	<div class="menu-right"><ul><li><a href="index.php?provider=setup">Setting</a></li><li><a href="index.php?submit_logout=logout">Log Out</a></li></ul></div>
        </div>
         <div class="top-menu"><ul id="topnav">
			<li ><a href="#" class="active" >General</a>
             <span style="display: none;">                                      
                	<a href="index.php?provider=home" rel="home" class="active">Dashboard</a>
					<a href="index.php?provider=setup" rel="setup" >Setup</a>                    
             </span>
            </li>
			<li><a href="#">Profile Details</a>
            <span style="display: none;">                                      
                	<a href="index.php?provider=my_account" rel="my_account">Edit My Profile</a>
					<a href="index.php?provider=my_specialities" rel="my_specialities">My Specialities</a>
					<a href="index.php?provider=doctors&docid=<?php echo $login->GetLoggedID(); ?>" rel="doctors">View Profile</a>
             </span>
            </li>
			<li><a href="#">Membership Info </a>
            <span style="display: none;">                                      
                	<a href="index.php?provider=membership_plans" rel="membership_plans">Membership Plans</a>
					<a href="index.php?provider=my_orders" rel="my_orders">My Orders</a>
					<a href="index.php?provider=my_images_upload" rel="my_images_upload">My Images</a>
					<a href="index.php?provider=my_addresses" rel="my_addresses">My Addresses</a>
             </span>
            </li>
            <li><a href="#">Appointsment Management</a>
			<span style="display: none;">                                      
            	<a href="index.php?provider=appointments" rel="appointments">Appointments</a>
                <a href="index.php?provider=schedules_management" rel="schedules_management">Schedules</a>
                <a href="index.php?provider=timeoff_management" rel="timeoff_management">Timeoffs</a>
			</span>	
            </li>
          
            </ul></div>

</div>
<div style="clear:both"></div>