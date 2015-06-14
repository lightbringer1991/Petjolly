<?php 
	include('includes/connection.php'); 
	include('includes/database.class.php');
	@$con = new connectMe(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE);
	
	@$error = $con->mysqli->connect_errno;

	if($error == 0)
	{
		include('includes/inscheck.class.php');
		
		$insCheck->tables = array(
			'calendar' => array('id', 'title', 'description', 'start', 'end', 'allDay', 'color', 'url', 'category', 'repeat_type', 'user_id', 'repeat_id'),
			'users' => array('id', 'username', 'password')
		);
		
		$insCheck->reqFields = 15;
		
		$c = $insCheck->check($con);
	}

?>

<!DOCTYPE HTML>
<html lang="en">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Paulo">
    <meta name="author" content="Paulo Regina">
    
	<title>Ajax Full Featured Calendar 2 Installation</title>
    
    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="css/bootstrap-responsive.css" rel="stylesheet" media="screen">
    <link href="css/install.css" rel="stylesheet" media="screen">
</head>
<body>
	
    <div class="container">
    	<div class="wrap">
        
            <!-- page -->
            <div id="page">
            
				<div id="header"><h1 align="center">AFFC2 Install</h1></div>
                
                <p class="intro">
                	<?php if(isset($c) && $c == true)
					{
						exit('<div class="alert alert-success">The installer detected that AFFC2 is already installed.</div>');
					}
					
					if($error !== 0)
					{
						echo '
						<div class="alert alert-info" style="text-align: center;">
							The installer detected that you need the correct installation. The connection.php is empty or incomplete
						</div>';
						$install_type = 'NEW';
					} else {
						echo '
						<div class="alert alert-info">
							The installer detected that you have a connection to database but no tables found
						</div>';	
						$install_type = 'TBL_IMPORT';
					}
					
					?>
            	</p>
                
                <?php
				
					$_host = '';
					$_username = '';
					$_password = '';
					$_dbname = '';
					$_admin_username = '';
					$_admin_password = '';
					
					$cal_tbl = "
								CREATE TABLE IF NOT EXISTS `calendar` (
								  `id` int(11) NOT NULL AUTO_INCREMENT,
								  `title` varchar(160) NOT NULL,
								  `description` text NOT NULL,
								  `start` datetime NOT NULL,
								  `end` datetime NOT NULL,
								  `allDay` varchar(5) NOT NULL,
								  `color` varchar(7) NOT NULL,
								  `url` varchar(255) NOT NULL,
								  `category` varchar(200) NOT NULL,
								  `repeat_type` varchar(20) NOT NULL,
								  `user_id` int(11) NOT NULL,
								  `repeat_id` int(11) NOT NULL,
								  PRIMARY KEY (`id`)
								) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
								";
					
					$users_tbl = "
								CREATE TABLE IF NOT EXISTS `users` (
								  `id` int(11) NOT NULL AUTO_INCREMENT,
								  `username` varchar(255) NOT NULL,
								  `password` varchar(64) NOT NULL,
								  PRIMARY KEY (`id`),
								  UNIQUE KEY `username` (`username`)
								) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;
								";
					
					$users_data = "INSERT INTO `users` (`id`, `username`, `password`) VALUES
									(1, 'demouser', '8cb2237d0679ca88db6464eac60da96345513964'),
									(2, 'testuser', '8cb2237d0679ca88db6464eac60da96345513964');";
					
					// INSTALL TYPE = NEW
					if($install_type == 'NEW')
					{
						if(isset($_POST['e_install']) && !empty($_POST['db_name']) && !empty($_POST['db_username']) && !empty($_POST['db_password']) && !empty($_POST['db_host']) && !empty($_POST['add_username']) && !empty($_POST['add_password']))
						{ 
							$_host = $_POST['db_host'];
							$_username = $_POST['db_username'];
							$_password = $_POST['db_password'];
							$_dbname = $_POST['db_name'];
							
							$_admin_username = $_POST['add_username'];
							$_admin_password = $_POST['add_password'];
							
							@$new_con = new connectMe($_host, $_username, $_password, $_dbname);
							@$new_con_error = $new_con->mysqli->connect_errno;
							@$new_con_erro = $new_con->mysqli->connect_error;
							
							// Connection OK
							if($new_con_error == 0)
							{
// Everything is ok
// - save to a file the configs
$file_write = 
"<?php
	
	// DB Connection Configuration
	define('DB_HOST', '".$_host."'); 
	define('DB_USERNAME', '".$_username."'); 
	define('DB_PASSWORD', '".$_password."'); 
	define('DATABASE', '".$_dbname."'); 
	define('TABLE', 'calendar');
	define('USERS_TABLE', 'users');
	
	// Default Categories
	".'$categories = '.'array("General","Party","Work");'."
	
?>";

								$file = dirname(__FILE__).'/includes/'.'connection.php';
								
								if($handle = fopen($file, 'w'))
								{
									fwrite($handle, $file_write);
									fclose($handle);
									chmod($file, 0777); // make file writable	
								} else {
									echo '
										<div class="alert alert-error">Installation Failed: Cannot create configuration file</div>
									';		
								}
								
								$new_con->query($cal_tbl);
								$new_con->query($users_tbl);
								
								$sha1 = sha1($_admin_password);
								
								$dump_users_table = $new_con->query( 
								"
									INSERT INTO `users` (`id`, `username`, `password`) VALUES
									(NULL, '$_admin_username', '$sha1');
								");
								
								echo '<div class="alert alert-success">Congratulations! Installation was a success</div>';
								
								header('Location: '.$_SERVER['PHP_SELF']);
								exit();
																
							} else {
								echo '<div class="alert alert-error">
									Failed to establish a connection. Error: <pre>'.$new_con_erro.'</pre>
								</div>';	
							}
							
							
						} elseif(isset($_POST['e_install']) && empty($_POST['db_name']) && empty($_POST['db_username']) && empty($_POST['db_password']) && empty($_POST['db_host'])) {
							$_host = $_POST['db_host'];
							$_username = $_POST['db_username'];
							$_password = $_POST['db_password'];
							$_dbname = $_POST['db_name'];
														
							echo '
								<div class="alert alert-info">All fields cannot be empty</div>
							';	
						}

				?>
                
                <p class="intro">
                Welcome to the one click install. Before start using ajax full featured calendar, we need some
            	information for the application configuration:
                </p>
                
                <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
                    <table class="table table-bordered">
                        <tr>
                            <th scope="row"><label>DB Name:</label></th>
                            <td>
                                <input name="db_name" class="form-control" id="req" type="text" size="32" value="<?php echo $_dbname; ?>" />
                                <p class="help-block">The Database Name</p>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label>DB User Name:</label></th>
                            <td>
                            	<input name="db_username" class="form-control" id="req" type="text" size="32" value="<?php echo $_username; ?>" />
                                <p class="help-block">The Database Username</p>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label>DB Password:</label></th>
                            <td>
                            	<input name="db_password" class="form-control" id="req" type="text" size="32" value="<?php echo $_password; ?>" />
                                <p class="help-block">The Database Password</p>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label>DB Host:</label></th>
                            <td>
                            	<input name="db_host" class="form-control" id="req" type="text" size="32" value="<?php echo $_host; ?>" />
                                <p class="help-block">The Database Host</p>
                            </td>
                        </tr>
                        <tr><th></th><td></td></tr>
                        <tr>
                            <th scope="row"><label>Login Username:</label></th>
                            <td>
                            	<input name="add_username" class="form-control" id="req" type="text" size="32" value="<?php echo $_admin_username; ?>" />
                                <p class="help-block">Your username to login to the system</p>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label>Login Password:</label></th>
                            <td>
                            	<input name="add_password" class="form-control" id="req" type="text" size="32" value="<?php echo $_admin_password; ?>" />
                                <p class="help-block">Your  password</p>
                            </td>
                        </tr>
                    </table>
                    <input type="submit" class="btn btn-primary pull-right" name="e_install" value="Install" />
                </form>
                <p class="help-block">Please Note: If you see this install, its because ajax full featured calendar is not installed yet. Can't use this? Fill up connection.php manually from /includes/.</p>
                <div class="clear"></div>
                
                <?php
				// INSTALL TYPE = TBL_IMPORT	
				} elseif($install_type == 'TBL_IMPORT') {
					@$new_con = new connectMe(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE);
					$new_con_error = $new_con->mysqli->connect_errno;
						
					// Connection OK
					if($new_con_error == 0)
					{
						$new_con->query($cal_tbl);
						$new_con->query($users_tbl);
						$new_con->query($users_data);
						echo '<div class="alert alert-success">We have imported the data. Use as usernames: demouser or testuser with password: 12345 to access the system, delete them after, and create yours.</div>';
					} else {
						echo '<div class="alert alert-error">
							Failed to establish a connection. Error: <code>'.$new_con->mysqli->error.'</code>
						</div>';	
					}
				}
				?>
                
            </div>
            <!-- // page -->
                        
        </div>
    </div>
	

</body>
</html>