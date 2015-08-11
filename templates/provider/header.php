<style type="text/css">
.sidebar-menu > li > a, .sidebar-menu .treeview-menu > li > a {
    font-size: 14px;
}
.navbar-nav > li > a {
    font-size: 14px;
}
.content-wrapper, .right-side {
    background-color: #FFFFFF;
}

.main-sidebar, .main-header .logo {
    width: 200px;
}

.main-header > .navbar, .content-wrapper, .right-side, .main-footer {
    margin-left: 200px;
}

</style>

<?php
    $providerInfo = Doctors::GetDoctorInfoById(Session::Get("session_account_id"));
?>

<div class="wrapper">
    <header class="main-header">
        <!-- Logo -->
        <a href="index.php?provider=home" class="logo" style="text-align: left;"><?php echo $providerInfo[0]['business_name']; ?></a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" style="font-size: 20px;" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- User Account: style can be found in dropdown.less -->
                    <li>
                        <a>
                            <span class="hidden-xs">Welcome <?php echo $providerInfo[0]['first_name'] . " " . $providerInfo[0]['last_name']; ?></span>
                        </a>

                    </li>
                    <li>
                        <a href="index.php?provider=my_account">
                            <span class="hidden-xs">Profile</span>
                        </a>
                    </li>
                    <li>
                        <a href="index.php?submit_logout=logout">
                            <span class="hidden-xs">Log Out</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>

    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li>
                    <a href="index.php?provider=fullCalendar">
                        <i class="fa fa-calendar"></i>
                        <span>CALENDAR</span>
                    </a>
                </li>
                <li>
                    <a href="index.php?provider=customers&mode=view">
                        <i class="fa fa-user"></i> <span>CUSTOMERS</span>
                    </a>
                </li>
                <li class="treeview">
                    <a href="index.php?provider=home">
                        <i class="fa fa-dashboard"></i> <span>DASHBOARD</span></i>
                    </a>
                </li>
                <li>
                    <a href="index.php?provider=dashboard&mode=chart">
                        <i class="fa fa-bar-chart-o"></i>
                        <span>REPORTS</span>
                    </a>
                </li>
                <li>
                    <a href="index.php?provider=setup">
                        <i class="fa fa-calendar"></i> <span>BUSINESS SETUP</span>
                    </a>
                </li>
                <li>
                    <a href="index.php?provider=services&category=service">
                        <i class="fa fa-tasks"></i>
                        <span>SERVICES</span>
                    </a>
                </li>
                <li>
                    <a href="index.php?provider=membership_plans">
                        <i class="fa fa-edit"></i> <span>MEMBERSHIP INFO</span>
                    </a>
                </li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>
</div>

<div style="clear:both"></div>
<style type="text/css">
.loading-gif {
    display: block;
	position: absolute;
	left: 50%;
	top: 50%;
    z-index: 100;
}
</style>

<div data-role="loading-popup" class="loading-gif">
	<img src="images/ajax_loading.gif" />
</div>