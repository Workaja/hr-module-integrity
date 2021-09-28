<?php
$module = array("title" => "Change Password", "appname" => "HR");
include "__header.php";

if(isset($_POST)) {
	if($_POST['currentPassword'] != NULL && $_POST['confirmPassword'] != NULL && $_POST['newPassword'] != NULL) {
		$curPWD = $_POST['currentPassword'];
		$conPWD = $_POST['confirmPassword'];
		$newPWD = $_POST['newPassword'];

		$protNEW = base64_encode($newPWD);
		$protOLD = base64_encode($curPWD);


		if($newPWD != $conPWD) {
			#send error not same
			$_SESSION['passwordinfo'] = 'notmatch';
			echo "<script>window.location.replace('chpwd.php');</script>";
		} else {
			$chnewPWD = $ki->query("select `password` from users where `password` = password('".$curPWD."') and username = '".$_SESSION['fusn']."';");
			$conewPWD = $chnewPWD->num_rows;

			if($conewPWD == NULL) {
				#send error wrong password
				$_SESSION['passwordinfo'] = 'wrongpwd';
				echo "<script>window.location.replace('chpwd.php');</script>";
				#var_dump($conewPWD);
			} elseif($conewPWD != NULL) { 
				$ki->query("insert into __chpw_log (username,pwd,reg_time,ip_address) values ('".$_SESSION['fusn']."','n:".$protNEW."_o:".$protOLD."',now(),'".getHostByName(getHostName())."');");
				#if there no problem with both of them above
				$ki->query("update users set `password` = password('".$newPWD."') where username = '".$_SESSION['fusn']."';");

				#send good signal
				$_SESSION['passwordinfo'] = 'success';
				echo "<script>window.location.replace('chpwd.php');</script>";
				#var_dump($conewPWD);
			}
		}


	} else { echo "<script>window.location.replace('chpwd.php');</script>"; }
} else { echo "<script>window.location.replace('chpwd.php');</script>"; }

include "__footer.php";
?>