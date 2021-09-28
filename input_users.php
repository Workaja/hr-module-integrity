<?php
$module = array("title" => "Add User", "appname" => "HR");
include "__header.php";

$owner = array(4,5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 
?>

<div class="container-fluid">

<div class="row">

<div class="col-md-2">

<div class="panel panel-primary">
  <div class="panel-body">
    <a href='user.php' class="btn btn-danger btn-block">Back to Management</a>
  </div>
</div>

</div>

<div class="col-md-10">
<div class="panel panel-primary">
  <div class="panel-heading">Add User Information</div>
  <div class="panel-body">

    <br>
    <form action="__add_user.php" method="post">
      <table class="table" width="100%">
      <tr>
      <td width="200px">Full Name</td><td width="20px">:</td><td><?= "<input type='text' name='name' class='form-control'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">User Name</td><td width="20px">:</td><td><?= "<input type='text' name='username' class='form-control'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Occupation</td><td width="20px">:</td><td><?= "<input type='text' name='occupation' class='form-control'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Department</td><td width="20px">:</td><td><?= "<input type='text' name='department' class='form-control'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Level</td><td width="20px">:</td><td><select name='level'>
        <option value='Staff'>Staff</option>
        <option value='Supervisor'>Supervisor</option>
        <option value='Manager'>Manager</option>
        <option value='Director'>Director</option>
      </td>
      </tr>
      <tr>
      <td width="200px">Join Date</td><td width="20px">:</td><td><?= "<input type='text' name='joindate' class='form-control pick-date'>"; ?></td>
      </tr>
      <tr>
      <td width="200px">Direct Acc</td><td width="20px">:</td>
        <td>
        <select name='directacc'>
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
          <input type="number" name="privilege" placeholder="0: Staff" value="0" class="form-control">
          <br><span style="font-size: 12px"><b>Leave Unchanged if Don't Know</b></span>
        </td>
      </tr>
      <tr>
        <td width="200px">User Status</td><td width="20px">:</td>
        <td><select name="userstatus">
          <option value='active'>Active</option>
          <option value='nonactive'>Non Active</option>
      </tr>
      </table>
      <input type="submit" class="pull-right btn btn-primary" value="Submit">
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