<?php
$module = array("title" => "Change Password", "appname" => "HR");
include "__header.php";
?>

<div class='container-fluid'>

<?php
if(isset($_SESSION['passwordinfo'])){
	switch($_SESSION['passwordinfo']) {
		case 'notmatch':
		echo "<div class='row'>";
		echo "<div class='col-md-4'></div><div class='col-md-4'><div class='alert alert-danger' role='alert'>Password not match.</div></div><div class='col-md-4'></div>";
		echo "</div>";
		unset($_SESSION['passwordinfo']);
		break;
		case 'wrongpwd':
		echo "<div class='row'>";
		echo "<div class='col-md-4'></div><div class='col-md-4'><div class='alert alert-danger' role='alert'>Password Wrong.</div></div><div class='col-md-4'></div>";
		echo "</div>";
		unset($_SESSION['passwordinfo']);
		break;
		case 'success':
		echo "<div class='row'>";
		echo "<div class='col-md-4'></div><div class='col-md-4'><div class='alert alert-success' role='alert'>Password Changed.</div></div><div class='col-md-4'></div>";
		echo "</div>";
		unset($_SESSION['passwordinfo']);
		break;
	}
}
?>

<div class='row'>

<div class="col-md-4"></div>

<div class="col-md-4">
	<div class="panel panel-primary">
	  <div class="panel-heading">
	    <h3 class="panel-title"><b>Change Password</b></h3>
	  </div>
	  <form action="__changepassdrow.php" method="post">
	  <div class="panel-body">
		<table class="table">
			<tr>
				<td>New Password :</td>
				<td>:</td>
				<td><input type="password" name="newPassword" class="form-control"></td>
			</tr>
			<tr>
				<td>Confirm New Password :</td>
				<td>:</td>
				<td><input type="password" name="confirmPassword" class="form-control"></td>
			</tr>
			<tr>
				<td>Current Password :</td>
				<td>:</td>
				<td><input type="password" name="currentPassword" class="form-control"></td>
			</tr>
		</table>
	  </div>
	  <div class="panel-footer"><input type="submit" class="btn btn-block btn-primary" value="Change My Password"></div>
	</div>
	</form>
</div>

<div class="col-md-4"></div>

</div>

</div>

<?php
include "__footer.php";
?>