<?php
include "__connection.php";
?>
<!DOCTYPE html>
<html>
<head>
	<title>Login into Intranet</title>
	<link rel="icon" type="image/png" href="icon.png">
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
</head>
<body>

<div class="container-fluid">
<br>
<br>
<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4">
<center>
<img src="icon.png">
<h1>Intranet</h1></center>
<form action="flock-control.php" method="post">
<?php 
	
	if(isset($_SESSION['flock-loginerror'])) { 
		echo "<div class='alert alert-danger' role='alert'>".$_SESSION['flock-loginerror']."</div>"; 
		unset($_SESSION['flock-loginerror']); 
	}
	 
?>
  <div class="form-group">
    <label for="flock-username">Username</label>
    <input name="flock-username" type="text" class="form-control" id="flock-username" placeholder="Username">
  </div>
  <div class="form-group">
    <label for="flock-password">Password</label>
    <input name="flock-password" type="password" class="form-control" id="flock-password" placeholder="Password">
  </div>
  <button type="submit" class="btn btn-danger pull-right">Login</button>
</form>
</div>
<div class="col-md-4"></div>
</div>
<div class="row">
<div class="col-md-12">
<center><br><br><br><label>IT Department 2016</label></center>
</div>
</div>

</div>

</body>
</html>
<?php
mysqli_close($ki);
?>