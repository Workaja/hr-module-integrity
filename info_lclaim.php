<?php
$module = array("title" => "Info Leave Claim", "appname" => "HR");
include "__header.php";

#get username of this post
$getUserNameLV = $ki->query("select a.user as user, b.direct_acc from cuti_log a inner join users b on a.user = b.username where a.no_claim = '".$_GET['no']."'");
$UNLV = $getUserNameLV->fetch_assoc();

if($UNLV['user'] == $_SESSION['fusn'] || $UNLV['direct_acc'] == $_SESSION['fusn']) { } else { echo "<script>window.location.replace('view_lclaim.php');</script>"; } 

if(isset($_GET['no'])) {
	echo "<script>var nokey = '".$_GET['no']."';</script>";

	$getinfoLeaveClaimData = $ki->query("select a.no_claim as no_claim, b.name as name, a.user as user, a.tgl_input as tgl_input, a.totaldate as totaldate, a.status as status, a.tgl_cuti_from as tgl_cuti_from, a.tgl_cuti_to as tgl_cuti_to, a.jenis_cuti as jenis_cuti, a.emergency as emergency, a.note as note, a.escalated_to as escalated_to, a.approved_by as approved_by, a.approved_date as approved_date, a.rejected_by as rejected_by, a.rejected_date as rejected_date from cuti_log a inner join users b on a.user = b.username where a.no_claim = '".$_GET['no']."'");
	$infoLCD = $getinfoLeaveClaimData->fetch_assoc();

	if($getinfoLeaveClaimData->num_rows < 1) {
		echo "<script>window.location.replace('view_lclaim.php');</script>";
	}
}
?>

<div class='container-fluid'>

<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Leave Claim</a></li>
		  <li><a href="#" onclick="window.location.href = 'admin_lclaim.php';">View</a></li>
		  <li class="active">Info</li>
		</ol>
	</div>
</div>

<div class='row'>
<div class='col-md-6'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">#Claim</h3>
		</div>
		<div class="panel-body">
		<center style='font-size: 26px'><?= $infoLCD['no_claim']; ?></center>
		</div>
	</div>
</div>
<div class='col-md-6'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Status</h3>
		</div>
		<div class="panel-body">
		<center style='font-size: 26px'><?= $infoLCD['status']; ?></center>
		</div>
	</div>
</div>
</div>

<div class='row'>
<div class='col-md-3'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Claimant</h3>
		</div>
		<div class="panel-body">
		<span style='font-size: 14px'><?= $infoLCD['name']; ?></span>
		</div>
	</div>
</div>
<div class='col-md-2'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Input Date</h3>
		</div>
		<div class="panel-body">
		<span style='font-size: 16px'><?= $infoLCD['tgl_input']; ?></span>
		</div>
	</div>
</div>
<div class='col-md-3'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Start Leave Date</h3>
		</div>
		<div class="panel-body">
		<span style='font-size: 16px'><?= $infoLCD['tgl_cuti_from']; ?></span>
		</div>
	</div>
</div>
<div class='col-md-3'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">End Leave Date</h3>
		</div>
		<div class="panel-body">
		<span style='font-size: 16px'><?= $infoLCD['tgl_cuti_to']; ?></span>
		</div>
	</div>
</div>
<div class='col-md-1'>
	<div class="panel panel-default">
		<div class="panel-heading">
		<h3 class="panel-title">Days</h3>
		</div>
		<div class="panel-body">
		<center><span style='font-size: 16px'><?= $infoLCD['totaldate']; ?></span></center>
		</div>
	</div>
</div>
</div>

<div class='row'>
<div class='col-md-6'>
	<div class="panel panel-success">
		<div class="panel-heading">
		<h3 class="panel-title">Approved?</h3>
		</div>
		<div class="panel-body">
		<center style='font-size: 22px'>
			<a><?php if($infoLCD['approved_date'] == NULL) { echo 'NO SIGN'; } else { echo $infoLCD['approved_by']; } ?></a>
			<br>
			date : <?= $infoLCD['approved_date']; ?>
		</center>
		</div>
	</div>
</div>
<div class='col-md-6'>
	<div class="panel panel-danger">
		<div class="panel-heading">
		<h3 class="panel-title">Rejected?</h3>
		</div>
		<div class="panel-body">
		<center style='font-size: 22px'>
			<a><?php if($infoLCD['rejected_date'] == NULL) { echo 'NO SIGN'; } else { echo $infoLCD['rejected_by']; } ?></a>
			<br>
			date : <?= $infoLCD['rejected_date']; ?>
		</center>
		</div>
	</div>
</div>
</div>

<div class='row'>
<?php
if($infoLCD['escalated_to'] == $_SESSION['fusn'] && $infoLCD['status'] == 'DRAFT') {
	echo "
	<div class='col-md-4'>
		<div class='panel panel-default'>
			<input type='button' class='btn btn-success btn-bg btn-block' value='Approve' onclick='approveDraft()'>
		</div>
	</div>
	<div class='col-md-4'>
		<div class='panel panel-default'>
			<input type='button' class='btn btn-danger btn-bg btn-block' value='Reject' onclick='rejectDraft()'>
		</div>
	</div>";
} 
if($infoLCD['user'] == $_SESSION['fusn'] && $infoLCD['status'] == 'DRAFT') {
	echo "
	<div class='col-md-8'></div>
	<div class='col-md-4'>
		<div class='panel panel-default'>
			<input type='button' class='btn btn-bg btn-block' value='Delete' onclick='cancelDraft()'>
		</div>
	</div>";
}
?>
</div>

<script>
function cancelDraft() {
	swal({
	  title: "Are you sure?",
	  text: "You will not be able to recover this Draft!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, delete it!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_lclaim.php?delete=' + nokey;
	  } else {
		    swal("Cancelled", "Your Draft is safe :)", "error");
	  }
	});
}

function approveDraft() {
	swal({
	  title: "Are you sure?",
	  text: "You will Approve this Draft!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, Approve it!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_lclaim.php?approve=' + nokey;
	  } else {
		    swal("Cancelled", "Your Draft is still draft :)", "error");
	  }
	});
}

function rejectDraft() {
	swal({
	  title: "Are you sure?",
	  text: "You will Reject this Draft!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, Reject it!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_lclaim.php?reject=' + nokey;
	  } else {
		    swal("Cancelled", "Your Draft is still draft :)", "error");
	  }
	});
}
</script>



<?php
include "__footer.php";
?>