<?php
include "__connection.php";

if(isset($_POST)) {
	foreach($_POST as $key => $value) {
		if(substr($key, 0, 5) == 'limit') {
			$username = explode("_", $key);
			$ki->query("update `limit` set health = ".$value." where username = '".$username[1]."'");
		}
	}

	
	$_SESSION['hlimit'] = 'Update';
    echo "<script>window.location.replace('htable.php');</script>";
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>