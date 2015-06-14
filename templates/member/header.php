<div class="top-section">

		<div class="top-logo"></div>
        <div class="top-right"><div class="right-text">Signed in as <span style="color:#FFFFFF; font-weight:bold; font-size:13px;"> <?php echo $objLogin->GetLoggedFirstName()." ".$objLogin->GetLoggedLastName();?></span></div>
        	<div class="menu-right"><ul><li><a href="index.php?submit_logout=logout">Log Out</a></li></ul></div>
        </div>
         <div class="top-menu"><ul id="topnav">
			<li class="active"><a href="index.php?member=home" rel="home"  >Dashboard</a>             
            </li>
			<li><a href="index.php?member=my_account" rel="my_account">My Account</a>            
            </li>
			<li><a href="index.php?member=my_appointments" rel="my_appointments">My Appointments</a>            
            </li>
            <li><a href="index.php?member=my_pets" rel="my_pets">My Pets</a>			
            </li>
          
            </ul></div>

</div>
<div style="clear:both"></div>