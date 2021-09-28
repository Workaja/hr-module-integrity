<?php
$module = array("title" => "My Profile", "appname" => "HR");
include "__header.php";

$getUserProfile = $ki->query("select a.username, a.name, a.NIK, a.occupation, a.level, a.department, b.name as direct_acc, c.name as escalate_to, a.picture as picture, a.joindate as joindate from users a inner join users b on a.direct_acc = b.username inner join users c on a.escalate_to = c.username where a.username = '".$_SESSION['fusn']."'");
$UP = $getUserProfile->fetch_assoc();
?>

<div class="container-fluid">
<div class="row">

<div class="col-md-2">
<?php if($UP['picture'] == NULL){ echo "<img src='profile_pic/default.png' width='100%'>"; } else { echo "<img src='".$UP['picture']."' width='100%'>"; } ?>

<br><br>

<div class="panel panel-primary">
  <div class="panel-body">
    <center>Join Date : <b><?= $UP['joindate']; ?></b></center>
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-body">
    <a href='chpwd.php' class="btn btn-primary btn-block">Change Password</a>
  </div>
</div>
</div>

<div class="col-md-10">
<div class="panel panel-primary">
  <div class="panel-heading">My Profile</div>
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
    <br>
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
</div>

</div>
</div>

<?php
include "__footer.php";
?>