<?php
$module = array("title" => "Variable Pay Claim Form", "appname" => "HR");
include "__header.php";
$getInfoClaim = 
				$ki->query("select 
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."') as allvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'DRAFT') as draftvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'APPROVED') as approvedvpclaim,
				(select ifnull(sum(total_date),0) from lembur_log where user = '".$_SESSION['fusn']."' and status = 'REJECTED') as rejectedvpclaim");
$CInfo = $getInfoClaim->fetch_assoc();
?>

<div class='container-fluid'>

<?php
if(isset($_SESSION['vpclaiminfo'])){
	switch($_SESSION['vpclaiminfo']) {
		case 'Success':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='info_vpclaim.php?no=".$_SESSION['vpclaiminfo_detail']."' class='alert-link'>".$_SESSION['vpclaiminfo_detail']."</a> Successfully Created.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		unset($_SESSION['vpclaiminfo_detail']);
		break;
		case 'Failed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-danger' role='alert'>Request Failed. Please Try Again.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		break;
		case 'SuccLed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-warning' role='alert'>Claim Successfully Created, But File Not Uploaded.</div></div>";
		echo "</div>";
		unset($_SESSION['vpclaiminfo']);
		break;
	}
}
?>

<div class='row'>

<div class="col-md-8">
	<form action="__add_vpclaim.php" method="post">
		<div class="panel panel-default">
		  <div class="panel-heading">
		    <h3 class="panel-title">Variable Pay Form</h3>
		  </div>
		  <div class="panel-body">

			<table class="table">
				<thead>
					<tr>
						<td width="200px"><label>Name</label></td><td width="20px">:</td>
						<td>
						<select name="variable-user" style="width: 350px">
						<?php
						$getListUserName = $ki->query("select name,nik,username from users order by nik asc");
						while($LUN = $getListUserName->fetch_assoc()){
							echo "<option value='".$LUN['username']."'>[".$LUN['nik']."] ".$LUN['name']."</option>";
						}
						?>
						</select>
						</td>
					</tr>
					<tr>
						<td width="200px"><label>Variable</label></td><td width="20px">:</td>
						<td><select name="variable-type" style="width: 350px">
							<option value="luarkota">Luar Kota</option>
							<option value="luarnegeri">Luar Negeri</option>
							<option value="weekend">Weekend / Holiday Shift</option>
							<option value="doubleshift">2 Shift</option>
							<option value="nightshift">Night Shift</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label>Start Date/Night</label></td><td>:</td>
						<td><input type="text" name="start-date" class="pick-date" style="width: 350px"></td>
					</tr>
					<tr>
						<td><label>End Date/Night</label></td><td>:</td>
						<td><input type="text" name="end-date" class="pick-date" style="width: 350px"></td>
					</tr>
				</thead>

				<tbody>
					
				</tbody>
			</table>

		  </div>
		  <div class="panel-footer" style="height: 55px">
		  	<input type="submit" class="btn btn-primary pull-right" value="Submit">
		  </div>
		</div>
	</form>
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