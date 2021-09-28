<?php
$module = array("title" => "Health Claim Form", "appname" => "HR");
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

$getConfigurationData =
				$ki->query("select
					officemgr, hrmanager, activeyear from konfigurasi limit 1");
$Conf  = $getConfigurationData->fetch_assoc();
?>

<div class='container-fluid'>

<?php
if(isset($_SESSION['hclaiminfo'])){
	switch($_SESSION['hclaiminfo']) {
		case 'Success':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='info_hclaim.php?no=".$_SESSION['hclaiminfo_detail']."' class='alert-link'>".$_SESSION['hclaiminfo_detail']."</a> Successfully Created.</div></div>";
		echo "</div>";
		unset($_SESSION['hclaiminfo']);
		unset($_SESSION['hclaiminfo_detail']);
		break;
		case 'Failed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-danger' role='alert'>Request Failed. Please Try Again.</div></div>";
		echo "</div>";
		unset($_SESSION['hclaiminfo']);
		break;
		case 'SuccLed':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-warning' role='alert'>Claim Successfully Created, But File Not Uploaded.</div></div>";
		echo "</div>";
		unset($_SESSION['hclaiminfo']);
		break;
	}
}
?>

<div class='row'>

<div class="col-md-8">
	<form action="__add_hclaim.php" method="post" enctype="multipart/form-data">
		<div class="panel panel-default">
		  <div class="panel-heading">
		    <h3 class="panel-title">My Balance : Rp <?= number_format($calRemainingBalance); ?></h3>
		  </div>
		  <div class="panel-body">

			<table class="table">
				<thead>
					<tr><th>Date</th><th>Claim</th><th>Value</th><th>Receipt</th>
				</thead>

				<tbody>
					<?php
					for($i=1;$i<=8;$i++) {
						echo "<tr>";
						echo "<td><input type='text' name='date".$i."' placeholder='Pick Date' class='pick-date' readonly></td>";
						echo "<td><input type='text' name='claim".$i."' placeholder='Claim Name'></td>";
						echo "<td><input type='number' name='value".$i."' id='value".$i."' placeholder='Price' onclick='calcforme()' onblur='calcforme()' max='".$calRemainingBalance."'></td>";
						echo "<td><select name='receipt".$i."'><option value='N'>No</option><option value='Y'>Yes</option></select></td>";
						echo "</tr>";
					}
					?>
					<tr>
						<td></td>
						<td></td>
						<td style="vertical-align: middle"><b>Total : <a id="generateTotal" /></b></td>
						<td>
							<input type="hidden" name="payee" value="<?= $Conf['officemgr']; ?>">
							<input type="hidden" name="monitoredby" value="<?= $Conf['hrmanager']; ?>">
							<input type="hidden" name="directacc" value="">
							<input type="hidden" name="totalvalue" id="totalv" value="">
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<p style='font-size: 11px'><b>Required</b> (PNG,JPEG,GIF,JPG Only; Maximum 500KB)</p>
							<input type="file" name="fileToUpload" id="fileToUpload">
						</td>
					</tr>
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

</div>

</div>

<script type="text/javascript">

function calcforme() {
	var value1 = Number(document.getElementById("value1").value);
	var	value2 = Number(document.getElementById("value2").value);
	var	value3 = Number(document.getElementById("value3").value);
	var	value4 = Number(document.getElementById("value4").value);
	var	value5 = Number(document.getElementById("value5").value);
	var	value6 = Number(document.getElementById("value6").value);
	var	value7 = Number(document.getElementById("value7").value);
	var	value8 = Number(document.getElementById("value8").value);

	var totalv = "";

	totalv = value8 + value7 + value6 + value5 + value4 + value3 + value2 + value1;

	document.getElementById("generateTotal").innerHTML = totalv;
	document.getElementById("totalv").value = totalv;
}

$( document ).ready(function() {
    $( ".pick-date" ).datepicker({
    	dateFormat: "dd-mm-yy"
    });
});

</script>


<?php
include "__footer.php";
?>