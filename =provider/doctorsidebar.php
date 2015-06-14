<div class="page-sidebar navbar-collapse collapse" style="height:600px">
				<!-- BEGIN SIDEBAR MENU -->
				<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
				<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
				<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
				<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
				<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
				<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
                 <?php if($login->IsLoggedInAsDoctor()){ ?>
				<ul class="page-sidebar-menu page-sidebar-menu-hover-submenu1" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
					<li class="heading">
						<h3>GENERAL</h3>
					</li>
					<li class="active">
						<a href="index.php?doctor=home">
						<i class="icon-home"></i>
						<span class="title">Dashboard</span>
						</a>
					</li>
					</ul>
                    <ul class="page-sidebar-menu page-sidebar-menu-hover-submenu1" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
					<li>
						<a href="javascript:;">
						<i class="icon-basket"></i>
						<span class="title">Profile Details</span>
						<span class="arrow "></span>
						</a>
						<ul class="sub-menu">
							<li>
								<a href="index.php?doctor=my_account">
								<i class="icon-home"></i>
								Edit My Profile</a>
							</li>
							<li>
								<a href="index.php?doctor=my_specialities">
								<i class="icon-basket"></i>
								My Specialities</a>
							</li>
							<li>
								<a href="index.php?doctor=doctors&docid=<?php echo $login->GetLoggedID(); ?>">
								<i class="icon-tag"></i>
								View Profile</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="javascript:;">
						<i class="icon-rocket"></i>
						<span class="title">Membership Info </span>
						<span class="arrow "></span>
						</a>
						<ul class="sub-menu">
							<li>
								<a href="index.php?doctor=membership_plans">
								<span class="badge badge-roundless badge-danger">Membership</span> Plans</a>
							</li>
							<li>
								<a href="index.php?doctor=my_orders">
								<span class="badge badge-roundless badge-warning">My</span> Orders</a>
							</li>
							<li>
								<a href="index_extended.html">
								<span class="badge badge-roundless badge-warning">My</span> Images</a>
							</li>
							<li>
								<a href="index.php?doctor=my_addresses">
								<span class="badge badge-roundless badge-warning">My</span> Addresses</a>
							</li>
							
						</ul>
					</li>
					<li>
						<a href="javascript:;">
						<i class="icon-diamond"></i>
						<span class="title">Appointsment Management</span>
						<span class="arrow "></span>
						</a>
						<ul class="sub-menu">
							<li>
								<a href="index.php?doctor=appointments">
								Appointments</a>
							</li>
							<li>
								<a href="index.php?doctor=schedules_management">
								Schedules</a>
							</li>
							<li>
								<a href="index.php?doctor=timeoff_management">
								Timeoffs</a>
							</li>
							
						</ul>
					</li>
					
                    
				</ul>
                <?php } ?>
                
                
				<!-- END SIDEBAR MENU -->
			</div>
           