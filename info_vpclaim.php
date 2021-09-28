<?php
$module = array("title" => "Info Variable Pay Claim", "appname" => "HR");
include "__header.php";

#get username of this post
$getUserNameVP = $ki->query("select a.user as user, b.direct_acc as direct_acc from lembur_log a inner join users b on a.user = b.username where a.no_claim = '".$_GET['no']."'");
$UNVP = $getUserNameVP->fetch_assoc();


$owner = array(4,5,6,99);
if(in_array($_SESSION['fprv'], $owner) || $UNVP['user'] != NULL || $UNVP['direct_acc'] == $_SESSION['fusn']) { } else { echo "<script>window.location.replace('admin_vpclaim.php');</script>"; } 

if(isset($_GET['no'])) {
	echo "<script>var nokey = '".$_GET['no']."';</script>";

	$getinfoVarPayClaimData = $ki->query("select a.no_claim as no_claim, b.name as name, a.user as user, a.tgl_input as tgl_input, a.total_date as total_date, a.status as status, a.tgl_start as tgl_start, a.tgl_end as tgl_end, a.jenis_lembur as jenis_lembur, a.dollar as dollar, a.escalated_to as escalated_to, a.approved_by as approved_by, a.approved_date as approved_date, a.rejected_by as rejected_by, a.rejected_date as rejected_date, c.name as input_by from lembur_log a inner join users b on a.user = b.username inner join users c on a.input_by = c.username where a.no_claim = '".$_GET['no']."'");
	$infoVPCD = $getinfoVarPayClaimData->fetch_assoc();

	if($getinfoVarPayClaimData->num_rows < 1) {
		echo "<script>window.location.replace('view_vpclaim.php');</script>";
	}
}
?>

<div class='container-fluid'>

<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Variable Pay Claim</a></li>
		  <li><a href="#" onclick="window.location.href = 'admin_vpclaim.php';">View</a></li>
		  <li class="active">Info</li>
		</ol>
	</div>
</div>

<div class='row'>

	<div class="col-md-10">

	<div class='row'>

		<div class="col-md-6">
			<div class="panel panel-<?php if($infoVPCD['status'] == 'DRAFT') { echo 'default'; } elseif($infoVPCD['status'] == 'APPROVED') { echo 'success'; } elseif($infoVPCD['status'] == 'REJECT') { echo 'danger'; } ?>">
				<div class="panel-heading">Claim #</div>
				<div class="panel-body">
					<center style='font-size: 16px'>
						<b><?= $_GET['no']; ?></b>
					</center>
				</div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">Variable Type</div>
				<div class="panel-body">
					<center style='font-size: 16px'>
					<?php
					switch($infoVPCD['jenis_lembur']){
						case 'luarkota': $jV = 'Luar Kota'; break; case 'luarnegeri': $jV = 'Luar Negeri'; break; case 'weekend': $jV = 'Weekend / Holiday'; break; 
						case 'doubleshift': $jV = '2 Shift'; break; case 'nightshift': $jV = '3rd Shift / Night'; break; 
					}
					?>
						<b><?= $jV; ?></b>
					</center>
				</div>
			</div>
		</div>

	</div>

	<div class='row'>

		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
				<span style='font-size: 19px'>Details</span>
				<?php
				if($_SESSION['fusn'] == $infoVPCD['user'] || $_SESSION['fprv'] == 5) {
					if($infoVPCD['status'] != 'DRAFT') { } else {
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-danger' onclick='cancelDraft()'>Delete</a></span>";
					}
				}
				if($_SESSION['fprv'] == 5) {
					if($infoVPCD['status'] != 'DRAFT') { } else {
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-primary' onclick='submitDraft()'>Approve</a></span>"; 
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-warning' onclick='prohibitDraft()'>Reject</a></span>";
					}
				}
				?>
				</div>
				<div class="panel-body">
					<h4>Variable Pay Claim <small>Detail of Claim</small></h4>
					<table class='table' width='100%'>
					<tr>
						<td width='200px'>Claimant</td><td width='50px'>:</td><td style='text-align: left'><?= $infoVPCD['name']; ?></td>
					</tr>
					<tr>
						<td width='200px'>Input Date</td><td width='50px'>:</td><td style='text-align: left'><?php 
						$iD = explode("-", $infoVPCD['tgl_input']); 
						echo $iD[2] . "-" . $iD[1] . "-" . $iD[0];
						?></td>
					</tr>
					<tr>
						<td width='200px'>Input By</td><td width='50px'>:</td><td style='text-align: left'><?= $infoVPCD['input_by']; ?></td>
					</tr>
					</table>

					<br>

					<table class='table' width='100%'>
					<tr>
						<th width="50px">No.</th><th>Date</th>
					</tr>
					<?php
					$numbering = 0;
					$getListOfDate = $ki->query("select tanggal from kalender where tanggal between '".$infoVPCD['tgl_start']."' and '".$infoVPCD['tgl_end']."'");
					while($LOC = $getListOfDate->fetch_assoc()) {
						echo "<tr>";
						echo "<td>" . ++$numbering . "</td>";
						echo "<td>"; 
						$iD = explode("-", $LOC['tanggal']); 
						echo $iD[2] . "-" . $iD[1] . "-" . $iD[0];
						echo "</td>";
						echo "</tr>";
					}
					?>
					</table>

				</div>
			</div>
		</div>

	</div>

	</div>

	<div class="col-md-2">

		<div class="panel panel-success">
			<div class="panel-heading">Approved?</div>
			<div class="panel-body">
				<center style='font-size: 16px'>
					<a href='#'><?php if($infoVPCD['approved_date'] != NULL) { echo 'SIGNED'; } else { echo 'NOT SIGN'; } ?></a>
					<br>
					<b>date: <?php $infoVPCD['approved_date']; ?></b>
				</center>
			</div>
		</div>

		<div class="panel panel-danger">
			<div class="panel-heading">Rejected?</div>
			<div class="panel-body">
				<center style='font-size: 16px'>
					<a href='#'><?php if($infoVPCD['rejected_date'] != NULL) { echo 'SIGNED'; } else { echo 'NOT SIGN'; } ?></a>
					<br>
					<b>date: <?= $infoVPCD['rejected_date']; ?></b>
				</center>
			</div>
		</div>

		<?php
		$arraySetDollar = array(5,6);
		if(in_array($_SESSION['fprv'],$arraySetDollar)){
			if($infoVPCD['jenis_lembur'] == 'luarnegeri') {
				if($infoVPCD['dollar'] == NULL) {
					echo "
					<div class='panel panel-default'>
						<div class='panel-heading'>Set Dollar</div>
						<div class='panel-body'>
							<center style='font-size: 16px'>
								<input type='text' id='set-dollar' class='form-control'><br>
								<input type='button' onclick='setDollar()' class='btn-default btn-sm btn btn-block' value='Set Current Dollar'>
							</center>
						</div>
					</div>
					";
				} else {
					echo "
					<div class='panel panel-default'>
						<div class='panel-heading'>Set Dollar (Change)</div>
						<div class='panel-body'>
							<center style='font-size: 16px'>
								<input type='text' id='set-dollar' class='form-control' placeholder='Current : ".$infoVPCD['dollar']."'><br>
								<input type='button' onclick='setDollar()' class='btn-default btn-sm btn btn-block' value='Update Dollar'>
							</center>
						</div>
					</div>
					";
				}
			}
		}
		?>

	</div>

</div>


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
	    window.location.href = 'action_vpclaim.php?delete=' + nokey;
	  } else {
		    swal("Cancelled", "Your Draft is safe :)", "error");
	  }
	});
}

function submitDraft() {
	swal({
	  title: "Are you sure?",
	  text: "This gonna be Approved by you",
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
	    window.location.href = 'action_vpclaim.php?approve=' + nokey;
	  } else {
		    swal("Cancelled", "Approval is cancelled :)", "error");
	  }
	});
}

function prohibitDraft() {
	swal({
	  title: "Are you sure?",
	  text: "This gonna be Reject the draft",
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
	    window.location.href = 'action_vpclaim.php?reject=' + nokey;
	  } else {
		    swal("Cancelled", "Rejection is cancelled :)", "error");
	  }
	});
}

function setDollar() {
	swal({
	  title: "Are you sure?",
	  text: "This gonna be change the USD Conversion!",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, change it!",
	  cancelButtonText: "No, cancel now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'action_vpclaim.php?change=' + nokey + '&conv=' + Number(document.getElementById("set-dollar").value);
	  } else {
		    swal("Cancelled", "Change is cancelled :)", "error");
	  }
	});
}

</script>

<?php
include "__footer.php";
?>