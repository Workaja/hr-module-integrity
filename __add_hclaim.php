<?php
include "__connection.php";

if(isset($_POST)) {
	#get claim number
	$getLastClaimNumber = $ki->query("select no_claim from claim_kesehatan order by no_claim desc limit 1");
	$ClaimNum = $getLastClaimNumber->fetch_assoc();

	#dissect no_claim
	$getnumOfClaim = substr($ClaimNum['no_claim'], 5, 10);

	#add one
	$newnumOfClaim = 1 + (int) $getnumOfClaim;

	#padding
	$newnumClaim = "KS-16" . str_pad($newnumOfClaim, 4, "0", STR_PAD_LEFT);
	
	#get hr manager & office manager
	$getHRandOfficeManager = $ki->query("select (select username from users where id = ".$_POST['monitoredby'].") as HR,
												(select username from users where id = ".$_POST['payee'].") as OM");
	$HRnOM = $getHRandOfficeManager->fetch_assoc();

	//------------------------- UPLOAD FILES --------------------------------------------------------------
	$target_dir = "claimdocs/" . $_SESSION['fusn'] . "/";
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
		$salt = explode("_", 'MABOR_OSHI-');
		$random = random_int(10000, 99089);
		$myKey = $salt[0] . $random . $salt[1] . $_SESSION['fusn'];
	    $target_file = $target_dir . $myKey . basename($_FILES["fileToUpload"]["name"]);
	}

	// Check file size
	if ($_FILES["fileToUpload"]["size"] > 500000) {
	    echo "Sorry, your file is too large.<br>";
	    $uploadOk = 0;
	}

	// Allow certain file formats
	if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
	&& $imageFileType != "gif" ) {
	    echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.<br>";
	    $uploadOk = 0;
	}

	// Check if $uploadOk is set to 0 by an error
	if ($uploadOk == 0) {
	    echo "Sorry, your file was not uploaded.<br>";

	// if everything is ok, try to upload file
	} else {
	    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
	        echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.<br>";
	        $uploadOk = 2;
	    } else {
	        echo "Sorry, there was an error uploading your file.<br>";
	        #$uploadOk = 3;
	    }
	}
	//------------------------- END UPLOAD FILES -----------------------------------------------------------

	#This script require to complete the file upload.
	if($uploadOk == 2) {
		// query
		$ki->query("insert into claim_kesehatan (no_claim,username,tgl_claim,total_biaya,diajukan_oleh,diajukan_tgl,disetujui_oleh,dibayar_oleh,status_dok,dokumen) values ('".$newnumClaim."','".$_SESSION['fusn']."',CURDATE(),".$_POST['totalvalue'].",'".$_SESSION['fusn']."',CURDATE(),'".$HRnOM['HR']."','".$HRnOM['OM']."','DRAFT','".$target_file."');");

		for($i=1;$i<=8;$i++) {
			if($_POST['date'.$i] == NULL || $_POST['claim'.$i] == NULL || $_POST['value'.$i] == NULL) {
				#do nothing
			} else {
				$dateConverter = explode("-",$_POST['date'.$i]);
				$newDate = $dateConverter[2] . "/" . $dateConverter[1] . "/" . $dateConverter[0];
				$sq = "insert into claim_kesehatan_detail (no_claim,tgl,jenis_biaya,jumlah,bon) values ('".$newnumClaim."','".$newDate."','".$_POST['claim'.$i]."',".$_POST['value'.$i].",'".$_POST['receipt'.$i]."');";
				$ki->query($sq);
			}
		}

		$_SESSION['hclaiminfo'] = 'Success';
		$_SESSION['hclaiminfo_detail'] = $newnumClaim;
		header("Location: health_claim.php");

	} elseif($uploadOk == 0) {
		$_SESSION['hclaiminfo'] = 'Failed';
		header("Location: health_claim.php");
	} elseif($uploadOk == 3) {
		// query
		$ki->query("insert into claim_kesehatan (no_claim,username,tgl_claim,total_biaya,diajukan_oleh,diajukan_tgl,disetujui_oleh,dibayar_oleh,status_dok,dokumen) values ('".$newnumClaim."','".$_SESSION['fusn']."',CURDATE(),".$_POST['totalvalue'].",'".$_SESSION['fusn']."',CURDATE(),'".$HRnOM['HR']."','".$HRnOM['OM']."','DRAFT','#');");

		for($i=1;$i<=8;$i++) {
			if($_POST['date'.$i] == NULL || $_POST['claim'.$i] == NULL || $_POST['value'.$i] == NULL) {
				#do nothing
			} else {
				$dateConverter = explode("-",$_POST['date'.$i]);
				$newDate = $dateConverter[2] . "/" . $dateConverter[1] . "/" . $dateConverter[0];
				$sq = "insert into claim_kesehatan_detail (no_claim,tgl,jenis_biaya,jumlah,bon) values ('".$newnumClaim."',
						'".$newDate."','".$_POST['claim'.$i]."',".$_POST['value'.$i].",'".$_POST['receipt'.$i]."');";
				$ki->query($sq);
			}
		}

		$_SESSION['hclaiminfo'] = 'SuccLed';
		$_SESSION['hclaiminfo_detail'] = $newnumClaim;
		header("Location: health_claim.php");
	}
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>