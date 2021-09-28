<?php
$module = array("title" => "Leave Claim Form", "appname" => "HR");
include "__header.php";

#stats health claim
$getInfoClaim = 
				$ki->query("select 
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."') as alllclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedlclaim,
				(select ifnull(sum(totaldate),0) from cuti_log where user = '".$_SESSION['fusn']."' and status = 'REJECT') as rejectedlclaim
				");
$CInfo = $getInfoClaim->fetch_assoc();
?>

<div class='container-fluid'>

<?php
if(isset($_SESSION['lclaiminfo'])){
	switch($_SESSION['lclaiminfo']) {
		case 'Success':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='info_lclaim.php' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Created.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
		case 'Failed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-danger' role='alert'>Request Failed. Please Try Again.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		break;
		case 'SuccLed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-warning' role='alert'>Claim Successfully Created, But File Not Uploaded.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		break;
	}
}
?>

<div class='row'>

<div class="col-md-8">
	<form action="form_lclaim.php" method="post">
		<div class="panel panel-default">
		  <div class="panel-heading">
		    <h3 class="panel-title">Leave Claim Form</h3>
		  </div>
		  <div class="panel-body">
			<div class="jumbotron">
				<h2>Pick Leave Type : </h2>
				<select class='form-control' name='leave-type' style='height: 80px; font-size: 16px'>
					<?php
					$getLeaveType = $ki->query("select id,jenis_cuti from cuti_jenis order by id asc");
					while($LT = $getLeaveType->fetch_assoc()){
						echo "<option value='".$LT['id']."'>".$LT['jenis_cuti']."</option>";
					}
					?>
				</select>
			</div>
			<input type='submit' class='btn btn-primary btn-bg pull-right' value='To Leave Form'>
		  </div>
		</div>
	</form>
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
				<td><?= $CInfo['alllclaim']; ?> days</td>
			</tr>
			<tr>
				<td>Draft Claim :</td>
				<td><?= $CInfo['draftlclaim']; ?> days</td>
			</tr>
			<tr>
				<td>Approved Claim :</td>
				<td><?= $CInfo['approvedlclaim']; ?> days</td>
			</tr>
			<tr>
				<td>Rejected Claim :</td>
				<td><?= $CInfo['rejectedlclaim']; ?> days</td>
			</tr>
		</tbody>
		</table>
	  </div>
	  <div class="panel-footer"><a href="view_lclaim.php" class="btn btn-block btn-primary">View My Claim</a></div>
	</div>
</div>

</div>

</div>

<script type="text/javascript">

$( document ).ready(function() {
    $( ".pick-date" ).datepicker({
    	dateFormat: "dd-mm-yy"
    });
});

</script>


<?php
include "__footer.php";
?>