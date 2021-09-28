<?php
include "__connection.php";

if(isset($_POST)) {
	$nam = $_POST['name'];
	$usr = strtolower($_POST['username']); 
	$occ = $_POST['occupation'];
	$dep = $_POST['department'];
	$lvl = $_POST['level'];
	$joi = $_POST['joindate'];
	$dac = $_POST['directacc'];
	$esc = $_POST['escalatedto'];
	$prv = $_POST['privilege'];
	$sts = $_POST['userstatus'];

	$join = explode("-", $joi);
	$newJOI = $join[2]."-".$join[1]."-".$join[0];

	$getLastNIK = $ki->query("select nik from users where id = (select max(id) from users);");
	$LNIK = $getLastNIK->fetch_assoc();

	$getNIKOnly = substr($LNIK['nik'], 3);

	$nuNIK = (int) $getNIKOnly + 1;
	$newNIK = "INT" . str_pad($nuNIK, 3, "0", STR_PAD_LEFT);

	$ki->query("insert into users 
				(username,password,name,nik,occupation,level,department,joindate,direct_acc,escalate_to,privileges,status)
				values
				('".$usr."',password('".$usr."'),'".$nam."','".$newNIK."','".$occ."','".$lvl."','".$dep."','".$newJOI."','".$dac."','".$esc."',".$prv.",'".$sts."');"
				);

	$_SESSION['adduser'] = 'Input';
    $_SESSION['adduser_detail'] = $newNIK;

    #create folder for uploading hclaim
    mkdir("claimdocs/".$usr, 0777);


    echo "<script>window.location.replace('edit_user.php?no=".$newNIK."');</script>";
} else {
	header("Location: index.php");
}

mysqli_close($ki);

?>