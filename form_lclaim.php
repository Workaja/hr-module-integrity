<?php
$module = array("title" => "Dashboard", "appname" => "HR");
include "__header.php";

if($_POST['leave-type'] == NULL) { echo "<script>window.location.replace('leave_claim.php');</script>"; }

#getting data for statistics
$getLeaveStatisticsHere = $ki->query("select
									  (select ifnull(sum(quota_nonworkdaybefore),0) from cuti_quota where user = '".$_SESSION['fusn']."') - (select ifnull(sum(totaldate),0) as AC from cuti_log where user = '".$_SESSION['fusn']."' and status != 'REJECTED' and jenis_cuti = 1) as A,
									  (select ifnull(sum(quota_nonworkday),0) from cuti_quota where user = '".$_SESSION['fusn']."') - (select ifnull(sum(totaldate),0) as AC from cuti_log where user = '".$_SESSION['fusn']."' and status != 'REJECTED' and jenis_cuti = 2) as B,
									  (select ifnull(sum(quota_remainbefore),0) from cuti_quota where user = '".$_SESSION['fusn']."')  - (select ifnull(sum(totaldate),0) as AC from cuti_log where user = '".$_SESSION['fusn']."' and status != 'REJECTED' and jenis_cuti = 3) as C,
									  (select ifnull(sum(quota_cuti),0) from cuti_quota where user = '".$_SESSION['fusn']."')  - (select ifnull(sum(totaldate),0) as AC from cuti_log where user = '".$_SESSION['fusn']."' and status != 'REJECTED' and jenis_cuti = 4) as D
									  ");
$LSH = $getLeaveStatisticsHere->fetch_assoc();

#getting data from $_POST
switch($_POST['leave-type']){
	#1-4 can select days, 5-11 fix
	case 1: $LT = 'quota_nonworkdaybefore'; break; case 2: $LT = 'quota_nonworkday'; break; case 3: $LT = 'quota_remainbefore'; break;
	case 4: $LT = 'quota_cuti'; break;
	/////
	case 5: $LT = 'quota_sick'; break; case 6: $LT = 'quota_wedding'; break; case 7: $LT = 'quota_wedding2'; break; case 8: $LT = 'quota_kidbless'; break;
	case 9: $LT = 'quota_maternity'; break; case 10: $LT = 'quota_internaldecease'; break; case 11: $LT = 'quota_onehomedecease'; break;
}

$getMaxQuotaFromSelectedLeave = $ki->query("select (select ifnull(sum(".$LT."),0) as MQ from cuti_quota where user = '".$_SESSION['fusn']."') - (select ifnull(sum(totaldate),0) as AC from cuti_log where user = '".$_SESSION['fusn']."' and status != 'REJECTED' and jenis_cuti = ".$_POST['leave-type'].") as balance");
$MQSL = $getMaxQuotaFromSelectedLeave->fetch_assoc();
?>

<div class='container-fluid'>

	<div class='row'>
		<div class="col-md-12">
			<ol class="breadcrumb">
			  <li><a href="#">Leave Claim</a></li>
			  <li><a href="#" onclick="window.location.href = 'leave_claim.php';">Selection</a></li>
			  <li class="active">Form</li>
			</ol>
		</div>
	</div>

	<div class='row'>

		<div class='col-md-2'>
			<div class="panel panel-warning">
			  <div class="panel-heading">
			   Work Day Off Last Year
			  </div>
			  <div class="panel-body">
			  <?= $LSH['A']; ?>
			  </div>
			</div>
		</div>

		<div class='col-md-2'>
			<div class="panel panel-warning">
			  <div class="panel-heading">
			   Work Day Off This Year
			  </div>
			  <div class="panel-body">
			  <?= $LSH['B']; ?>
			  </div>
			</div>
		</div>

		<div class='col-md-2'>
			<div class="panel panel-warning">
			  <div class="panel-heading">
			   Remaining Last Year
			  </div>
			  <div class="panel-body">
			  <?= $LSH['C']; ?>
			  </div>
			</div>
		</div>

		<div class='col-md-2'>
			<div class="panel panel-warning">
			  <div class="panel-heading">
			   Remaining This Year
			  </div>
			  <div class="panel-body">
			  <?= $LSH['D']; ?>
			  </div>
			</div>
		</div>

		<div class='col-md-1'>
		</div>

		<div class='col-md-3'>
			<div class="panel panel-primary">
			  <div class="panel-heading">
			   Request Day Off ?
			  </div>
			  <div class="panel-body">
			  	<a href='#' class='btn btn-sm btn-primary btn-block' onclick='addDayOff()'>Add Here</a>
			  </div>
			</div>
		</div>

	</div>
	<?php
	#getting title from $_POST
	switch($_POST['leave-type']){
	#1-4 can select days, 5-11 fix
	case 1: $cLT = 'Work Day Off Last Year'; break; case 2: $cLT = 'Work Day Off This Year'; break; case 3: $cLT = 'Leave Remaining Last Year'; break;
	case 4: $cLT = 'Leave Remaining This Year'; break;
	/////
	case 5: $cLT = 'Sickness'; break; case 6: $cLT = 'Wedding'; break; case 7: $cLT = 'Held Wedding'; break; case 8: $cLT = 'Bless Kid (Khitan/Baptist)'; break;
	case 9: $cLT = 'Maternity'; break; case 10: $cLT = 'Internal Family Decease'; break; case 11: $cLT = 'Family Decease'; break;
	}
	?>

	<div class='row'>
		<div class='col-md-9'>
			<div class="panel panel-primary">
			  <div class="panel-heading">
			   <b>Leave Form : </b><?= $cLT; ?>
			  </div>
			  <div class="panel-body">
			  <form action="__add_lclaim.php" method="post">
			  	<table width="100%">
					<?php
					$typeA = array(1,2,3,4);
					if(in_array($_POST['leave-type'], $typeA)) {
						echo "<tr style='height: 50px; vertical-align: middle;'>";
						echo "<td width='200px'><label>Total Days To Leave</label></td>";
						echo "<td>:</td>";
						echo "<td><select name='TotalDays' id='TotalDays'>";
							for($x=0.5;$x<=$MQSL['balance'];$x+=0.5){
								echo "<option value='".$x."'>".$x." day(s)</option>";
							}
						echo "</select></td></tr>";
					} else {
						echo "<tr style='height: 50px; vertical-align: middle;'>";
						echo "<td width='200px'><label>Total Days To Leave</label></td>";
						echo "<td>:</td>";
						echo "<td><input type='text' name='TotalDays' id='TotalDays' value='".$MQSL['balance']."' readonly></td></tr>";
					}
					?>
					<tr style="height: 50px; vertical-align: middle;">
						<td><label>Start Leave Day</label></td><td>:</td>
						<td><input type="text" name='start-date' id='start-date' class='pick-date' readonly>
						<span style="padding-left: 5px">(<a href="#" onclick="checkDate()">Calculate Date</a>)</span></td>
					</tr>

					<tr style="height: 50px; vertical-align: middle;">
						<td><label>End Leave Day</label></td>
						<td>:</td>
						<td><input type="text" name='end-date' id='end-date' readonly></td>
					</tr>

					<tr style="height: 50px; vertical-align: middle;">
						<td><label>Emergency Contact</label></td>
						<td>:</td>
						<td><input type="text" name='emergency-contact'></td>
					</tr>
					</table>

					<div class='form-group'>
						<label for='leave-reason'>Leave Reason...</label>
						<textarea name='leave-reason' id='leave-reason' style="width: 100%;"></textarea>
					</div>
					<input type="hidden" name="type-leave" value="<?= $_POST['leave-type']; ?>">
					<input type='submit' class='btn btn-primary pull-right' value='Submit'>
				</form>
			  </div>
			</div>
		</div>

		<div class="col-md-3">
			<div class="panel panel-info">
			<div class="panel-heading">
			   Information
			  </div>
			  <div class="panel-body">
			  <p>Add Information Here<br>Such...
			  	<ul>
			  	<li>How To</li>
			  	<li>News Update</li>
			  	<li>Holiday</li>
			  	<li><i>Emergency</i> Situation about Working Days/Off</li>
			  	</ul>
			  	<br>
			  	<a href='#' class='btn btn-info pull-right'>Read More...</a>
			  </p>
			  </div>
			</div>
		</div>
	</div>

</div>

<script>
$( document ).ready(function() {
    $( ".pick-date" ).datepicker({
    	dateFormat: "dd-mm-yy"
    });
});

function checkDate() {
	$.post("check_lclaim.php",
	{
		totaldate: document.getElementById("TotalDays").value,
		fromdate:  document.getElementById("start-date").value
	},
	function(data){
		document.getElementById("end-date").value = data;
	});
}

function addDayOff() {
	swal({
	  title: "Moving...",
	  text: "You to Designated Form.",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, Create it!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'offreq_lclaim.php';
	  } else {
		    swal("Cancelled", "Transfer is cancelled :)", "error");
	  }
	});
}
</script>

<?php
include "__footer.php";
?>