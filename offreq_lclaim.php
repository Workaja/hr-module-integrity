<?php
$module = array("title" => "Leave Request Form", "appname" => "HR");
include "__header.php";
?>

<div class='container-fluid'>

<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Other</a></li>
		  <li class="active">In Lieu</li>
		</ol>
	</div>
</div>

<?php
if(isset($_SESSION['ilinfo'])){
	switch($_SESSION['ilinfo']) {
		case 'Insert':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'>Request Successfully Created.</div></div>";
		echo "</div>";
		unset($_SESSION['ilinfo']);
		break;
		case 'Approve':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'>Request Successfully Approved.</div></div>";
		echo "</div>";
		unset($_SESSION['ilinfo']);
		break;
		case 'Reject':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'>Request Successfully Rejected.</div></div>";
		echo "</div>";
		unset($_SESSION['ilinfo']);
		break;
	}
}
?>

<div class='row'>

<div class='col-md-9'>

<div class="panel panel-default">
  <div class="panel-heading">Request Off (in lieu)</div>
  <div class="panel-body">
	<form method="post" action="action_offreq.php">
		<div class="form-group">
			<label for="LeaveType">Leave Type</label>
			<select class='form-control' id='LeaveType' name='LeaveType'>
			<?php
			$getLeaveTypeSixtoEleven = $ki->query("select id,jenis_cuti from cuti_jenis where id between 5 and 11");
			while($LTSE = $getLeaveTypeSixtoEleven->fetch_assoc()){
				echo "<option value='".$LTSE['id']."'>".$LTSE['jenis_cuti']."</option>";
			}
			?>
			</select>
		</div>
		<div class="form-group">
			<label for="StartDate">Start Date</label>
			<input type="text" class="form-control pick-date" id="StartDate" name="StartDate" readonly>
		</div>
		<div class="form-group">
			<label for="EndDate">End Date</label>
			<input type="text" class="form-control pick-date" id="EndDate" name="EndDate" readonly>
		</div>
		<button type="submit" class="btn btn-default btn-primary pull-right">Submit</button>
	</form>
  </div>
</div>

</div>

<div class='col-md-3'>

<div class="panel panel-default">
  <div class="panel-heading">Current Quota :</div>
  <div class="panel-body">
    <?php
    $getInLieuQuota = $ki->query("select
    					(select ifnull(sum(quota_sick),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_sick,
    					(select ifnull(sum(quota_wedding),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_wed1,
    					(select ifnull(sum(quota_wedding2),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_wed2,
    					(select ifnull(sum(quota_kidbless),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_khit,
    					(select ifnull(sum(quota_maternity),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_mtrn,
    					(select ifnull(sum(quota_internaldecease),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_dye1,
    					(select ifnull(sum(quota_onehomedecease),0) from cuti_quota where user = '".$_SESSION['fusn']."') as q_dye2
    					");
    $ILQ = $getInLieuQuota->fetch_assoc();
    ?>
    <table class="table" width="100%">
    <tr><td>Sickness</td><td><?= $ILQ['q_sick']; ?></td></tr>
    <tr><td>Wedding</td><td><?= $ILQ['q_wed1']; ?></td></tr>
    <tr><td>Held Wedding</td><td><?= $ILQ['q_wed2']; ?></td></tr>
    <tr><td>Khitan / Baptist</td><td><?= $ILQ['q_khit']; ?></td></tr>
    <tr><td>Maternity</td><td><?= $ILQ['q_mtrn']; ?></td></tr>
    <tr><td>Internal Family Decease</td><td><?= $ILQ['q_dye1']; ?></td></tr>
    <tr><td>Family Decease</td><td><?= $ILQ['q_dye2']; ?></td></tr>
    </table>
  </div>
</div>

</div>
</div>

<div class="row">

<div class="col-md-6">
<h4>My Request</h4>
	<table class='table' width="100%" id="personal">
	<thead>
		<tr><th>No.</th><th>Type</th><th>Start</th><th>End</th></tr>
	</thead>
	<tbody>
		<?php
		$numbering = 0;
		$getMyInlieuRequest = $ki->query("select * from inlieuoff_log where username = '".$_SESSION['fusn']."' and status = 'DRAFT'");
		while($MILR = $getMyInlieuRequest->fetch_assoc()){
			$startfrom = new DateTime($MILR['startfrom']);
			$untilto   = new DateTime($MILR['untilto']);
			echo "<tr><td>".++$numbering."</td><td>".$MILR['type']."</td><td>".date_format($startfrom,"d-m-Y")."</td><td>".date_format($untilto,"d-m-Y")."</td></tr>";
		}
		?>
	</tbody>
	</table>

</div>

<div class="col-md-6">
<h4>My Staff Request</h4>
	<table class='table' width="100%" id="group">
	<thead>
		<tr><th>No.</th><th>Requester</th><th>Type</th><th>Start</th><th>End</th><th>Action</th></tr>
	</thead>
	<tbody>
		<?php
		$numbering = 0;
		$getMyInlieuRequest = $ki->query("select * from inlieuoff_log where username in (select username from users where direct_acc = '".$_SESSION['fusn']."') and status = 'DRAFT'");
		while($MILR = $getMyInlieuRequest->fetch_assoc()){
			$startfrom = new DateTime($MILR['startfrom']);
			$untilto   = new DateTime($MILR['untilto']);
			echo "<tr><td>".++$numbering."</td><td>".$MILR['username']."</td><td>".$MILR['type']."</td><td>".date_format($startfrom,"d-m-Y")."</td><td>".date_format($untilto,"d-m-Y")."</td><td><a href=# class='btn btn-success' onclick='approveThis(".$MILR['id'].")' title='Approve This'>A</a> <a href=# class='btn btn-danger pull-right' onclick='rejectThis(".$MILR['id'].")' title='Reject This'>X</a></tr>";
		}
		?>
	</tbody>
	</table>

</div>


</div>

</div>

</div>

<script>
function approveThis(nokey) {
	swal({
	  title: "do You want to?",
	  text: "Approve this mean to give your staff off day quota.",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, Give Em!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_offreq.php?approve=' + nokey;
	  } else {
		    swal("Cancelled", "I know, your Staff must Work :)", "error");
	  }
	});
}

function rejectThis(nokey) {
	swal({
	  title: "do You want to?",
	  text: "Reject this mean to leave your staff keep on work.",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, Tell Em!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_offreq.php?reject=' + nokey;
	  } else {
		    swal("Cancelled", "I know, your are nice leader :)", "error");
	  }
	});
}

$( document ).ready(function() {
    $( ".pick-date" ).datepicker({
    	dateFormat: "dd-mm-yy"
    });

    $('#personal').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
    $('#group').DataTable({
    	"dom": '<"top"i>rt<"bottom"p><"clear">'
    });
} );
</script>

<?php
include "__footer.php";
?>