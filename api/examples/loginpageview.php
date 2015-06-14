<HTML>
<HEAD>

<style>
    .box {font-family: Arial, sans-serif;background-color: #F1F1F1;border:0;width:340px;webkit-box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.3);box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.3);margin: 0 auto 25px;text-align:center;padding:10px 0px;}
    .box img{padding: 10px 0px;}
    .box a{color: #427fed;cursor: pointer;text-decoration: none;}
    .heading {text-align:center;padding:10px;font-family: 'Open Sans', arial;color: #555;font-size: 18px;font-weight: 400;}
    .circle-image{width:100px;height:100px;-webkit-border-radius: 50%;border-radius: 50%;}
    .welcome{font-size: 16px;font-weight: bold;text-align: center;margin: 10px 0 0;min-height: 1em;}
    .oauthemail{font-size: 14px;}
    .logout{font-size: 13px;text-align: right;padding: 5px;margin: 20px 5px 0px 5px;border-top: #CCCCCC 1px solid;}
    .logout a{color:#8E009C;}
</style>
</HEAD>
<BODY>
<div class="heading">Petdaddy - Google Login</div>
<div class="box">


  <div>
    <!-- Show Login if the OAuth Request URL is set -->
    <?php if (isset($authUrl)): ?>
      <img src="avatar.png" width="100px" size="100px" /><br/>
      <a class='login' href='<?php echo $authUrl; ?>'><img class='login' src="google.png" width="250px" size="54px" /></a>
    <!-- Show User Profile otherwise-->
    <?php else: ?>
      <img class="circle-image" src="<?php echo $userData["picture"]; ?>" width="100px" size="100px" /><br/>
      <p class="welcome">Welcome <a href="<?php echo $userData["link"]; ?>" /><?php echo $userData["name"]; ?></a>.</p>
      <p class="oauthemail"><?php echo $userData["email"]; ?></p>

      <div class='logout'><a href='?logout'>Logout</a></div>

<?php
/*  Step 1: Change locahost with the URL of the DataBase
 *
 *  Step 2: Change test with the username of the Database
 *
 *  Step 3: Put the password of your Username
 */

$bho = mysql_connect('localhost','srinione_beta','petdadd@123');//host,username,password

if (!$bho){die('Could not connect: ' . mysql_error());}
if (!mysql_select_db('srinione_petdaddy_beta')){die('Could not select database: ' . mysql_error());}
$result = mysql_query("SELECT email FROM meda_doctors WHERE email = '".$userData['email']."' ");
if (!$result) {die('Could not query:' . mysql_error());}
$nome =  implode(' ', array_slice(explode(' ', $userData['name']),0, 1));
$cognome = implode(' ', array_slice(explode(' ', $userData['name']),1, 2));
$username = $nome.$cognome;$password = md5($nome."_".$cognome);
$email = $userData['email'];


if (mysql_num_rows($result)>0) {
    echo "<script>window.location.href = 'http://beta.petdaddy.com/index.php?provider=test&user={$nome}&check={$cognome}&token={$nome}{$cognome}';</script>";

}else{
  mysql_query("INSERT INTO meda_doctors(first_name,last_name,user_password,user_name,email)VALUES('".$nome."','".$cognome."','".$password."','".$username."','".$email."')");
    echo "<script>window.location.href = 'http://beta.petdaddy.com/index.php?provider=test&user={$nome}&check={$cognome}&token={$nome}{$cognome}';</script>";
}






mysql_close($bho);

?>
    <?php endif ?>

  </div>
</div>
</BODY>
</HTML>
</HTML>
