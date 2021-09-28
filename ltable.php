<?php
$module = array("title" => "Leave Claim Management", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

$getUsersDataQuota = $ki->query("select a.nik as nik, a.user as username, b.name as name, b.occupation as occupation, b.level as level, b.department as department, a.quota_cuti as quota_cuti, a.quota_remainbefore as remainbefore, a.quota_nonworkday as nonworkday, a.quota_nonworkdaybefore as nonworkdaybefore, b.picture as picture from cuti_quota a inner join users b on a.user = b.username order by a.nik asc, b.status asc");
?>

<div class='container-fluid'>
<div class='row'>
	<div class="col-md-12">
		<ol class="breadcrumb">
		  <li><a href="#">Leave Claim</a></li>
		  <li class="active">Management</li>
		</ol>
	</div>
</div>

<?php
if(isset($_SESSION['llimit'])){
	switch($_SESSION['llimit']) {
		case 'Update':
		echo "<div class='row'>";
		echo "<div class='col-md-12'><div class='alert alert-success' role='alert'>Updated Successfuly.</div></div>";
		echo "</div>";
		unset($_SESSION['llimit']);
		break;
	}
}
?>

<div class='row'>

	<div class="col-md-10">
	
	<div class='row'>
	<form action="ltable_action.php" method="post">
	<div class="col-md-12">
	<h3>Leave Claim Management <small>TY: This Year, LY: Last Year, NW: Non Working Day</small></h3>
		<table id="ltable" class="table table-striped table-bordered" cellspacing="0" width="100%">
		<thead>
		<tr><th>No.</th><th>NIK</th><th>Name</th><th>Occupation</th><th>Level</th><th>Department</th><th>Leave TY Quota</th><th>Leave LY Quota</th><th>Leave NW</th><th>Leave LY NW</th></tr>
		</thead>
		<tbody>
		<?php
		$numbering = 0;
		while($UDQ= $getUsersDataQuota->fetch_assoc()){
			echo "<tr>";
			echo "<td>" . ++$numbering . "</td><td>" . $UDQ['nik'] . "</td><td>";
			if($UDQ['picture'] == NULL) {
				echo "<img src='dummy.png' width='16px' height='16px' title='".$UDQ['username']."'>";
			} else {
				echo "<img src='".$UDQ['picture']."' width='16px' height='16px' title='".$UDQ['username']."'>";
			}
			echo " " . $UDQ['name'] ;
			echo "</td><td>" . $UDQ['occupation'] . "</td>";
			echo "<td>" . $UDQ['level'] . "</td><td>" . $UDQ['department'] . "</td>";
			echo "<td>";
			echo "<input type='number' class='form-control' name='LTY_".$UDQ['username']."' value='".$UDQ['quota_cuti']."'>";
			echo "</td>";
			echo "<td>";
			echo "<input type='number' class='form-control' name='LLY_".$UDQ['username']."' value='".$UDQ['remainbefore']."'>";
			echo "</td>";
			echo "<td>";
			echo "<input type='number' class='form-control' name='LNW_".$UDQ['username']."' value='".$UDQ['nonworkday']."'>";
			echo "</td>";
			echo "<td>";
			echo "<input type='number' class='form-control' name='LLW_".$UDQ['username']."' value='".$UDQ['nonworkdaybefore']."'>";
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
			<div class="panel-heading">Click Here to Update</div>
			<div class="panel-body">
				<input type="submit" class="btn btn-primary btn-block" value="Update Quota">
			</div>
		</div>
	</form>
		<div class="panel panel-default">
			<div class="panel-heading">Update</div>
			<div class="panel-body">
				<a href='htable.php' class="btn btn-xg btn-block btn-warning">Update Health Quota</a>
				<a href='ltable.php' class="btn btn-xg btn-block btn-danger">Update Leave Quota</a>
				<a href='iltable.php' class="btn btn-xg btn-block btn-info">Update In Lieu Quota</a>
				<a href='user.php' class="btn btn-xg btn-block btn-success">Back to User Mgt.</a>
			</div>
		</div>
	</div>

</div>


</div>

<?php
include "__footer.php";
?>