<?php 
include "__connection.php"; 
if(!isset($_SESSION['fcon'])) { echo "<script>window.location.replace('login.php');</script>"; }
?>
<!DOCTYPE html>
<html>
<head>
	<title>HR Module :: <?= $module['title']; ?></title>
	<link rel="icon" type="image/png" href="icon.png">
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="bootstrap/sweetalert/dist/sweetalert.css">
	<link rel="stylesheet" type="text/css" href="jquery-ui/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="jquery-ui/jquery-ui.theme.css">
	<link rel="stylesheet" type="text/css" href="datatables.min.css">
	<script type="text/javascript" src="bootstrap/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="jquery-ui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="bootstrap/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript" src="datatables/datatables.min.js"></script>
</head>
<body>

<!-- header -->
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/integrity"><img src='intgrey.png' width="50px"></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

      <ul class="nav navbar-nav">

      	<li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Module HR <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="health_claim.php">Health Claim Form</a></li>
            <li><a href="view_hclaim.php">Health Claim History</a></li>
            <li><a href="admin_hclaim.php">Health Claim Overview</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="leave_claim.php">Leave Claim Form</a></li>
            <li><a href="view_lclaim.php">Leave Claim History</a></li>
            <li><a href="admin_lclaim.php">Leave Claim Overview</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="vp_claim.php">Variable Pay Claim Form</a></li>
            <li><a href="view_vpclaim.php">Variable Pay Claim History</a></li>
            <li><a href="admin_vpclaim.php">Variable Pay Claim Overview</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="offreq_lclaim.php">Request for Offday (in lieu) Form</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="user.php">Users Management</a></li>
          </ul>
        </li>

        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Module HR : Report <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="report_hclaim.php">Health Claim Report</a></li>
            <li><a href="report_lclaim.php">Leave Claim Report</a></li>
            <li><a href="report_vpclaim.php">Variable Pay Report</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">Users Report</a></li>
          </ul>
        </li>

        <li><a href="#">DPT Search</a></li>

        <li><a href="#">Meeting Room</a></li>

      </ul>

      <ul class="nav navbar-nav navbar-right">

        <li><a href="#" onclick="aboutHRModule()">About</a></li>

        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $_SESSION['fnam']; ?> <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="profiles.php">Profile</a></li>
            <li><a href="chpwd.php">Change Password</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="flock-control.php?logout">Logout</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<!-- end of header -->