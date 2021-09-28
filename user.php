<?php
$module = array("title" => "View Leave Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
  if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

$getUsersData = $ki->query("select * from users order by nik asc, status asc");
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
if(isset($_SESSION['lclaiminfo'])){
	switch($_SESSION['lclaiminfo']) {
		case 'NonActive':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Deleted.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
		case 'Active':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Approved.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
		case 'Insert':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['lclaiminfo_detail']."</a> Successfully Rejected.</div></div>";
		echo "</div>";
		unset($_SESSION['lclaiminfo']);
		unset($_SESSION['lclaiminfo_detail']);
		break;
	}
}
?>

<div class='row'>

	<div class="col-md-10">
	
	<div class='row'>
	<div class="col-md-12">
	<h3>Users Management</h3>
		<table id="users" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>NIK</th><th>Name</th><th>Occupation</th><th>Level</th><th>Department</th><th>Join Date</th><th>Status</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($UD = $getUsersData->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td><a href='info_user.php?no=" . $UD['nik'] . "'>" . $UD['nik'] . "</a></td><td>";
			if($UD['picture'] == NULL) {
				echo "<img src='dummy.png' width='16px' height='16px' title='".$UD['username']."'>";
			} else {
				echo "<img src='".$UD['picture']."' width='16px' height='16px' title='".$UD['username']."'>";
			}
			echo " " . $UD['name'] ;
			echo "</td><td>" . $UD['occupation'] . "</td>";
			echo "<td>" . $UD['level'] . "</td><td>" . $UD['department'] . "</td><td>" . $UD['joindate'] . "</td>";
			echo "<td>";
			switch($UD['status']){
				case 'active':
					echo "<span class='btn btn-xs btn-block btn-success'>Active</span>";
					break;
				case 'nonactive':
					echo "<span class='btn btn-xs btn-block btn-warning'>Non Active</span>";
					break;
			}
			echo "</td>";
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
			<div class="panel-heading">Staff</div>
			<div class="panel-body">
				<a href='input_users.php' class="btn btn-xg btn-block btn-primary">Add</a>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Update</div>
			<div class="panel-body">
				<a href='htable.php' class="btn btn-xg btn-block btn-warning">Update Health Quota</a>
				<a href='ltable.php' class="btn btn-xg btn-block btn-danger">Update Leave Quota</a>
				<a href='iltable.php' class="btn btn-xg btn-block btn-info">Update In Lieu Quota</a>
			</div>
		</div>
	</div>

</div>


</div>

<script>
$(document).ready(function() {
    $('#users').DataTable({
    	"dom": '<"top"i>rtf<"bottom"p><"clear">'
    });
} );
</script>

<?php
include "__footer.php";
?>