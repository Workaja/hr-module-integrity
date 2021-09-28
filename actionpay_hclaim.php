<?php
$module = array("title" => "Pay Health Claim", "appname" => "HR");
include "__header.php";

$owner = array(3,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { header("Location: view_hclaim.php"); } 

if($_SERVER['REQUEST_METHOD'] == 'GET') {
	if(isset($_GET['pay'])) {
		$noc = $_GET['pay'];
		$ki->query("update claim_kesehatan set dibayar_oleh = '', dibayar_tgl = CURDATE(), status_dok = 'PAID' where no_claim = '".$noc."'");
		$_SESSION['hclaiminfo'] = 'Paid';
		$_SESSION['hclaiminfo_detail'] = $noc;
		echo "<script>window.location.replace('admin_hclaim.php');</script>";
	} 
}

include "__footer.php";
?>