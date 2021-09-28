<?php
include "__connection.php";

$total = ceil($_POST['totaldate']);
$from  = new DateTime($_POST['fromdate']);

$nonull = 0;

if($from != NULL) {
$getLastDateFromTotal = $ki->query("
					select max(b.tanggal) as tanggal from (select a.tanggal from (select * from kalender where tanggal >= (select leave_start from konfigurasi where activeyear = 2016) and tanggal <= (select leave_end from konfigurasi where activeyear = 2016)) as a where merah != 'Y' and tanggal >= '" . date_format($from,'Y-m-d') . "' limit " . $total . ") as b");
$LDFT = $getLastDateFromTotal->fetch_assoc();
$end = new DateTime($LDFT['tanggal']);

$nonull = 1;
}

if($nonull = 0) { } elseif($nonull = 1) { echo date_format($end,'d-m-Y'); }

mysqli_close($ki);
?>