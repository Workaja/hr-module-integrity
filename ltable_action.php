<?php
include "__connection.php";

if(isset($_POST)) {
	foreach($_POST as $key => $value) {
		if(substr($key, 0, 4) == 'LTY_') {
			$username = explode("_", $key);
			$ki->query("update cuti_quota set quota_cuti = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 4) == 'LLY_') {
			$username = explode("_", $key);
			echo "LLY: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_remainbefore = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 4) == 'LNW_') {
			$username = explode("_", $key);
			echo "LNW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_nonworkday = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 4) == 'LLW_') {
			$username = explode("_", $key);
			echo "LLW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_nonworkdaybefore = ".$value." where user = '".$username[1]."'");
		}
	}

	
	$_SESSION['llimit'] = 'Update';
    echo "<script>window.location.replace('ltable.php');</script>";
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>