<?php
include "__connection.php";
// flock control

if(isset($_GET['logout'])) {
	$ki->query("insert into __login_log (username,state,reg_time,ip_address) values ('".$_SESSION['fusn']."',2,now(),'".getHostByName(getHostName())."');");
	SESSION_DESTROY();
	header("Location: login.php");
}

if(!isset($_POST['flock-username']) || !isset($_POST['flock-password'])) {
	$_SESSION['flock-loginerror'] = 'There is error on your account, please check before.';
	header("Location: login.php");

} else {
	$fu = $_POST['flock-username'];
	$fp = $_POST['flock-password'];

	#check username and password
	$fc = $ki->query("select * from users where username = '".$fu."' and password = password('".$fp."') and status = 'active'");
	$fd = $fc->fetch_assoc();

	if($fd == NULL) {
		$ki->query("insert into __login_log (username,state,reg_time,ip_address) values ('".$fu."',0,now(),'".getHostByName(getHostName())."');");
		$_SESSION['flock-loginerror'] = 'There is error on your account, please check before or send ticket with error login subject.';
		header("Location: login.php");
	} else {
		$ki->query("insert into __login_log (username,state,reg_time,ip_address) values ('".$fu."',1,now(),'".getHostByName(getHostName())."');");
		$_SESSION['fcon'] = "Orait";
		$_SESSION['fusn'] = $fd['username'];
		$_SESSION['fnam'] = $fd['name'];
		$_SESSION['focc'] = $fd['occupation'];
		$_SESSION['fprv'] = $fd['privileges'];
		
		header("Location: index.php");
	}
}



mysqli_close($ki);
?>