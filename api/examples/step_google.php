<?php

session_start();
require_once realpath(dirname(__FILE__) . '/../src/Google/autoload.php');

//Google Api Lib
require_once '/home3/srinione/public_html/qa/api/src/Google/Client.php';
require_once '/home3/srinione/public_html/qa/api/src/Google/Service/Oauth2.php';
require_once '/home3/srinione/public_html/qa/api/src/Google/Service/Calendar.php';

//Credential
$client_id = "501001681639-vehqm5bi91geoioom3qltaao00dt0koa.apps.googleusercontent.com";
$client_secret = "u4zgG33zq03uav64qqDFL1lp";
$redirect_uri = "http://beta.petdaddy.com/api/examples/step_google.php";
$simple_api_key = "AIzaSyDJC9BBm_CVzj-EIlcEsDrgEGIAVafybjM";


//Create client Request to acces Google API
$client = new Google_Client();
$client->setApplicationName("Petdaddy Login");
$client->setClientId($client_id);
$client->setClientSecret($client_secret);
$client->setRedirectUri($redirect_uri);
$client->setDeveloperKey($simple_api_key);
$client->addScope("https://www.googleapis.com/auth/userinfo.email");
//Send Client Request
$objOAuthService = new Google_Service_Oauth2($client);

//Logout
if (isset($_REQUEST['logout'])) {
  unset($_SESSION['access_token']);
  $client->revokeToken();
  header('Location: ' . filter_var($redirect_uri, FILTER_SANITIZE_URL)); //redirect user back to page
}

//Authenticate code from Google OAuth Flow
//Add Access Token to Session
if (isset($_GET['code'])) {
  $client->authenticate($_GET['code']);
  $_SESSION['access_token'] = $client->getAccessToken();
  header('Location: ' . filter_var($redirect_uri, FILTER_SANITIZE_URL));
}

//Set Access Token to make Request
if (isset($_SESSION['access_token']) && $_SESSION['access_token']) {
  $client->setAccessToken($_SESSION['access_token']);
}


//Get user data from google plus
//If new, Insertto Database
if ($client->getAccessToken()) {
  $userData = $objOAuthService->userinfo->get();
} else {
  $authUrl = $client->createAuthUrl();
}


require_once("loginpageview.php");
?>