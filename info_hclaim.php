<?php
$module = array("title" => "Info Health Claim", "appname" => "HR");
include "__header.php";

#get username of this post
$getUserNameKS = $ki->query("select username from claim_kesehatan where username = '".$_SESSION['fusn']."'");
$UNKS = $getUserNameKS->fetch_assoc();


$owner = array(3,4,5,6,99);
if(in_array($_SESSION['fprv'], $owner) || $UNKS['username'] != NULL ) { } else { echo "<script>window.location.replace('view_hclaim.php');</script>"; } 

if(isset($_GET['no'])) {
	echo "<script>var nokey = '".$_GET['no']."';</script>";

	$getinfoHealthClaimData = $ki->query("select a.no_claim as no_claim, b.name as name, a.username as username, a.tgl_claim as tgl_claim, a.total_biaya as total_biaya, a.status_dok as status_dok, a.dokumen as dokumen, a.disetujui_oleh as disetujui_oleh, a.disetujui_tgl as disetujui_tgl, a.dibayar_oleh as dibayar_oleh, a.dibayar_tgl as dibayar_tgl, a.ditolak_oleh as ditolak_oleh, a.ditolak_tgl as ditolak_tgl, a.ditolak_note as ditolak_note from claim_kesehatan a inner join users b on a.username = b.username where a.no_claim = '".$_GET['no']."'");
	$infoHCD = $getinfoHealthClaimData->fetch_assoc();

	if($getinfoHealthClaimData->num_rows < 1) {
		header("Location: view_hclaim.php");
	}
}
?>

<div class='container-fluid'>

<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Health Claim</a></li>
		  <li><a href="#" onclick="window.location.href = 'admin_hclaim.php';">View</a></li>
		  <li class="active">Info</li>
		</ol>
	</div>
</div>

<div class='row'>

	<div class="col-md-10">

	<div class='row'>

		<div class="col-md-6">
			<div class="panel panel-<?php if($infoHCD['status_dok'] == 'DRAFT') { echo 'default'; } elseif($infoHCD['status_dok'] == 'APPROVED') { echo 'success'; } elseif($infoHCD['status_dok'] == 'REJECTED') { echo 'danger'; } elseif($infoHCD['status_dok'] == 'PAID') { echo 'warning'; } ?>">
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
				<div class="panel-heading">Total Value</div>
				<div class="panel-body">
					<center style='font-size: 16px'>
						<b>Rp <?= number_format($infoHCD['total_biaya']); ?></b>
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
				if($_SESSION['fusn'] == $infoHCD['username'] || $_SESSION['fprv'] == 5) {
					if($infoHCD['status_dok'] != 'DRAFT') { } else {
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-default' onclick='cancelDraft()'>Delete</a></span>";
					}
				}
				if($_SESSION['fprv'] == 5) {
					if($infoHCD['status_dok'] != 'DRAFT') { } else {
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-success' onclick='submitDraft()'>Approve</a></span>"; 
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-danger' onclick='prohibitDraft()'>Reject</a></span>";
					}
				}
				if($_SESSION['fprv'] == 3) {
					if($infoHCD['status_dok'] == 'APPROVED' && $infoHCD['dibayar_tgl'] == NULL) {
					echo "<span class='pull-right' style='padding-left: 5px'><a href='#' class='btn btn-sm btn-warning' onclick='payDraft()'>Make Payment</a></span>";
					}
				}
				?>
				</div>
				<div class="panel-body">
					<h4>Health Claim <small>Detail of Claim</small></h4>
					<table class='table' width='100%'>
					<tr>
						<td width='200px'>Claimant</td><td width='50px'>:</td><td style='text-align: left'><?= $infoHCD['name']; ?></td>
					</tr>
					<tr>
						<td width='200px'>Input Date</td><td width='50px'>:</td><td style='text-align: left'><?php $date = explode("-", $infoHCD['tgl_claim']); echo $date[2]."-".$date[1]."-".$date[0]; ?></td>
					</tr>
					</table>

					<br>

					<table class='table' width='100%'>
					<tr>
						<th>No.</th><th>Date</th><th>Claim</th><th>Total</th><th>Receipt?</th>
					</tr>
					<?php
					$numbering = 0;
					$getListOfClaims = $ki->query("select * from claim_kesehatan_detail where no_claim = '".$_GET['no']."'");
					while($LOC = $getListOfClaims->fetch_assoc()) {
						echo "<tr>";
						echo "<td>" . ++$numbering . "</td>";
						echo "<td>"; $date = explode("-", $LOC['tgl']); echo $date[2]."-".$date[1]."-".$date[0]; echo "</td>";
						echo "<td>" . $LOC['jenis_biaya'] . "</td>";
						echo "<td>" . number_format($LOC['jumlah']) . "</td>";
						echo "<td>"; switch($LOC['bon']){case 'Y': echo "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>"; break; case 'N': echo "<span class='glyphicon glyphicon-remove' aria-hidden='true'></span>"; break;} echo "</td>";
						echo "</tr>";
					}
					?>
					</table>

					<br>

					<div class='well well-sm'>
					<b>Notes :</b><br>
					<?php if($infoHCD['ditolak_note'] == NULL) { echo "--"; } else { echo $infoHCD['ditolak_note']; } ?>
					</div>
				</div>
			</div>
		</div>

	</div>

	</div>

	<div class="col-md-2">
		<div class="panel panel-primary">
			<div class="panel-heading">Document</div>
			<div class="panel-body">
				<center style='font-size: 16px'><a href="<?= $infoHCD['dokumen']; ?>" target='_blank'>View</a></center>
			</div>
		</div>

		<div class="panel panel-success">
			<div class="panel-heading">Approved?</div>
			<div class="panel-body">
				<center style='font-size: 16px'>
					<b><?php if($infoHCD['disetujui_tgl'] != NULL) { echo 'date: '; $date = explode("-", $infoHCD['disetujui_tgl']); echo $date[2]."-".$date[1]."-".$date[0]; } else { echo '--'; } ?></b>
				</center>
			</div>
		</div>

		<div class="panel panel-danger">
			<div class="panel-heading">Rejected?</div>
			<div class="panel-body">
				<center style='font-size: 16px'>
					<b><?php if($infoHCD['ditolak_tgl'] != NULL) { echo 'date: '; $date = explode("-", $infoHCD['ditolak_tgl']); echo $date[2]."-".$date[1]."-".$date[0]; } else { echo '--'; } ?></b>
				</center>
			</div>
		</div>

		<div class="panel panel-warning">
			<div class="panel-heading">Paid?</div>
			<div class="panel-body">
				<center style='font-size: 16px'>
					<b><?php if($infoHCD['dibayar_tgl'] != NULL) { echo 'date: '; $date = explode("-", $infoHCD['dibayar_tgl']); echo $date[2]."-".$date[1]."-".$date[0]; } else { echo '--'; } ?></b>
				</center>
			</div>
		</div>

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
	    window.location.href = 'action_hclaim.php?delete=' + nokey;
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
	    window.location.href = 'action_hclaim.php?approve=' + nokey;
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
	    window.location.href = 'action_hclaim.php?reject=' + nokey;
	  } else {
		    swal("Cancelled", "Rejection is cancelled :)", "error");
	  }
	});
}

function payDraft() {
	swal({
	  title: "Are you sure?",
	  text: "This gonna be check this as Paid Draft",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, I Already Paid!",
	  cancelButtonText: "No, Not Now!",
	  closeOnConfirm: false,
	  closeOnCancel: false
	},
	function(isConfirm){
	  if (isConfirm) {
	    window.location.href = 'actionpay_hclaim.php?pay=' + nokey;
	  } else {
		    swal("Cancelled", "Payment is cancelled :)", "error");
	  }
	});
}
</script>

<?php
include "__footer.php";
?>