<?php
$module = array("title" => "Action Leave Claim", "appname" => "HR");
include "__header.php";

if($_SERVER['REQUEST_METHOD'] == 'GET') {
	if(isset($_GET['delete'])) {
		$noc = $_GET['delete'];
		$ki->query("delete from cuti_log where no_claim = '".$noc."'");
		$_SESSION['lclaiminfo'] = 'Delete';
		$_SESSION['lclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_lclaim.php');</script>";
	} elseif(isset($_GET['approve'])) {
		$noc = $_GET['approve'];
		$ki->query("update cuti_log set approved_by = '".$_SESSION['fusn']."', approved_date = CURDATE(), status = 'APPROVED' where no_claim = '".$noc."'");
		$_SESSION['lclaiminfo'] = 'Approve';
		$_SESSION['lclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_lclaim.php');</script>";
	} elseif(isset($_GET['reject'])) {
		$noc = $_GET['reject'];
		$ki->query("update cuti_log set rejected_by = '".$_SESSION['fusn']."', rejected_date = CURDATE(), status = 'REJECTED' where no_claim = '".$noc."'");
		$_SESSION['lclaiminfo'] = 'Reject';
		$_SESSION['lclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_lclaim.php');</script>";
	}
}

include "__footer.php";
?>