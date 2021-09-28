<?php
include "__connection.php";

if(isset($_POST)) {
	foreach($_POST as $key => $value) {
		if(substr($key, 0, 5) == 'SICK_') {
			$username = explode("_", $key);
			$ki->query("update cuti_quota set quota_sick = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'WED1_') {
			$username = explode("_", $key);
			echo "LLY: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_wedding = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'WED2_') {
			$username = explode("_", $key);
			echo "LNW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_wedding2 = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'KHIT_') {
			$username = explode("_", $key);
			echo "LLW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_kidbless = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'MATR_') {
			$username = explode("_", $key);
			echo "LLW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_maternity = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'DEC1_') {
			$username = explode("_", $key);
			echo "LLW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_internaldecease = ".$value." where user = '".$username[1]."'");
		}
		if(substr($key, 0, 5) == 'DEC2_') {
			$username = explode("_", $key);
			echo "LLW: " . $username[1] . " = ".$value . "<br>";
			$ki->query("update cuti_quota set quota_onehomedecease = ".$value." where user = '".$username[1]."'");
		}
	}

	
	$_SESSION['illimit'] = 'Update';
    echo "<script>window.location.replace('iltable.php');</script>";
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>