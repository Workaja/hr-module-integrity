<?php
$module = array("title" => "Info User", "appname" => "HR");
include "__header.php";

if($_GET['no'] == NULL) {
  header("Location: user.php");
} else {
  $owner = array(5,6,99);
  if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

  $nik = $_GET['no'];
}

$getUserProfile = $ki->query("select a.username, a.name, a.NIK, a.occupation, a.level, a.department, b.name as direct_acc, c.name as escalate_to, a.picture as picture, a.joindate as joindate from users a inner join users b on a.direct_acc = b.username inner join users c on a.escalate_to = c.username where a.NIK = '".$nik."'");
$UP = $getUserProfile->fetch_assoc();
?>

<div class="container-fluid">
<div class="row">

<div class="col-md-2">
<?php if($UP['picture'] == NULL){ echo "<img src='profile_pic/default.png' width='100%'>"; } else { echo "<img src='".$UP['picture']."' width='100%'>"; } ?>

<br><br>

<div class="panel panel-primary">
  <div class="panel-body">
    <center>Join Date : <b><?php $join = explode("-", $UP['joindate']); echo $join[2]."-".$join[1]."-".$join[0]; ?></b></center>
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-body">
    <a href='<?= "edit_user.php?no=" . $UP['NIK']; ?>' class="btn btn-primary btn-block">Update</a>
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-body">
    <a href='user.php' class="btn btn-danger btn-block">Back to User Mgt.</a>
  </div>
</div>
</div>

<div class="col-md-8">
<div class="panel panel-primary">
  <div class="panel-heading">Profile</div>
  <div class="panel-body">
    <?php
    $arrayName = array();
    $playName = explode(" ", $UP['name']);
    for($x=0;$x<(count($playName));$x++){
    	array_push($arrayName, substr($playName[$x], 0, 1));
    	array_push($arrayName, substr($playName[$x], 1));
    }
    echo "<p style='font-size: 24px; color: #b70724'>";
    for($y=0;$y<(count($arrayName));$y++){
    	echo $arrayName[$y];
    	$y++;
    	echo "<span style='font-size: 23px; color: #2f3133'>".$arrayName[$y]."</span> ";
    }
    echo "</p>";
    ?>
    <p>@<?= $UP['username']; ?></p>
    <p><?= $UP['occupation']; ?></p>
</div>
    <table class="table" width="100%">
    <tr>
    <td width="200px">NIK</td><td width="20px">:</td><td><?= $UP['NIK']; ?></td>
    </tr>
    <tr>
    <td width="200px">Department</td><td width="20px">:</td><td><?= $UP['department']; ?></td>
    </tr>
    <tr>
    <td width="200px">Level</td><td width="20px">:</td><td><?= $UP['level']; ?></td>
    </tr>
    <tr>
    <td width="200px">Direct ACC</td><td width="20px">:</td><td><?= $UP['direct_acc']; ?></td>
    </tr>
    <tr>
    <td width="200px">Escalate To</td><td width="20px">:</td><td><?= $UP['escalate_to']; ?></td>
    </tr>
    </table>
</div>
</div>

<div class="col-md-2">
<div class="panel panel-primary">
  <div class="panel-heading">Access</div>

	<ul class="list-group">
		<li class="list-group-item">A</li>
		<li class="list-group-item">B</li>
		<li class="list-group-item">C</li>
		<li class="list-group-item">D</li>
		<li class="list-group-item">E</li>
		<li class="list-group-item">F</li>
		<li class="list-group-item">G</li>
		<li class="list-group-item">H</li>
	</ul>

</div>
</div>

</div>
</div>

<?php
include "__footer.php";
?>