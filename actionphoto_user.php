<?php
include "__connection.php";

if(isset($_POST)) {
	$nik = $_POST['nik'];
	
	//------------------------- UPLOAD FILES --------------------------------------------------------------
	$target_dir = "profile_pic/";
	$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
	$uploadOk = 1;
	$imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);

	// Check if image file is a actual image or fake image
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        echo "File is an image - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        echo "File is not an image.<br>";
        $uploadOk = 3;
    }

	// Check if file already exists
	if (file_exists($target_file)) {
		$salt = explode("_", '1000_3617');
		$random = random_int(10400, 32324);
		$myKey = $salt[0] . $random . $salt[1];
	    $target_file = $target_dir . $myKey . basename($_FILES["fileToUpload"]["name"]);
	}

	// Check file size
	if ($_FILES["fileToUpload"]["size"] > 100000) {
	    $uploadOk = 0;
	}

	// Allow certain file formats
	if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
	&& $imageFileType != "gif" ) {
	    $uploadOk = 0;
	}

	// Check if $uploadOk is set to 0 by an error
	if ($uploadOk == 0) {
	    $_SESSION['fotouser'] = 'FailFoto';
	    $_SESSION['fotouser_detail'] = $nik;
	    echo "<script>window.location.replace('edit_user.php?no=".$nik."');</script>";

	// if everything is ok, try to upload file
	} else {
	    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
	        echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.<br>";

	        $ki->query("update users set picture = '".$target_file."' where nik = '".$nik."';");

	        $_SESSION['fotouser'] = 'SuccFoto';
		    $_SESSION['fotouser_detail'] = $nik;
		    echo "<script>window.location.replace('edit_user.php?no=".$nik."');</script>";
	    } else {
	        $_SESSION['fotouser'] = 'FailFoto';
		    $_SESSION['fotouser_detail'] = $nik;
		    echo "<script>window.location.replace('edit_user.php?no=".$nik."');</script>";
	    }
	}
	//------------------------- END UPLOAD FILES -----------------------------------------------------------
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>