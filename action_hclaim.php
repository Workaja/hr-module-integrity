<?php
$module = array("title" => "Action Health Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { header("Location: view_hclaim.php"); } 

if($_SERVER['REQUEST_METHOD'] == 'GET') {
	if(isset($_GET['delete'])) {
		$noc = $_GET['delete'];
		$ki->query("delete from claim_kesehatan where no_claim = '".$noc."'");
		$_SESSION['hclaiminfo'] = 'Delete';
		$_SESSION['hclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_hclaim.php');</script>";
	} elseif(isset($_GET['approve'])) {
		$noc = $_GET['approve'];
		$ki->query("update claim_kesehatan set disetujui_oleh = '".$_SESSION['fusn']."', disetujui_tgl = CURDATE(), status_dok = 'APPROVED' where no_claim = '".$noc."'");
		$_SESSION['hclaiminfo'] = 'Approve';
		$_SESSION['hclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_hclaim.php');</script>";
	} elseif(isset($_GET['reject'])) {
		$noc = $_GET['reject'];
		$ki->query("update claim_kesehatan set ditolak_oleh = '".$_SESSION['fusn']."', ditolak_tgl = CURDATE(), status_dok = 'REJECTED' where no_claim = '".$noc."'");
		$_SESSION['hclaiminfo'] = 'Reject';
		$_SESSION['hclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_hclaim.php');</script>";
	}
}

include "__footer.php";
?>