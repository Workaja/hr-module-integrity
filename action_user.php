<?php
include "__connection.php";

if(isset($_POST)) {
	$nik = $_POST['nik'];
	$fna = $_POST['name'];
	$occ = $_POST['occupation'];
	$dep = $_POST['department'];
	$lvl = $_POST['level'];
	$joi = $_POST['joindate'];
	$dac = $_POST['directacc'];
	$esc = $_POST['escalatedto'];
	$prv = $_POST['privilege'];
	$sts = $_POST['userstatus'];

	$ki->query("update users set name = '".$fna."', occupation = '".$occ."', department = '".$dep."', level = '".$lvl."', joindate = '".$joi."', direct_acc = '".$dac."', escalate_to = '".$esc."', privileges = ".$prv.", status = '".$sts."' where nik = '".$nik."'");

	$_SESSION['edituser'] = 'Update';
    $_SESSION['edituser_detail'] = $nik;

    echo "<script>window.location.replace('edit_user.php?no=".$nik."');</script>";
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>