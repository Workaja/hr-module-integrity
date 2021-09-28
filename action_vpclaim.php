<?php
$module = array("title" => "Action Variable Pay Claim", "appname" => "HR");
include "__header.php";

if($_SERVER['REQUEST_METHOD'] == 'GET') {
	if(isset($_GET['delete'])) {
		$noc = $_GET['delete'];
		$ki->query("delete from lembur_log where no_claim = '".$noc."'");
		$_SESSION['vpclaiminfo'] = 'Delete';
		$_SESSION['vpclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_vpclaim.php');</script>";
	} elseif(isset($_GET['approve'])) {
		$noc = $_GET['approve'];
		$ki->query("update lembur_log set approved_by = '".$_SESSION['fusn']."', approved_date = CURDATE(), status = 'APPROVED' where no_claim = '".$noc."'");
		$_SESSION['vpclaiminfo'] = 'Approve';
		$_SESSION['vpclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_vpclaim.php');</script>";
	} elseif(isset($_GET['reject'])) {
		$noc = $_GET['reject'];
		$ki->query("update lembur_log set rejected_by = '".$_SESSION['fusn']."', rejected_date = CURDATE(), status = 'REJECT' where no_claim = '".$noc."'");
		$_SESSION['vpclaiminfo'] = 'Reject';
		$_SESSION['vpclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_vpclaim.php');</script>";
	} elseif(isset($_GET['change'])) {
		$noc = $_GET['change'];
		$dol = $_GET['conv'];
		$ki->query("update lembur_log set dollar = ".$dol." where no_claim = '".$noc."'");
		$_SESSION['vpclaiminfo'] = 'Dollar';
		$_SESSION['vpclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('info_vpclaim.php?no=".$noc."');</script>";
	}
}

include "__footer.php";
?>