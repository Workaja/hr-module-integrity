<?php
$module = array("title" => "View Health Claim", "appname" => "HR");
include "__header.php";

$getInfoClaim = 
				$ki->query("select 
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."') as allhclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'DRAFT') as drafthclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'APPROVED') as approvedhclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'REJECTED') as rejectedhclaim");
$CInfo = $getInfoClaim->fetch_assoc();

$getTotalUsedClaim =
				$ki->query("select
				sum(total_biaya) as biaya from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok != 'REJECTED'");
$TUsed = $getTotalUsedClaim->fetch_assoc();

$getQuotaClaim =
				$ki->query("select
				sum(health) as quota from `limit` where username = '".$_SESSION['fusn']."'");
$QClm  = $getQuotaClaim->fetch_assoc();

$calRemainingBalance = (int) $QClm['quota'] - (int) $TUsed['biaya']; 

$getHealthClaimDataDraft = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_claim as tgl_claim, a.total_biaya as total_biaya, a.status_dok as status_dok, a.dokumen as dokumen from claim_kesehatan a inner join users b on a.username = b.username where a.username = '".$_SESSION['fusn']."' and a.status_dok = 'DRAFT' order by a.tgl_claim desc");

$getHealthClaimDataApproved = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_claim as tgl_claim, a.total_biaya as total_biaya, a.status_dok as status_dok, a.dokumen as dokumen from claim_kesehatan a inner join users b on a.username = b.username where a.username = '".$_SESSION['fusn']."' and a.status_dok = 'APPROVED' order by a.tgl_claim desc");

$getHealthClaimDataRejected = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_claim as tgl_claim, a.total_biaya as total_biaya, a.status_dok as status_dok, a.dokumen as dokumen from claim_kesehatan a inner join users b on a.username = b.username where a.username = '".$_SESSION['fusn']."' and a.status_dok = 'REJECTED' order by a.tgl_claim desc");

$getHealthClaimDataPaid = $ki->query("select a.no_claim as no_claim, b.name as name, a.tgl_claim as tgl_claim, a.total_biaya as total_biaya, a.status_dok as status_dok, a.dokumen as dokumen, a.dibayar_tgl from claim_kesehatan a inner join users b on a.username = b.username where a.username = '".$_SESSION['fusn']."' and a.status_dok = 'PAID' order by a.tgl_claim desc");
?>

<div class='container-fluid'>
<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Health Claim</a></li>
		  <li class="active">View</li>
		</ol>
	</div>
</div>

<?php
if(isset($_SESSION['hclaiminfo'])){
	switch($_SESSION['hclaiminfo']) {
		case 'Delete':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['hclaiminfo_detail']."</a> Successfully Deleted.</div></div>";
		echo "</div>";
		unset($_SESSION['hclaiminfo']);
		unset($_SESSION['hclaiminfo_detail']);
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
		<tr><th>No.</th><th>#Claim</th><th>Input Date</th><th>Total</th><th>Status</th><th>Doc</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($HCD = $getHealthClaimDataDraft->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_hclaim.php?no=" . $HCD['no_claim'] . "'>" . $HCD['no_claim'] . "</a></td><td>"; $date = explode("-", $HCD['tgl_claim']); echo $date[2]."-".$date[1]."-".$date[0]; echo "</td>";
			echo "<td>" . number_format($HCD['total_biaya']) . "</td><td>" . $HCD['status_dok'] . "</td><td><a href='";
			if($HCD['dokumen'] == NULL) { echo '#'; } else { echo $HCD['dokumen']; }
			echo "' target='_blank' class='btn btn-primary'>View</a></td>";
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
		<tr><th>No.</th><th>#Claim</th><th>Input Date</th><th>Total</th><th>Status</th><th>Doc</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($HCD = $getHealthClaimDataApproved->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_hclaim.php?no=" . $HCD['no_claim'] . "'>" . $HCD['no_claim'] . "</a></td><td>"; $date = explode("-", $HCD['tgl_claim']); echo $date[2]."-".$date[1]."-".$date[0]; echo "</td>";
			echo "<td>" . number_format($HCD['total_biaya']) . "</td><td>" . $HCD['status_dok'] . "</td><td><a href='";
			if($HCD['dokumen'] == NULL) { echo '#'; } else { echo $HCD['dokumen']; }
			echo "' target='_blank' class='btn btn-primary'>View</a></td>";
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
		<tr><th>No.</th><th>#Claim</th><th>Input Date</th><th>Total</th><th>Status</th><th>Doc</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($HCD = $getHealthClaimDataRejected->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_hclaim.php?no=" . $HCD['no_claim'] . "'>" . $HCD['no_claim'] . "</a></td><td>"; $date = explode("-", $HCD['tgl_claim']); echo $date[2]."-".$date[1]."-".$date[0]; echo "</td>";
			echo "<td>" . number_format($HCD['total_biaya']) . "</td><td>" . $HCD['status_dok'] . "</td><td><a href='";
			if($HCD['dokumen'] == NULL) { echo '#'; } else { echo $HCD['dokumen']; }
			echo "' target='_blank' class='btn btn-primary'>View</a></td>";
			echo "</tr>";
		}
		?>
		</tbody>
		</table>
	</div>
	</div>

	<div class='row'>
	<div class="col-md-12">
	<h3>PAID</h3>
		<table id="paid" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>#Claim</th><th>Input Date</th><th>Total</th><th>Status</th><th>Doc</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($HCD = $getHealthClaimDataPaid->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_hclaim.php?no=" . $HCD['no_claim'] . "'>" . $HCD['no_claim'] . "</a></td><td>"; $date = explode("-", $HCD['tgl_claim']); echo $date[2]."-".$date[1]."-".$date[0]; echo "</td>";
			echo "<td>" . number_format($HCD['total_biaya']) . "</td><td>" . $HCD['status_dok'] . "</td><td><a href='";
			if($HCD['dokumen'] == NULL) { echo '#'; } else { echo $HCD['dokumen']; }
			echo "' target='_blank' class='btn btn-primary'>View</a></td>";
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
				<center style='font-size: 16px'><b><?= $CInfo['allhclaim']; ?></b></center>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Draft Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['drafthclaim']; ?></b></center>
			</div>
		</div>
		<div class="panel panel-success">
			<div class="panel-heading">Approved Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['approvedhclaim']; ?></b></center>
			</div>
		</div>
		<div class="panel panel-danger">
			<div class="panel-heading">Rejected Claim</div>
			<div class="panel-body">
				<center style='font-size: 16px'><b><?= $CInfo['rejectedhclaim']; ?></b></center>
			</div>
		</div>
		<div class="panel panel-info">
			<div class="panel-heading">Balance</div>
			<div class="panel-body">
				<center style='font-size: 12px'><b>Rp <?= number_format($calRemainingBalance); ?></b></center>
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
    $('#paid').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
} );
</script>

<?php
include "__footer.php";
?>