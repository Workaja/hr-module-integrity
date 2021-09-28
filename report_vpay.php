<?php
$module = array("title" => "Report Variable Pay Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

$from 	= $_GET['sy']."-".$_GET['sm']."-21";
$until  = $_GET['ey']."-".$_GET['em']."-22";

$getWorkDayNoRed = $ki->query("select count(tanggal) as workDay from kalender where (tanggal between '".$from."' and '".$until."') and merah = 'N'");
$WDNR = $getWorkDayNoRed->fetch_assoc();
$workDay = $WDNR['workDay'];

?>

<div class="container-fluid">
<h3>Active Periode 2016-2017</h3>

<table width=100%>
<thead>
<tr>
	<td>Nama<br>Pegawai</td>
	<td>Masuk<br>Harian</td>
	<td>Absent</td>
	<td>Dinas<br>Luar Kota</td>
	<td>Dinas<br>Luar Negeri</td>
	<td>Weekend<br>(SO/OH)</td>
	<td>Weekend<br>(IG/FS)</td>
	<td>Double</td>
	<td>Night</td>
	<td rowspan="2">Yang<br>Dibayarkan</td>
</tr>
<tr>
	<td>Jumlah Tunjangan</td>
	<?php
	$get_tunjangan = $ki->query("select * from lembur_payment");
	$tunjangan = $get_tunjangan->fetch_assoc();
	?>
	<td>Rp <?= $tunjangan['harian']; ?></td>
	<td>(Rp 50000)</td>
	<td>Rp <?= $tunjangan['luarkota']; ?></td>
	<td>USD <?= $tunjangan['luarnegeri']; ?></td>
	<td>Rp <?= $tunjangan['weekend_sooh']; ?></td>
	<td>Rp <?= $tunjangan['weekend_igfs']; ?></td>
	<td>Rp <?= $tunjangan['doubleshift']; ?></td>
	<td>Rp <?= $tunjangan['nightshift']; ?></td>
</tr>
</thead>
<tbody>
<tr>
	<?php
		$dfrom = date_create($from);
		$dunti = date_create($until);
	?>
	<td colspan="2"><span style="font-size: 11px">Perhitungan Tunjangan : <?= date_format($dfrom,"d-M-Y") . " - " . date_format($dunti,"d-M-Y");; ?> </span></td>
	<td colspan="6"></td>
</tr>
<?php
////////////////////////////////////////////////////////////////////////////////////////////////// SO
echo "
<tr>
	<td colspan='8'><div style='height: 25px'></div></td>
</tr>
<tr>
	<td colspan='8'><b>Surveilance Operative (SO)</b></td>
</tr>";
$get_so_list = $ki->query("select id, username, occupation from users where occupation in ('KO','SO') order by occupation asc, nik asc");
while($so_list = $get_so_list->fetch_assoc()) {
	$a = $workDay; 
	$b = ""; $c = ""; $d = ""; $e = ""; $f = ""; $g = "";
	$lembur_act = "";
	$get_full_name = $ki->query("select name from users where username = '".$so_list['username']."'");
	$full_name = $get_full_name->fetch_assoc();
	echo "<td>".$full_name['name']."</td>";

	$get_cuti_log = $ki->query("select total_date, tgl_start, tgl_end, tgl_list, jenis_lembur, ifnull(dollar,0) as dollar from lembur_log where user = '".$so_list['username']."' and status = 'APPROVED'");

	while($cuti_log = $get_cuti_log->fetch_assoc()) {
		if($cuti_log['jenis_lembur'] == 'luarkota') {
			$b .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'luarnegeri') {
			$c .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_sooh') {
			$d .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_igfs') {
			$e .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'doubleshift') {
			$f .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'nightshift') {
			$g .= $cuti_log['tgl_list'];
		}
	}
	echo "<td>".$a."</td>";
	
	$itungsakit = 
		$ki->query("select ifnull(sum(totaldate),0) as A from cuti_log where jenis_cuti in (5,6,7,8,9,10,11) and 
						tgl_cuti_from >= '".$from."' and tgl_cuti_to <= '".$until."' and
						user = '".$so_list['username']."' and status = 'APPROVED';
						");
	$getsakit = $itungsakit->fetch_assoc();

	$itungstaffoff = $ki->query("select count(*) as offday from staffoff_log where user = ".$so_list['id']." and (date between '".$from."' and '".$until."') and status = 'OFF'");
	$getstaffoff = $itungstaffoff->fetch_assoc();
	$absentTotal = $getsakit['A'] + $getstaffoff['offday'];

	echo "<td>"; if($absentTotal != 0) { echo $absentTotal; } echo "</td>";

	echo "<td>";
	///////////////////////////////////////////////
	$databeh = array_filter(explode(":", $b));
	$btd = "";

	foreach($databeh as $dtb) {
		if($dtb >= $from) {
			$btd .= $dtb . ":";
		}
	}
	
	$behdata = array_filter(explode(":", $btd));
	$ttt = "";

	foreach ($behdata as $ttb) {
		if($ttb <= $until) {
			$ttt .= $ttb . ":";
		}
	}

	$satu = count(array_filter(explode(":", $ttt)));

	if($satu != 0) { echo $satu; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataceh = array_filter(explode(":", $c));
	$ctd = "";

	foreach($dataceh as $dtc) {
		if($dtc >= $from) {
			$ctd .= $dtc . ":";
		}
	}
	
	$cehdata = array_filter(explode(":", $ctd));
	$yyy = "";

	foreach ($cehdata as $ttc) {
		if($ttc <= $until) {
			$yyy .= $ttc . ":";
		}
	}

	$dua = count(array_filter(explode(":", $yyy)));
	
	if($dua != 0) { echo $dua; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataeeh = array_filter(explode(":", $d));
	$etd = "";

	foreach($dataeeh as $dte) {
		if($dte >= $from) {
			$etd .= $dte . ":";
		}
	}
	
	$eehdata = array_filter(explode(":", $etd));
	$rrr = "";

	foreach ($eehdata as $tte) {
		if($tte <= $until) {
			$rrr .= $tte . ":";
		}
	}

	$tiga = count(array_filter(explode(":", $rrr)));

	if($tiga != 0) { echo $tiga; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datageh = array_filter(explode(":", $e));
	$gtd = "";

	foreach($datageh as $dtg) {
		if($dtg >= $from) {
			$gtd .= $dtg . ":";
		}
	}
	
	$gehdata = array_filter(explode(":", $gtd));
	$uuu = "";

	foreach ($gehdata as $ttg) {
		if($ttg <= $until) {
			$uuu .= $ttg . ":";
		}
	}

	$empat = count(array_filter(explode(":", $uuu)));

	if($empat != 0) { echo $empat; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datajeh = array_filter(explode(":", $f));
	$jtd = "";

	foreach($datajeh as $dtj) {
		if($dtj >= $from) {
			$jtd .= $dtj . ":";
		}
	}
	
	$jehdata = array_filter(explode(":", $jtd));
	$iii = "";

	foreach ($jehdata as $ttj) {
		if($ttj <= $until) {
			$iii .= $ttj . ":";
		}
	}

	$lima = count(array_filter(explode(":", $iii)));

	if($lima != 0) { echo $lima; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datapeh = array_filter(explode(":", $g));
	$ptd = "";

	foreach($datapeh as $dtp) {
		if($dtp >= $from) {
			$ptd .= $dtp . ":";
		}
	}
	
	$pehdata = array_filter(explode(":", $ptd));
	$ooo = "";

	foreach ($pehdata as $ttp) {
		if($ttp <= $until) {
			$ooo .= $ttp . ":";
		}
	}

	$enam = count(array_filter(explode(":", $ooo)));

	if($enam != 0) { echo $enam; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>Rp ";

	$LOSTE = 0;
	$getVPLeaveOnStartToEndLN = $ki->query("select total_date, ifnull(dollar,0) as dollar from lembur_log where jenis_lembur = 'luarnegeri' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTE = $getVPLeaveOnStartToEndLN->fetch_assoc()){
		$LOSTE += ((int) $VPLOSTE['total_date'] - 1) * (int) $VPLOSTE['dollar'];
	}

	$LOSTED = 0;
	$getVPLeaveOnStartToEndLK = $ki->query("select total_date, 125000 as akomodasi from lembur_log where jenis_lembur = 'luarkota' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTED = $getVPLeaveOnStartToEndLK->fetch_assoc()){
		$LOSTED += ((int) $VPLOSTED['total_date'] - 1) * (int) $VPLOSTED['akomodasi'];
	}

	echo 
	($tunjangan['harian'] * $a) + 
	($LOSTED) + 
	($LOSTE * 25) +
	($tunjangan['weekend_sooh'] * $tiga) + 
	($tunjangan['weekend_igfs'] * $empat) + 
	($tunjangan['doubleshift'] * $lima) + 
	($tunjangan['nightshift'] * $enam) - 
	(
		($tunjangan['harian'] * $getsakit['A']) + 
		($tunjangan['harian'] * $getstaffoff['offday'])
	);
	echo "</td>";
	echo "</tr>";
}
////////////////////////////////////////////////////////////////////////////////////////////////// IGJKT
echo "
<tr>
	<td colspan='8'><div style='height: 25px'></div></td>
</tr>
<tr>
	<td colspan='8'><b>Investigator Jakarta (IG JKT)</b></td>
</tr>";
$get_so_list = $ki->query("select id, username, occupation from users where occupation in ('IGJKT') order by occupation asc, nik asc");
while($so_list = $get_so_list->fetch_assoc()) {
	$a = $workDay; 
	$b = ""; $c = ""; $d = ""; $e = ""; $f = ""; $g = "";
	$lembur_act = "";
	$get_full_name = $ki->query("select name from users where username = '".$so_list['username']."'");
	$full_name = $get_full_name->fetch_assoc();
	echo "<td>".$full_name['name']."</td>";

	$get_cuti_log = $ki->query("select total_date, tgl_start, tgl_end, tgl_list, jenis_lembur, ifnull(dollar,0) as dollar from lembur_log where user = '".$so_list['username']."' and status = 'APPROVED'");

	while($cuti_log = $get_cuti_log->fetch_assoc()) {
		if($cuti_log['jenis_lembur'] == 'luarkota') {
			$b .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'luarnegeri') {
			$c .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_sooh') {
			$d .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_igfs') {
			$e .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'doubleshift') {
			$f .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'nightshift') {
			$g .= $cuti_log['tgl_list'];
		}
	}
	echo "<td>".$a."</td>";
	
	$itungsakit = 
		$ki->query("select ifnull(sum(totaldate),0) as A from cuti_log where jenis_cuti in (5,6,7,8,9,10,11) and 
						tgl_cuti_from >= '".$from."' and tgl_cuti_to <= '".$until."' and
						user = '".$so_list['username']."' and status = 'APPROVED';
						");
	$getsakit = $itungsakit->fetch_assoc();

	$itungstaffoff = $ki->query("select count(*) as offday from staffoff_log where user = ".$so_list['id']." and (date between '".$from."' and '".$until."') and status = 'OFF'");
	$getstaffoff = $itungstaffoff->fetch_assoc();
	$absentTotal = $getsakit['A'] + $getstaffoff['offday'];

	echo "<td>"; if($absentTotal != 0) { echo $absentTotal; } echo "</td>";

	echo "<td>";
	///////////////////////////////////////////////
	$databeh = array_filter(explode(":", $b));
	$btd = "";

	foreach($databeh as $dtb) {
		if($dtb >= $from) {
			$btd .= $dtb . ":";
		}
	}
	
	$behdata = array_filter(explode(":", $btd));
	$ttt = "";

	foreach ($behdata as $ttb) {
		if($ttb <= $until) {
			$ttt .= $ttb . ":";
		}
	}

	$satu = count(array_filter(explode(":", $ttt)));

	if($satu != 0) { echo $satu; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataceh = array_filter(explode(":", $c));
	$ctd = "";

	foreach($dataceh as $dtc) {
		if($dtc >= $from) {
			$ctd .= $dtc . ":";
		}
	}
	
	$cehdata = array_filter(explode(":", $ctd));
	$yyy = "";

	foreach ($cehdata as $ttc) {
		if($ttc <= $until) {
			$yyy .= $ttc . ":";
		}
	}

	$dua = count(array_filter(explode(":", $yyy)));
	
	if($dua != 0) { echo $dua; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataeeh = array_filter(explode(":", $d));
	$etd = "";

	foreach($dataeeh as $dte) {
		if($dte >= $from) {
			$etd .= $dte . ":";
		}
	}
	
	$eehdata = array_filter(explode(":", $etd));
	$rrr = "";

	foreach ($eehdata as $tte) {
		if($tte <= $until) {
			$rrr .= $tte . ":";
		}
	}

	$tiga = count(array_filter(explode(":", $rrr)));

	if($tiga != 0) { echo $tiga; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datageh = array_filter(explode(":", $e));
	$gtd = "";

	foreach($datageh as $dtg) {
		if($dtg >= $from) {
			$gtd .= $dtg . ":";
		}
	}
	
	$gehdata = array_filter(explode(":", $gtd));
	$uuu = "";

	foreach ($gehdata as $ttg) {
		if($ttg <= $until) {
			$uuu .= $ttg . ":";
		}
	}

	$empat = count(array_filter(explode(":", $uuu)));

	if($empat != 0) { echo $empat; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datajeh = array_filter(explode(":", $f));
	$jtd = "";

	foreach($datajeh as $dtj) {
		if($dtj >= $from) {
			$jtd .= $dtj . ":";
		}
	}
	
	$jehdata = array_filter(explode(":", $jtd));
	$iii = "";

	foreach ($jehdata as $ttj) {
		if($ttj <= $until) {
			$iii .= $ttj . ":";
		}
	}

	$lima = count(array_filter(explode(":", $iii)));

	if($lima != 0) { echo $lima; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datapeh = array_filter(explode(":", $g));
	$ptd = "";

	foreach($datapeh as $dtp) {
		if($dtp >= $from) {
			$ptd .= $dtp . ":";
		}
	}
	
	$pehdata = array_filter(explode(":", $ptd));
	$ooo = "";

	foreach ($pehdata as $ttp) {
		if($ttp <= $until) {
			$ooo .= $ttp . ":";
		}
	}

	$enam = count(array_filter(explode(":", $ooo)));

	if($enam != 0) { echo $enam; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>Rp ";

	$LOSTE = 0;
	$getVPLeaveOnStartToEndLN = $ki->query("select total_date, ifnull(dollar,0) as dollar from lembur_log where jenis_lembur = 'luarnegeri' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTE = $getVPLeaveOnStartToEndLN->fetch_assoc()){
		$LOSTE += ((int) $VPLOSTE['total_date'] - 1) * (int) $VPLOSTE['dollar'];
	}

	$LOSTED = 0;
	$getVPLeaveOnStartToEndLK = $ki->query("select total_date, 125000 as akomodasi from lembur_log where jenis_lembur = 'luarkota' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTED = $getVPLeaveOnStartToEndLK->fetch_assoc()){
		$LOSTED += ((int) $VPLOSTED['total_date'] - 1) * (int) $VPLOSTED['akomodasi'];
	}

	echo 
	($tunjangan['harian'] * $a) + 
	($LOSTED) + 
	($LOSTE * 25) +
	($tunjangan['weekend_sooh'] * $tiga) + 
	($tunjangan['weekend_igfs'] * $empat) + 
	($tunjangan['doubleshift'] * $lima) + 
	($tunjangan['nightshift'] * $enam) - 
	(
		($tunjangan['harian'] * $getsakit['A']) + 
		($tunjangan['harian'] * $getstaffoff['offday'])
	);
	echo "</td>";
	echo "</tr>";
}
////////////////////////////////////////////////////////////////////////////////////////////////// IGLK
echo "
<tr>
	<td colspan='8'><div style='height: 25px'></div></td>
</tr>
<tr>
	<td colspan='8'><b>Investigator Luar Kota (IG LK)</b></td>
</tr>";
$get_so_list = $ki->query("select id, username, occupation from users where occupation in ('IGLK') order by occupation asc, nik asc");
while($so_list = $get_so_list->fetch_assoc()) {
	$a = $workDay; 
	$b = ""; $c = ""; $d = ""; $e = ""; $f = ""; $g = "";
	$lembur_act = "";
	$get_full_name = $ki->query("select name from users where username = '".$so_list['username']."'");
	$full_name = $get_full_name->fetch_assoc();
	echo "<td>".$full_name['name']."</td>";

	$get_cuti_log = $ki->query("select total_date, tgl_start, tgl_end, tgl_list, jenis_lembur, ifnull(dollar,0) as dollar from lembur_log where user = '".$so_list['username']."' and status = 'APPROVED'");

	while($cuti_log = $get_cuti_log->fetch_assoc()) {
		if($cuti_log['jenis_lembur'] == 'luarkota') {
			$b .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'luarnegeri') {
			$c .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_sooh') {
			$d .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_igfs') {
			$e .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'doubleshift') {
			$f .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'nightshift') {
			$g .= $cuti_log['tgl_list'];
		}
	}
	echo "<td>".$a."</td>";
	
	$itungsakit = 
		$ki->query("select ifnull(sum(totaldate),0) as A from cuti_log where jenis_cuti in (5,6,7,8,9,10,11) and 
						tgl_cuti_from >= '".$from."' and tgl_cuti_to <= '".$until."' and
						user = '".$so_list['username']."' and status = 'APPROVED';
						");
	$getsakit = $itungsakit->fetch_assoc();

	$itungstaffoff = $ki->query("select count(*) as offday from staffoff_log where user = ".$so_list['id']." and (date between '".$from."' and '".$until."') and status = 'OFF'");
	$getstaffoff = $itungstaffoff->fetch_assoc();
	$absentTotal = $getsakit['A'] + $getstaffoff['offday'];

	echo "<td>"; if($absentTotal != 0) { echo $absentTotal; } echo "</td>";

	echo "<td>";
	///////////////////////////////////////////////
	$databeh = array_filter(explode(":", $b));
	$btd = "";

	foreach($databeh as $dtb) {
		if($dtb >= $from) {
			$btd .= $dtb . ":";
		}
	}
	
	$behdata = array_filter(explode(":", $btd));
	$ttt = "";

	foreach ($behdata as $ttb) {
		if($ttb <= $until) {
			$ttt .= $ttb . ":";
		}
	}

	$satu = count(array_filter(explode(":", $ttt)));

	if($satu != 0) { echo $satu; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataceh = array_filter(explode(":", $c));
	$ctd = "";

	foreach($dataceh as $dtc) {
		if($dtc >= $from) {
			$ctd .= $dtc . ":";
		}
	}
	
	$cehdata = array_filter(explode(":", $ctd));
	$yyy = "";

	foreach ($cehdata as $ttc) {
		if($ttc <= $until) {
			$yyy .= $ttc . ":";
		}
	}

	$dua = count(array_filter(explode(":", $yyy)));
	
	if($dua != 0) { echo $dua; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataeeh = array_filter(explode(":", $d));
	$etd = "";

	foreach($dataeeh as $dte) {
		if($dte >= $from) {
			$etd .= $dte . ":";
		}
	}
	
	$eehdata = array_filter(explode(":", $etd));
	$rrr = "";

	foreach ($eehdata as $tte) {
		if($tte <= $until) {
			$rrr .= $tte . ":";
		}
	}

	$tiga = count(array_filter(explode(":", $rrr)));

	if($tiga != 0) { echo $tiga; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datageh = array_filter(explode(":", $e));
	$gtd = "";

	foreach($datageh as $dtg) {
		if($dtg >= $from) {
			$gtd .= $dtg . ":";
		}
	}
	
	$gehdata = array_filter(explode(":", $gtd));
	$uuu = "";

	foreach ($gehdata as $ttg) {
		if($ttg <= $until) {
			$uuu .= $ttg . ":";
		}
	}

	$empat = count(array_filter(explode(":", $uuu)));

	if($empat != 0) { echo $empat; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datajeh = array_filter(explode(":", $f));
	$jtd = "";

	foreach($datajeh as $dtj) {
		if($dtj >= $from) {
			$jtd .= $dtj . ":";
		}
	}
	
	$jehdata = array_filter(explode(":", $jtd));
	$iii = "";

	foreach ($jehdata as $ttj) {
		if($ttj <= $until) {
			$iii .= $ttj . ":";
		}
	}

	$lima = count(array_filter(explode(":", $iii)));

	if($lima != 0) { echo $lima; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datapeh = array_filter(explode(":", $g));
	$ptd = "";

	foreach($datapeh as $dtp) {
		if($dtp >= $from) {
			$ptd .= $dtp . ":";
		}
	}
	
	$pehdata = array_filter(explode(":", $ptd));
	$ooo = "";

	foreach ($pehdata as $ttp) {
		if($ttp <= $until) {
			$ooo .= $ttp . ":";
		}
	}

	$enam = count(array_filter(explode(":", $ooo)));

	if($enam != 0) { echo $enam; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>Rp ";

	$LOSTE = 0;
	$getVPLeaveOnStartToEndLN = $ki->query("select total_date, ifnull(dollar,0) as dollar from lembur_log where jenis_lembur = 'luarnegeri' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTE = $getVPLeaveOnStartToEndLN->fetch_assoc()){
		$LOSTE += ((int) $VPLOSTE['total_date'] - 1) * (int) $VPLOSTE['dollar'];
	}

	$LOSTED = 0;
	$getVPLeaveOnStartToEndLK = $ki->query("select total_date, 125000 as akomodasi from lembur_log where jenis_lembur = 'luarkota' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTED = $getVPLeaveOnStartToEndLK->fetch_assoc()){
		$LOSTED += ((int) $VPLOSTED['total_date'] - 1) * (int) $VPLOSTED['akomodasi'];
	}

	echo 
	($tunjangan['harian'] * $a) + 
	($LOSTED) + 
	($LOSTE * 25) +
	($tunjangan['weekend_sooh'] * $tiga) + 
	($tunjangan['weekend_igfs'] * $empat) + 
	($tunjangan['doubleshift'] * $lima) + 
	($tunjangan['nightshift'] * $enam) - 
	(
		($tunjangan['harian'] * $getsakit['A']) + 
		($tunjangan['harian'] * $getstaffoff['offday'])
	);
	echo "</td>";
	echo "</tr>";
}
////////////////////////////////////////////////////////////////////////////////////////////////// PES
echo "
<tr>
	<td colspan='8'><div style='height: 25px'></div></td>
</tr>
<tr>
	<td colspan='8'><b>PES</b></td>
</tr>";
$get_so_list = $ki->query("select id, username, occupation from users where occupation in ('PES') order by occupation asc, nik asc");
while($so_list = $get_so_list->fetch_assoc()) {
	$a = $workDay; 
	$b = ""; $c = ""; $d = ""; $e = ""; $f = ""; $g = "";
	$lembur_act = "";
	$get_full_name = $ki->query("select name from users where username = '".$so_list['username']."'");
	$full_name = $get_full_name->fetch_assoc();
	echo "<td>".$full_name['name']."</td>";

	$get_cuti_log = $ki->query("select total_date, tgl_start, tgl_end, tgl_list, jenis_lembur, ifnull(dollar,0) as dollar from lembur_log where user = '".$so_list['username']."' and status = 'APPROVED'");

	while($cuti_log = $get_cuti_log->fetch_assoc()) {
		if($cuti_log['jenis_lembur'] == 'luarkota') {
			$b .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'luarnegeri') {
			$c .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_sooh') {
			$d .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_igfs') {
			$e .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'doubleshift') {
			$f .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'nightshift') {
			$g .= $cuti_log['tgl_list'];
		}
	}
	echo "<td>".$a."</td>";
	
	$itungsakit = 
		$ki->query("select ifnull(sum(totaldate),0) as A from cuti_log where jenis_cuti in (5,6,7,8,9,10,11) and 
						tgl_cuti_from >= '".$from."' and tgl_cuti_to <= '".$until."' and
						user = '".$so_list['username']."' and status = 'APPROVED';
						");
	$getsakit = $itungsakit->fetch_assoc();

	$itungstaffoff = $ki->query("select count(*) as offday from staffoff_log where user = ".$so_list['id']." and (date between '".$from."' and '".$until."') and status = 'OFF'");
	$getstaffoff = $itungstaffoff->fetch_assoc();
	$absentTotal = $getsakit['A'] + $getstaffoff['offday'];

	echo "<td>"; if($absentTotal != 0) { echo $absentTotal; } echo "</td>";

	echo "<td>";
	///////////////////////////////////////////////
	$databeh = array_filter(explode(":", $b));
	$btd = "";

	foreach($databeh as $dtb) {
		if($dtb >= $from) {
			$btd .= $dtb . ":";
		}
	}
	
	$behdata = array_filter(explode(":", $btd));
	$ttt = "";

	foreach ($behdata as $ttb) {
		if($ttb <= $until) {
			$ttt .= $ttb . ":";
		}
	}

	$satu = count(array_filter(explode(":", $ttt)));

	if($satu != 0) { echo $satu; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataceh = array_filter(explode(":", $c));
	$ctd = "";

	foreach($dataceh as $dtc) {
		if($dtc >= $from) {
			$ctd .= $dtc . ":";
		}
	}
	
	$cehdata = array_filter(explode(":", $ctd));
	$yyy = "";

	foreach ($cehdata as $ttc) {
		if($ttc <= $until) {
			$yyy .= $ttc . ":";
		}
	}

	$dua = count(array_filter(explode(":", $yyy)));
	
	if($dua != 0) { echo $dua; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataeeh = array_filter(explode(":", $d));
	$etd = "";

	foreach($dataeeh as $dte) {
		if($dte >= $from) {
			$etd .= $dte . ":";
		}
	}
	
	$eehdata = array_filter(explode(":", $etd));
	$rrr = "";

	foreach ($eehdata as $tte) {
		if($tte <= $until) {
			$rrr .= $tte . ":";
		}
	}

	$tiga = count(array_filter(explode(":", $rrr)));

	if($tiga != 0) { echo $tiga; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datageh = array_filter(explode(":", $e));
	$gtd = "";

	foreach($datageh as $dtg) {
		if($dtg >= $from) {
			$gtd .= $dtg . ":";
		}
	}
	
	$gehdata = array_filter(explode(":", $gtd));
	$uuu = "";

	foreach ($gehdata as $ttg) {
		if($ttg <= $until) {
			$uuu .= $ttg . ":";
		}
	}

	$empat = count(array_filter(explode(":", $uuu)));

	if($empat != 0) { echo $empat; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datajeh = array_filter(explode(":", $f));
	$jtd = "";

	foreach($datajeh as $dtj) {
		if($dtj >= $from) {
			$jtd .= $dtj . ":";
		}
	}
	
	$jehdata = array_filter(explode(":", $jtd));
	$iii = "";

	foreach ($jehdata as $ttj) {
		if($ttj <= $until) {
			$iii .= $ttj . ":";
		}
	}

	$lima = count(array_filter(explode(":", $iii)));

	if($lima != 0) { echo $lima; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datapeh = array_filter(explode(":", $g));
	$ptd = "";

	foreach($datapeh as $dtp) {
		if($dtp >= $from) {
			$ptd .= $dtp . ":";
		}
	}
	
	$pehdata = array_filter(explode(":", $ptd));
	$ooo = "";

	foreach ($pehdata as $ttp) {
		if($ttp <= $until) {
			$ooo .= $ttp . ":";
		}
	}

	$enam = count(array_filter(explode(":", $ooo)));

	if($enam != 0) { echo $enam; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>Rp ";

	$LOSTE = 0;
	$getVPLeaveOnStartToEndLN = $ki->query("select total_date, ifnull(dollar,0) as dollar from lembur_log where jenis_lembur = 'luarnegeri' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTE = $getVPLeaveOnStartToEndLN->fetch_assoc()){
		$LOSTE += ((int) $VPLOSTE['total_date'] - 1) * (int) $VPLOSTE['dollar'];
	}

	$LOSTED = 0;
	$getVPLeaveOnStartToEndLK = $ki->query("select total_date, 125000 as akomodasi from lembur_log where jenis_lembur = 'luarkota' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTED = $getVPLeaveOnStartToEndLK->fetch_assoc()){
		$LOSTED += ((int) $VPLOSTED['total_date'] - 1) * (int) $VPLOSTED['akomodasi'];
	}

	echo 
	($tunjangan['harian'] * $a) + 
	($LOSTED) + 
	($LOSTE * 25) +
	($tunjangan['weekend_sooh'] * $tiga) + 
	($tunjangan['weekend_igfs'] * $empat) + 
	($tunjangan['doubleshift'] * $lima) + 
	($tunjangan['nightshift'] * $enam) - 
	(
		($tunjangan['harian'] * $getsakit['A']) + 
		($tunjangan['harian'] * $getstaffoff['offday'])
	);
	echo "</td>";
	echo "</tr>";
}
////////////////////////////////////////////////////////////////////////////////////////////////// OTHER
echo "
<tr>
	<td colspan='8'><div style='height: 25px'></div></td>
</tr>
<tr>
	<td colspan='8'><b>Other</b></td>
</tr>";
$get_so_list = $ki->query("select id, username, occupation from users where occupation not in ('PES','IGLK','IGJKT','SO','KO') order by occupation asc, nik asc");
while($so_list = $get_so_list->fetch_assoc()) {
	$a = $workDay; 
	$b = ""; $c = ""; $d = ""; $e = ""; $f = ""; $g = "";
	$lembur_act = "";
	$get_full_name = $ki->query("select name from users where username = '".$so_list['username']."'");
	$full_name = $get_full_name->fetch_assoc();
	echo "<td>".$full_name['name']."</td>";

	$get_cuti_log = $ki->query("select total_date, tgl_start, tgl_end, tgl_list, jenis_lembur, ifnull(dollar,0) as dollar from lembur_log where user = '".$so_list['username']."' and status = 'APPROVED'");

	while($cuti_log = $get_cuti_log->fetch_assoc()) {
		if($cuti_log['jenis_lembur'] == 'luarkota') {
			$b .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'luarnegeri') {
			$c .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_sooh') {
			$d .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'weekend_igfs') {
			$e .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'doubleshift') {
			$f .= $cuti_log['tgl_list'];
		}
		if($cuti_log['jenis_lembur'] == 'nightshift') {
			$g .= $cuti_log['tgl_list'];
		}
	}
	echo "<td>".$a."</td>";
	
	$itungsakit = 
		$ki->query("select ifnull(sum(totaldate),0) as A from cuti_log where jenis_cuti in (5,6,7,8,9,10,11) and 
						tgl_cuti_from >= '".$from."' and tgl_cuti_to <= '".$until."' and
						user = '".$so_list['username']."' and status = 'APPROVED';
						");
	$getsakit = $itungsakit->fetch_assoc();

	$itungstaffoff = $ki->query("select count(*) as offday from staffoff_log where user = ".$so_list['id']." and (date between '".$from."' and '".$until."') and status = 'OFF'");
	$getstaffoff = $itungstaffoff->fetch_assoc();
	$absentTotal = $getsakit['A'] + $getstaffoff['offday'];

	echo "<td>"; if($absentTotal != 0) { echo $absentTotal; } echo "</td>";

	echo "<td>";
	///////////////////////////////////////////////
	$databeh = array_filter(explode(":", $b));
	$btd = "";

	foreach($databeh as $dtb) {
		if($dtb >= $from) {
			$btd .= $dtb . ":";
		}
	}
	
	$behdata = array_filter(explode(":", $btd));
	$ttt = "";

	foreach ($behdata as $ttb) {
		if($ttb <= $until) {
			$ttt .= $ttb . ":";
		}
	}

	$satu = count(array_filter(explode(":", $ttt)));

	if($satu != 0) { echo $satu; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataceh = array_filter(explode(":", $c));
	$ctd = "";

	foreach($dataceh as $dtc) {
		if($dtc >= $from) {
			$ctd .= $dtc . ":";
		}
	}
	
	$cehdata = array_filter(explode(":", $ctd));
	$yyy = "";

	foreach ($cehdata as $ttc) {
		if($ttc <= $until) {
			$yyy .= $ttc . ":";
		}
	}

	$dua = count(array_filter(explode(":", $yyy)));
	
	if($dua != 0) { echo $dua; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$dataeeh = array_filter(explode(":", $d));
	$etd = "";

	foreach($dataeeh as $dte) {
		if($dte >= $from) {
			$etd .= $dte . ":";
		}
	}
	
	$eehdata = array_filter(explode(":", $etd));
	$rrr = "";

	foreach ($eehdata as $tte) {
		if($tte <= $until) {
			$rrr .= $tte . ":";
		}
	}

	$tiga = count(array_filter(explode(":", $rrr)));

	if($tiga != 0) { echo $tiga; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datageh = array_filter(explode(":", $e));
	$gtd = "";

	foreach($datageh as $dtg) {
		if($dtg >= $from) {
			$gtd .= $dtg . ":";
		}
	}
	
	$gehdata = array_filter(explode(":", $gtd));
	$uuu = "";

	foreach ($gehdata as $ttg) {
		if($ttg <= $until) {
			$uuu .= $ttg . ":";
		}
	}

	$empat = count(array_filter(explode(":", $uuu)));

	if($empat != 0) { echo $empat; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datajeh = array_filter(explode(":", $f));
	$jtd = "";

	foreach($datajeh as $dtj) {
		if($dtj >= $from) {
			$jtd .= $dtj . ":";
		}
	}
	
	$jehdata = array_filter(explode(":", $jtd));
	$iii = "";

	foreach ($jehdata as $ttj) {
		if($ttj <= $until) {
			$iii .= $ttj . ":";
		}
	}

	$lima = count(array_filter(explode(":", $iii)));

	if($lima != 0) { echo $lima; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>";
	///////////////////////////////////////////////
	$datapeh = array_filter(explode(":", $g));
	$ptd = "";

	foreach($datapeh as $dtp) {
		if($dtp >= $from) {
			$ptd .= $dtp . ":";
		}
	}
	
	$pehdata = array_filter(explode(":", $ptd));
	$ooo = "";

	foreach ($pehdata as $ttp) {
		if($ttp <= $until) {
			$ooo .= $ttp . ":";
		}
	}

	$enam = count(array_filter(explode(":", $ooo)));

	if($enam != 0) { echo $enam; }
	///////////////////////////////////////////////
	echo "</td>";
	echo "<td>Rp ";

	$LOSTE = 0;
	$getVPLeaveOnStartToEndLN = $ki->query("select total_date, ifnull(dollar,0) as dollar from lembur_log where jenis_lembur = 'luarnegeri' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTE = $getVPLeaveOnStartToEndLN->fetch_assoc()){
		$LOSTE += ((int) $VPLOSTE['total_date'] - 1) * (int) $VPLOSTE['dollar'];
	}

	$LOSTED = 0;
	$getVPLeaveOnStartToEndLK = $ki->query("select total_date, 125000 as akomodasi from lembur_log where jenis_lembur = 'luarkota' and user = '".$so_list['username']."' and status = 'APPROVED' and tgl_input between '".$from."' and '".$until."'");
	while($VPLOSTED = $getVPLeaveOnStartToEndLK->fetch_assoc()){
		$LOSTED += ((int) $VPLOSTED['total_date'] - 1) * (int) $VPLOSTED['akomodasi'];
	}

	echo 
	($tunjangan['harian'] * $a) + 
	($LOSTED) + 
	($LOSTE * 25) +
	($tunjangan['weekend_sooh'] * $tiga) + 
	($tunjangan['weekend_igfs'] * $empat) + 
	($tunjangan['doubleshift'] * $lima) + 
	($tunjangan['nightshift'] * $enam) - 
	(
		($tunjangan['harian'] * $getsakit['A']) + 
		($tunjangan['harian'] * $getstaffoff['offday'])
	);
	echo "</td>";
	echo "</tr>";
}
?>
</tbody>
</table>
<br><br><br>

<?php
include "__footer.php";
?>