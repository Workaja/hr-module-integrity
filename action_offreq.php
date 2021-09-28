<?php
$module = array("title" => "Leave Request Form", "appname" => "HR");
include "__header.php";

if(isset($_POST['StartDate']) && isset($_POST['EndDate'])) {
	$starter = new DateTime($_POST['StartDate']);
	$ender = new DateTime($_POST['EndDate']);

	#dissect the type
	switch($_POST['LeaveType']){
		case 5: $IL = 'sick'; break;	case 6: $IL = 'wed1'; break;	case 7: $IL = 'wed2'; break;	case 8: $IL = 'bles'; break;
		case 9: $IL = 'mate'; break;	case 10: $IL = 'dye1'; break;	case 11: $IL = 'dye2'; break;
	}

	#get kalender
	$list = "";
	$getFullDayCalendar = $ki->query("select tanggal from kalender where tanggal >= '".date_format($starter,"Y/m/d")."' and tanggal <= '".date_format($ender,"Y/m/d")."' and merah = 'N'");
	while($FDC = $getFullDayCalendar->fetch_assoc()) {
		$list .= $FDC['tanggal'] . ":";
	}
	$countFDC = count(array_filter(explode(":", $list)));

	#get direct_acc
	$getMyDirectAcc = $ki->query("select direct_acc from users where username = '".$_SESSION['fusn']."'");
	$MDA = $getMyDirectAcc->fetch_assoc();

	$ki->query("insert into inlieuoff_log (username,inputdate,type,startfrom,untilto,totaldate,escalateto,status)
				values('".$_SESSION['fusn']."',CURDATE(),'".$IL."','".date_format($starter,"Y/m/d")."','".date_format($ender,"Y/m/d")."',".$countFDC.",'".$MDA['direct_acc']."','DRAFT')");
	$_SESSION['ilinfo'] = 'Insert';

	#this dirty code just for testing purpose (because my system already error on header send)
	echo "<script>window.location.replace('offreq_lclaim.php');</script>";
	#header("Location: offreq_lclaim.php");

} elseif(isset($_GET)) {

	if(isset($_GET['approve'])) {
		#is the post is mean to your staff and you are the escalated one ?
		$getTheTruthBehind = $ki->query("select direct_acc,username from users where username = (select username from inlieuoff_log where id = ".$_GET['approve'].")");
		$TTB = $getTheTruthBehind->fetch_assoc();

		#and I want to know how much leave to give away, and type
		$getTotalDateRequest = $ki->query("select totaldate, type from inlieuoff_log where id = ".$_GET['approve']);
		$TDR = $getTotalDateRequest->fetch_assoc();

		#then check
		if($_SESSION['fusn'] == $TTB['direct_acc']) {
			#if true, the the truth has revealed a real good to you
			#but let us pick the right portion for you
			switch($TDR['type']){
				case 'sick': $ColSec = 'quota_sick'; break; case 'wed1': $ColSec = 'quota_wedding'; break; case 'wed2': $ColSec = 'quota_wedding2'; break; 
				case 'mate': $ColSec = 'quota_maternity'; break; case 'bles': $ColSec = 'quota_kidbless'; break; case 'dye1': $ColSec = 'quota_internaldecease'; break; 
				case 'dye2': $ColSec = 'quota_onehomedecease'; break;
			}
			
			$ki->query("update inlieuoff_log set status = 'APPROVED', approved_date = CURDATE() where id = ".$_GET['approve'].";");
			$ki->query("update cuti_quota set ".$ColSec." = ".$ColSec." + ".$TDR['totaldate']." where user = '".$TTB['username']."';");

			$_SESSION['ilinfo'] = 'Approve';
			echo "<script>window.location.replace('offreq_lclaim.php');</script>";
		}
	} elseif(isset($_GET['reject'])) {
		#is the post is mean to your staff and you are the escalated one ?
		$getTheTruthBehind = $ki->query("select direct_acc,username from users where username = (select username from inlieuoff_log where id = ".$_GET['reject'].")");
		$TTB = $getTheTruthBehind->fetch_assoc();

		#then check
		if($_SESSION['fusn'] == $TTB['direct_acc']) {
			#if true, the the truth has revealed a real good to you
			
			$ki->query("update inlieuoff_log set status = 'REJECTED', rejected_date = CURDATE() where id = ".$_GET['reject'].";");

			$_SESSION['ilinfo'] = 'Reject';
			echo "<script>window.location.replace('offreq_lclaim.php');</script>";
		}
	}
}

include "__footer.php";
?>