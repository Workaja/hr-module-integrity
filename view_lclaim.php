<?php
$module = array("title" => "View Leave Claim", "appname" => "HR");
include "__header.php";

$getInfoClaim = 
				$ki->query("select 
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."') as alllclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'REJECTED') as rejectedlclaim");
$CInfo = $getInfoClaim->fetch_assoc();

$getLeaveClaimDataDraft = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.totaldate as totaldate, a.status as status, a.tgl_cuti_from as tgl_cuti_from, a.tgl_cuti_to from cuti_log a inner join users b on a.user = b.username where a.status = 'DRAFT' and a.user = '".$_SESSION['fusn']."'");

$getLeaveClaimDataApproved = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.totaldate as totaldate, a.status as status, a.tgl_cuti_from as tgl_cuti_from, a.tgl_cuti_to from cuti_log a inner join users b on a.user = b.username where a.status = 'APPROVED' and a.user = '".$_SESSION['fusn']."'");

$getLeaveClaimDataRejected = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.totaldate as totaldate, a.status as status, a.tgl_cuti_from as tgl_cuti_from, a.tgl_cuti_to from cuti_log a inner join users b on a.user = b.username where a.status = 'REJECTED' and a.user = '".$_SESSION['fusn']."'");
?>

<div class='container-fluid'>
<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Leave Claim</a></li>
		  <li class="active">View</li>
		</ol>
	</div>
</div>

<?php
if(isset($_SESSION['lclaiminfo'])){
	switch($_SESSION['lclaiminfo']) {
		case 'Delete':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Deleted.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
		case 'Approve':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Approved.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
		case 'Reject':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Rejected.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
	}
}
?>

<div class='row'>

	<div class="col-md-10">
	
	<div class='row'>
	<div class="col-md-12">
	<h3>DRAFT</h3>
		<table id="draft" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>#Claim</th><th>Claimant</th><th>Input Date</th><th>Total</th><th>Start</th><th>End</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($LCD = $getLeaveClaimDataDraft->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_lclaim.php?no=" . $LCD['no_claim'] . "'>" . $LCD['no_claim'] . "</a></td><td>" . $LCD['name'] . "</td><td>" . $LCD['tgl_input'] . "</td>";
			echo "<td>" . $LCD['totaldate'] . "</td><td>" . $LCD['tgl_cuti_from'] . "</td><td>" . $LCD['tgl_cuti_to'] . "</td>";
			echo "</tr>";
		}
		?>
		</tbody>
		</table>
	</div>
	</div>

	<div class='row'>
	<div class="col-md-12">
	<h3>APPROVED</h3>
		<table id="approved" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>#Claim</th><th>Claimant</th><th>Input Date</th><th>Total</th><th>Start</th><th>End</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($LCD = $getLeaveClaimDataApproved->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_lclaim.php?no=" . $LCD['no_claim'] . "'>" . $LCD['no_claim'] . "</a></td><td>" . $LCD['name'] . "</td><td>" . $LCD['tgl_input'] . "</td>";
			echo "<td>" . $LCD['totaldate'] . "</td><td>" . $LCD['tgl_cuti_from'] . "</td><td>" . $LCD['tgl_cuti_to'] . "</td>";
			echo "</tr>";
		}
		?>
		</tbody>
		</table>
	</div>
	</div>

	<div class='row'>
	<div class="col-md-12">
	<h3>REJECTED</h3>
		<table id="rejected" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>#Claim</th><th>Claimant</th><th>Input Date</th><th>Total</th><th>Start</th><th>End</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($LCD = $getLeaveClaimDataRejected->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_lclaim.php?no=" . $LCD['no_claim'] . "'>" . $LCD['no_claim'] . "</a></td><td>" . $LCD['name'] . "</td><td>" . $LCD['tgl_input'] . "</td>";
			echo "<td>" . $LCD['totaldate'] . "</td><td>" . $LCD['tgl_cuti_from'] . "</td><td>" . $LCD['tgl_cuti_to'] . "</td>";
			echo "</tr>";
		}
		?>
		</tbody>
		</table>
	</div>
	</div>

	</div>

	<div class="col-md-2">
		<div class="panel panel-primary">
			<div class="panel-heading">All Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['alllclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Draft Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['draftlclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-heading">Approved Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['approvedlclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-danger">
			<div class="panel-heading">Rejected Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['rejectedlclaim']; ?> days</b></center>
			</div>
		</div>
	</div>

</div>


</div>

<script>
$(document).ready(function() {
    $('#draft').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
    $('#approved').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
    $('#rejected').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
} );
</script>

<?php
include "__footer.php";
?>