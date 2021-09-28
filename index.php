<?php
$module = array("title" => "Dashboard", "appname" => "HR");
include "__header.php";

#stats health claim
$getInfoClaim = 
				$ki->query("select 
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."') as allhclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'DRAFT') as drafthclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'APPROVED') as approvedhclaim,
				(select count(*) from claim_kesehatan where username = '".$_SESSION['fusn']."' and status_dok = 'REJECTED') as rejectedhclaim,

				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."') as alllclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'REJECT') as rejectedlclaim,

				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."') as allvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'REJECT') as rejectedvpclaim
				");
$CInfo = $getInfoClaim->fetch_assoc();
?>

<div class='container-fluid'>

<div class="alert alert-success" role="alert">Welcome to Intranet HR Module</div>

<div class='row'>

<div class="col-md-4">
	<div class="panel panel-default">
	  <div class="panel-heading">
	    <h3 class="panel-title">Statistics Health Claim</h3>
	  </div>
	  <div class="panel-body">
		<table class="table">
		<thead><tr><th>Description</th><th>Total</th></tr></thead>
		<tbody>
			<tr>
				<td>All Claim :</td>
				<td><?= $CInfo['allhclaim']; ?></td>
			</tr>
			<tr>
				<td>Draft Claim :</td>
				<td><?= $CInfo['drafthclaim']; ?></td>
			</tr>
			<tr>
				<td>Approved Claim :</td>
				<td><?= $CInfo['approvedhclaim']; ?></td>
			</tr>
			<tr>
				<td>Rejected Claim :</td>
				<td><?= $CInfo['rejectedhclaim']; ?></td>
			</tr>
		</tbody>
		</table>
	  </div>
	  <div class="panel-footer"><a href="view_hclaim.php" class="btn btn-block btn-primary">View My Claim</a></div>
	</div>
</div>

<div class="col-md-4">
	<div class="panel panel-default">
	  <div class="panel-heading">
	    <h3 class="panel-title">Statistics Leave Claim</h3>
	  </div>
	  <div class="panel-body">
		<table class="table">
		<thead><tr><th>Description</th><th>Total</th></tr></thead>
		<tbody>
			<tr>
				<td>All Claim :</td>
				<td><?= $CInfo['alllclaim']; ?></td>
			</tr>
			<tr>
				<td>Draft Claim :</td>
				<td><?= $CInfo['draftlclaim']; ?></td>
			</tr>
			<tr>
				<td>Approved Claim :</td>
				<td><?= $CInfo['approvedlclaim']; ?></td>
			</tr>
			<tr>
				<td>Rejected Claim :</td>
				<td><?= $CInfo['rejectedlclaim']; ?></td>
			</tr>
		</tbody>
		</table>
	  </div>
	  <div class="panel-footer"><a href="view_lclaim.php" class="btn btn-block btn-primary">View My Claim</a></div>
	</div>
</div>

<div class="col-md-4">
	<div class="panel panel-default">
	  <div class="panel-heading">
	    <h3 class="panel-title">Statistics Variable Pay Claim</h3>
	  </div>
	  <div class="panel-body">
		<table class="table">
		<thead><tr><th>Description</th><th>Total</th></tr></thead>
		<tbody>
			<tr>
				<td>All Claim :</td>
				<td><?= $CInfo['allvpclaim']; ?></td>
			</tr>
			<tr>
				<td>Draft Claim :</td>
				<td><?= $CInfo['draftvpclaim']; ?></td>
			</tr>
			<tr>
				<td>Approved Claim :</td>
				<td><?= $CInfo['approvedvpclaim']; ?></td>
			</tr>
			<tr>
				<td>Rejected Claim :</td>
				<td><?= $CInfo['rejectedvpclaim']; ?></td>
			</tr>
		</tbody>
		</table>
	  </div>
	  <div class="panel-footer"><a href="view_vpclaim.php" class="btn btn-block btn-primary">View My Claim</a></div>
	</div>
</div>

</div>

</div>

<?php
include "__footer.php";
?>