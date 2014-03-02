<?php 

#9 Jan 2013 - John B. Silvestri
#cfcheck.php - a quick & dirty page to show
#if you're using 'orange' or 'grey' cloud w/CloudFlare

$external_ip = $_SERVER["REMOTE_ADDR"];
$cf_ip = $_SERVER["HTTP_CF_CONNECTING_IP"];

$bg_css="";
$status="";

if(!isset($cf_ip)){
	$status='Not using CloudFlare!<br>Browser IP: ' . $external_ip;
	$bg_css="grey";
}else{
	$status="We're on CloudFlare!<br>Browser IP: " . $cf_ip . "<br>CF Proxy IP: " . $external_ip;
	$bg_css="orange";
}

?>
<html>
<head>
<title>ClouldFlare check</title>

<style type="text/css">
body{
	background-color: <?php echo $bg_css; ?>
}
p{
	background-color: white;
}
</style>

</head>
<!--9 Jan 13 (C) JBS -->
<body>
<div>
<h2>Status</h2>
<p>
<?php echo $status ?>
</p>
</div>
</body>
</html>

