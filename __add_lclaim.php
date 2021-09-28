<?php
include "__connection.php";

if(isset($_POST)) {
	#get claim number
	$getLastClaimNumber = $ki->query("select no_claim from cuti_log order by no_claim desc limit 1");
	$ClaimNum = $getLastClaimNumber->fetch_assoc();

	#dissect no_claim
	$getnumOfClaim = substr($ClaimNum['no_claim'], 5, 10);

	#add one
	$newnumOfClaim = 1 + (int) $getnumOfClaim;

	#padding
	$newnumClaim = "KC-16" . str_pad($newnumOfClaim, 4, "0", STR_PAD_LEFT);
	
	#get hr manager & office manager
	$getDirectAcc = $ki->query("select direct_acc from users where username = '".$_SESSION['fusn']."'");
	$DA = $getDirectAcc->fetch_assoc();

	#total date to input
	$totalDays = $_POST['TotalDays'];

	#convert to require date to input
	$startdate = date_format(new DateTime($_POST['start-date']),'Y-m-d');
	$enddate = date_format(new DateTime($_POST['end-date']),'Y-m-d');

	#emergency number to input
	$emergency = $_POST['emergency-contact'];

	#reason as note to input
	$reason = $_POST['leave-reason'];

	#leave type
	$type = $_POST['type-leave'];

	/////////////////////////////////////////////////////////////////////////////////////////////////////

	$ki->query("insert into cuti_log (no_claim,user,escalated_to,tgl_input,totaldate,tgl_cuti_from,tgl_cuti_to,periode,jenis_cuti,emergency,note,status)
	values('".$newnumClaim."','".$_SESSION['fusn']."','".$DA['direct_acc']."',NOW(),".$totalDays.",'".$startdate."','".$enddate."',2016,'".$type."','".$emergency."','".$reason."','DRAFT');");

	$_SESSION['lclaiminfo'] = 'Success';
	$_SESSION['lclaiminfo_detail'] = $newnumClaim;

	header("Location: leave_claim.php");

} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>