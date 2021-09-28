<?php
$module = array("title" => "Change Password", "appname" => "HR");
include "__header.php";
?>

<div class='container-fluid'>

<div class='row'>

<div class="col-md-2"></div>

<div class="col-md-8">
	<div class="panel panel-warning">
	  <div class="panel-heading">
	    <h3 class="panel-title"><b>This is Test Area</b></h3>
	  </div>
	  <form action="__nuclear_test.php" method="post">
	  <div class="panel-body">
		<?php

		#
		if($_POST!=NULL){
				$dbname = "intranet";
				$bufile = "backup/".date('d-m-Y')."_backup.sql";
				exec("mysqldump -u root -h localhost intranet > ".$bufile);
				unset($_POST);
		}


		?>
		<input type="submit" name="bexap" value="Backup Database" class="btn btn-block btn-primary">
	  </div>
	  <div class="panel-footer">
	  	
	  </div>
	</div>
	</form>
</div>

<div class="col-md-2"></div>

</div>

</div>

<?php
include "__footer.php";
?>