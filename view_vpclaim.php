<?php
$module = array("title" => "View Variable Pay Claim", "appname" => "HR");
include "__header.php";

$getInfoClaim = 
				$ki->query("select 
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."') as allvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'REJECT') as rejectedvpclaim
				");
$CInfo = $getInfoClaim->fetch_assoc();

$getVarPayClaimDataDraft = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.total_date as total_date, a.status as status, a.tgl_start as tgl_start, a.tgl_end as tgl_end from lembur_log a inner join users b on a.user = b.username where a.status = 'DRAFT' and a.user = '".$_SESSION['fusn']."'");

$getVarPayClaimDataApproved = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.total_date as total_date, a.status as status, a.tgl_start as tgl_start, a.tgl_end as tgl_end from lembur_log a inner join users b on a.user = b.username where a.status = 'APPROVED' and a.user = '".$_SESSION['fusn']."'");

$getVarPayClaimDataRejected = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_input as tgl_input, a.total_date as total_date, a.status as status, a.tgl_start as tgl_start, a.tgl_end as tgl_end from lembur_log a inner join users b on a.user = b.username where a.status = 'REJECT' and a.user = '".$_SESSION['fusn']."'");
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
if(isset($_SESSION['vpclaiminfo'])){
	switch($_SESSION['vpclaiminfo']) {
		case 'Delete':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['vpclaiminfo_detail']."</a> Successfully Deleted.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		unset($_SESSION['vpclaiminfo_detail']);
		break;
		case 'Approve':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['vpclaiminfo_detail']."</a> Successfully Approved.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		unset($_SESSION['vpclaiminfo_detail']);
		break;
		case 'Reject':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['vpclaiminfo_detail']."</a> Successfully Rejected.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		unset($_SESSION['vpclaiminfo_detail']);
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
		while($VPCD = $getVarPayClaimDataDraft->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_vpclaim.php?no=" . $VPCD['no_claim'] . "'>" . $VPCD['no_claim'] . "</a></td><td>" . $VPCD['name'] . "</td><td>" . $VPCD['tgl_input'] . "</td>";
			echo "<td>" . $VPCD['total_date'] . "</td><td>" . $VPCD['tgl_start'] . "</td><td>" . $VPCD['tgl_end'] . "</td>";
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
		while($VPCD = $getVarPayClaimDataApproved->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_vpclaim.php?no=" . $VPCD['no_claim'] . "'>" . $VPCD['no_claim'] . "</a></td><td>" . $VPCD['name'] . "</td><td>" . $VPCD['tgl_input'] . "</td>";
			echo "<td>" . $VPCD['total_date'] . "</td><td>" . $VPCD['tgl_start'] . "</td><td>" . $VPCD['tgl_end'] . "</td>";
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
		while($VPCD = $getVarPayClaimDataRejected->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_vpclaim.php?no=" . $VPCD['no_claim'] . "'>" . $VPCD['no_claim'] . "</a></td><td>" . $VPCD['name'] . "</td><td>" . $VPCD['tgl_input'] . "</td>";
			echo "<td>" . $VPCD['total_date'] . "</td><td>" . $VPCD['tgl_start'] . "</td><td>" . $VPCD['tgl_end'] . "</td>";
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
				<center style='font-size: 16px'><b><?= $CInfo['allvpclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Draft Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['draftvpclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-heading">Approved Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['approvedvpclaim']; ?> days</b></center>
			</div>
		</div>
		<div class="panel panel-danger">
			<div class="panel-heading">Rejected Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['rejectedvpclaim']; ?> days</b></center>
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