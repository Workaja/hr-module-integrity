<?php
$module = array("title" => "Edit User", "appname" => "HR");
include "__header.php";

if($_GET['no'] == NULL) {
  header("Location: user.php");
} else {
  $owner = array(4,5,6,99);
  if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

  $nik = $_GET['no'];
}

$getUserProfile = $ki->query("select a.username as username, a.name as name, a.nik as nik, a.occupation as occupation, a.level as level, a.department as department, a.joindate as joindate, a.direct_acc as directacc, b.nik as da_nik, b.name as da_name, a.escalate_to as escalate_to, c.nik as et_nik, c.name as et_name, a.picture as picture, a.privileges as privileges, a.status as status from users a inner join users b on a.direct_acc = b.username inner join users c on a.escalate_to = c.username where a.nik = '".$nik."'");
$UP = $getUserProfile->fetch_assoc();
?>

<div class="container-fluid">

<div class="row">

<div class="col-md-2">
<?php if($UP['picture'] == NULL){ echo "<img src='profile_pic/default.png' width='100%'>"; } else { echo "<img src='".$UP['picture']."' width='100%'>"; } ?>

<br><br>

<div class="panel panel-primary">
  <div class="panel-body">
    <a href='user.php' class="btn btn-danger btn-block">Back to Profile</a>
  </div>
</div>
</div>

<div class="col-md-10">
<div class="panel panel-primary">
  <div class="panel-heading">Edit Profile</div>
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

    <?php
    if(isset($_SESSION['edituser'])){
      switch($_SESSION['edituser']) {
        case 'Update':
        echo "<div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['edituser_detail']."</a> Has been Updated.</div>";
        unset($_SESSION['edituser']);
        unset($_SESSION['edituser_detail']);
        break;
      }
    }
    if(isset($_SESSION['adduser'])){
      switch($_SESSION['adduser']) {
        case 'Input':
        echo "<div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['adduser_detail']."</a> Successfully Input.</div>";
        unset($_SESSION['adduser']);
        unset($_SESSION['adduser_detail']);
        break;
      }
    }
    ?>

    <br>
    <form action="action_user.php" method="post">
      <table class="table" width="100%">
      <tr>
      <td width="200px">NIK</td><td width="20px">:</td><td><?= "<input type='text' name='nik' class='form-control' value='".$UP['nik']."' readonly>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Full Name</td><td width="20px">:</td><td><?= "<input type='text' name='name' class='form-control' value='".$UP['name']."'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Occupation</td><td width="20px">:</td><td><?= "<input type='text' name='occupation' class='form-control' value='".$UP['occupation']."'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Department</td><td width="20px">:</td><td><?= "<input type='text' name='department' class='form-control' value='".$UP['department']."'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Level</td><td width="20px">:</td><td><select name='level'>
        <option value='<?= $UP['level']; ?>'><?= $UP['level']; ?></option>
        <option value='' disabled></option>
        <option value='Staff'>Staff</option>
        <option value='Supervisor'>Supervisor</option>
        <option value='Manager'>Manager</option>
        <option value='Director'>Director</option>
      </td>
      </tr>
      <tr>
      <td width="200px">Join Date</td><td width="20px">:</td>
      <td><?php 
      echo "<input type='text' name='joindate' class='form-control pick-date' value='";
      $join = explode("-", $UP['joindate']);
      echo $join[2]."-".$join[1]."-".$join[0];
      echo "'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Direct Acc</td><td width="20px">:</td>
        <td>
        <select name='directacc'>
        <option value='<?= $UP['directacc']; ?>'><?= $UP['da_nik'] . " - " . $UP['da_name']; ?></option>
        <option value='' disabled></option>
        <?php 
        $getUserList1 = $ki->query("select username,name,nik from users where level != 'staff' order by nik asc");
        while($UL1 = $getUserList1->fetch_assoc()){
          echo "<option value='".$UL1['username']."'>".$UL1['nik']." - ".$UL1['name']."</option>";
        }
        ?>
        </select>
      </td>
      </tr>
      <tr>
      <td width="200px">Escalate To</td><td width="20px">:</td>
        <td>
        <select name='escalatedto'>
        <option value='<?= $UP['escalate_to']; ?>'><?= $UP['et_nik'] . " - " . $UP['et_name']; ?></option>
        <option value='' disabled></option>
        <?php 
        $getUserList2 = $ki->query("select username,name,nik from users where level != 'staff' order by nik asc");
        while($UL2 = $getUserList2->fetch_assoc()){
          echo "<option value='".$UL2['username']."'>".$UL2['nik']." - ".$UL2['name']."</option>";
        }
        ?>
        </select>
      </td>
      </tr>
      <tr>
        <td width="200px">Privileges Level</td><td width="20px">:</td>
        <td>
          <input type="number" name="privilege" placeholder="Leave Unchanged if Don't Know" value=<?= $UP['privileges'] ?> class="form-control">
          <br><span style="font-size: 12px"><b>Leave Unchanged if Don't Know</b></span>
        </td>
      </tr>
      <tr>
        <td width="200px">User Status</td><td width="20px">:</td>
        <td><select name="userstatus">
          <option value="<?= $UP['status']; ?>"><?= ucfirst($UP['status']); ?></option>
          <option value='' disabled></option>
          <option value='active'>Active</option>
          <option value='nonactive'>Non Active</option>
      </tr>
      </table>
      <input type="submit" class="pull-right btn btn-primary" value="Update">
    </form>
  </div>
</div>

<div class="panel panel-primary">
<div class="panel-heading">Change Photo</div>
  <div class="panel-body">

  <?php
  if(isset($_SESSION['fotouser'])){
    switch($_SESSION['fotouser']) {
      case 'SuccFoto':
      echo "<div class='alert alert-success' role='alert'><a href='#' class='alert-link'>".$_SESSION['fotouser_detail']."</a> Has been Updated.</div>";
      unset($_SESSION['fotouser']);
      unset($_SESSION['fotouser_detail']);
      break;
      case 'FailFoto':
      echo "<div class='alert alert-danger' role='alert'><a href='#' class='alert-link'>".$_SESSION['fotouser_detail']."</a> Failed Change Photo.</div>";
      unset($_SESSION['fotouser']);
      unset($_SESSION['fotouser_detail']);
      break;
    }
  }
  ?>

  <form action="actionphoto_user.php" method='post' enctype="multipart/form-data">
    <?= "<input type='hidden' name='nik' class='form-control' value='".$UP['nik']."' readonly>"; ?>
    <input type="file" name="fileToUpload" id="fileToUpload">
    <br>
    <span style="font-size: 12px"><b>Use with same file size ratio in pixels, example : 150x150, 300x300, 600x600, etc. Max. 100KB</b></span>
    <br>
    <input type="submit" class="pull-right btn btn-primary" value="Change Photo">
  </form>
  </div>
</div>
</div>
</div>

</div>
</div>

<script>
  $( document ).ready(function() {
      $( ".pick-date" ).datepicker({
        dateFormat: "dd-mm-yy"
      });
  });
</script>

<?php
include "__footer.php";
?>