<?php
include "__connection.php";

if(isset($_POST)) {
	#get claim number
	$getLastClaimNumber = $ki->query("select no_claim from lembur_log order by no_claim desc limit 1");
	$ClaimNum = $getLastClaimNumber->fetch_assoc();

	#dissect no_claim
	$getnumOfClaim = substr($ClaimNum['no_claim'], 5, 10);

	#add one
	$newnumOfClaim = 1 + (int) $getnumOfClaim;

	#padding
	$newnumClaim = "KO-16" . str_pad($newnumOfClaim, 4, "0", STR_PAD_LEFT);
	
	#get hr manager & office manager
	$getDirectAcc = $ki->query("select direct_acc from users where username = '".$_POST['variable-user']."'");
	$DA = $getDirectAcc->fetch_assoc();

	#convert to require date to input
	$startdate = date_format(new DateTime($_POST['start-date']),'Y-m-d');
	$enddate = date_format(new DateTime($_POST['end-date']),'Y-m-d');

	#list total from kalender
	$ListKal = "";
	$getListKalender = $ki->query("select tanggal from kalender where tanggal between '".$startdate."' and '".$enddate."'");
	while($LK = $getListKalender->fetch_assoc()){
		$ListKal .= $LK['tanggal'] . ":";
	}

	#total date to input
	$totalDays = count(array_filter(explode(":", $ListKal)));

	#totaldate to be cut for accomodation
	$arrayWithRestInNight = array('luarkota','luarnegeri');
	if(in_array($_POST['variable-type'], $arrayWithRestInNight)) {
		$finalDays = (int) $totalDays - 1;
	} else {
		$finalDays = $totalDays;
	}

	if($_POST['variable-user'] != $_SESSION['fusn']) {
		$InputBy = "'".$_SESSION['fusn']."'";
	} else {
		$InputBy = NULL;
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	$ki->query("insert into lembur_log (no_claim,user,input_by,tgl_input,tgl_start,tgl_end,total_date,tgl_list,jenis_lembur,escalated_to,status)
	values('".$newnumClaim."','".$_POST['variable-user']."',".$InputBy.",CURDATE(),'".$startdate."','".$enddate."',".$finalDays.",'".$ListKal."','".$_POST['variable-type']."','".$DA['direct_acc']."','DRAFT');");

	$_SESSION['vpclaiminfo'] = 'Success';
	$_SESSION['vpclaiminfo_detail'] = $newnumClaim;

	header("Location: vp_claim.php");

} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>