<?php
$module = array("title" => "Report Health Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 
?>

<div class='container-fluid'>
<h3>Active Periode 2016</h3>
<table width='100%' class='table'>
<thead>
<tr>
<th>NIK</th><th>Name</th><th>Health Limit</th><th>Jan</th><th>Feb</th><th>Mar</th><th>Apr</th><th>May</th>
<th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th>
</tr>
<?php
$getFullnameAndLimit = $ki->query("select a.nik as nik, a.name as name, a.username as username, b.health as quota from users a inner join `limit` b on a.username = b.username order by nik asc");
while($FNL = $getFullnameAndLimit->fetch_assoc()) {
	echo "<tr>";
	echo "<td>".$FNL['nik']."</td>";
	echo "<td>".$FNL['name']."</td>";
	echo "<td>".$FNL['quota']."</td>";
	
	$thisyear = '2016';
	#get sum(total) each month
	for($x=1;$x<=11;$x++){
		${'getSumEachMonth' . $x} = 
		$ki->query("select sum(a.jumlah) as bulanan, b.no_claim as no_claim, b.status_dok as status_dok 
			from claim_kesehatan_detail a inner join claim_kesehatan b on a.no_claim = b.no_claim 
			where month(a.tgl) = ".$x." and year(a.tgl) = ".$thisyear." and b.status_dok = 'PAID' and b.username = '".$FNL['username']."'");
		${'SEM' . $x} = ${'getSumEachMonth' . $x}->fetch_assoc();
	}

	$setJanuary 	= (int) $FNL['quota'] - (int) $SEM1['bulanan'];
	$setFebruary 	= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan']);
	$setMarch 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan']);
	$setApril 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan']);
	$setMay 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan']);
	$setJune 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan']);
	$setJuly 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan']);
	$setAugust 		= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan'] + (int) $SEM8['bulanan']);
	$setSeptember 	= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan'] + (int) $SEM8['bulanan'] + (int) $SEM9['bulanan']);
	$setOctober 	= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan'] + (int) $SEM8['bulanan'] + (int) $SEM9['bulanan'] + (int) $SEM10['bulanan']);
	$setNovember 	= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan'] + (int) $SEM8['bulanan'] + (int) $SEM9['bulanan'] + (int) $SEM10['bulanan'] + (int) $SEM11['bulanan']);

	$getSumEachMonth12 = $ki->query("
		select sum(a.jumlah) as bulanan, b.no_claim as no_claim, b.status_dok as status_dok 
			from claim_kesehatan_detail a inner join claim_kesehatan b on a.no_claim = b.no_claim 
			where month(a.tgl) = 12 and year(a.tgl) = ".$thisyear." and b.status_dok = 'PAID' and b.username = '".$FNL['username']."'");
	$SEM12 = $getSumEachMonth12->fetch_assoc();

	$setDecember 	= (int) $FNL['quota'] - ((int) $SEM1['bulanan'] + (int) $SEM2['bulanan'] + (int) $SEM3['bulanan'] + (int) $SEM4['bulanan'] + (int) $SEM5['bulanan'] + (int) $SEM6['bulanan'] + (int) $SEM7['bulanan'] + (int) $SEM8['bulanan'] + (int) $SEM9['bulanan'] + (int) $SEM10['bulanan'] + (int) $SEM11['bulanan'] + (int) $SEM12['bulanan']);

	echo "<td>".$setJanuary."</td>";
	echo "<td>".$setFebruary."</td>";
	echo "<td>".$setMarch."</td>";
	echo "<td>".$setApril."</td>";
	echo "<td>".$setMay."</td>";
	echo "<td>".$setJune."</td>";
	echo "<td>".$setJuly."</td>";
	echo "<td>".$setAugust."</td>";
	echo "<td>".$setSeptember."</td>";
	echo "<td>".$setOctober."</td>";
	echo "<td>".$setNovember."</td>";
	echo "<td>".$setDecember."</td>";
	echo "</tr>";
}
	////////////////////////////////////////////////////////////////////////////////////// TOTAL (no percentage)

	echo "<tr>";
	echo "<td><b>Total</b></td><td></td><td></td>";

	#get all quota, combined
	$getAllLimit = $ki->query("select sum(health) as fullquota from `limit`");
	$gAL = $getAllLimit->fetch_assoc();

	#get all use monthly
	for($x=1;$x<=12;$x++){
		${'getTotalEachMonth' . $x} = 
		$ki->query("select ifnull(sum(a.jumlah),0) as bulanan, b.no_claim as no_claim, b.status_dok as status_dok 
			from claim_kesehatan_detail a inner join claim_kesehatan b on a.no_claim = b.no_claim 
			where month(a.tgl) = ".$x." and year(a.tgl) = ".$thisyear." and b.status_dok = 'PAID'");
		${'TOM' . $x} = ${'getTotalEachMonth' . $x}->fetch_assoc();
	}

	$tomJan = (int) $gAL['fullquota'] - (int) $TOM1['bulanan'];
	$tomFeb = (int) $gAL['fullquota'] - (int) $TOM2['bulanan'];
	$tomMar = (int) $gAL['fullquota'] - (int) $TOM3['bulanan'];
	$tomApr = (int) $gAL['fullquota'] - (int) $TOM4['bulanan'];
	$tomMay = (int) $gAL['fullquota'] - (int) $TOM5['bulanan'];
	$tomJun = (int) $gAL['fullquota'] - (int) $TOM6['bulanan'];
	$tomJul = (int) $gAL['fullquota'] - (int) $TOM7['bulanan'];
	$tomAug = (int) $gAL['fullquota'] - (int) $TOM8['bulanan'];
	$tomSep = (int) $gAL['fullquota'] - (int) $TOM9['bulanan'];
	$tomOct = (int) $gAL['fullquota'] - (int) $TOM10['bulanan'];
	$tomNov = (int) $gAL['fullquota'] - (int) $TOM11['bulanan'];
	$tomDec = (int) $gAL['fullquota'] - (int) $TOM12['bulanan'];

	echo "<td>".$tomJan."</td>";
	echo "<td>".$tomFeb."</td>";
	echo "<td>".$tomMar."</td>";
	echo "<td>".$tomApr."</td>";
	echo "<td>".$tomMay."</td>";
	echo "<td>".$tomJun."</td>";
	echo "<td>".$tomJul."</td>";
	echo "<td>".$tomAug."</td>";
	echo "<td>".$tomSep."</td>";
	echo "<td>".$tomOct."</td>";
	echo "<td>".$tomNov."</td>";
	echo "<td>".$tomDec."</td>";
	echo "</tr>";

	////////////////////////////////////////////////////////////////////////////////////// Approved Max Limit

	echo "<tr>";
	echo "<td colspan='2'><b>Actual Approved Limit</b></td>";
	echo "<td>";

	#get total uses budget
	$getTotalUseBudget = $ki->query("select sum(health) as UB from `limit`");
	$TUB = $getTotalUseBudget->fetch_assoc();

	echo $TUB['UB'];
	echo "</td>";

	#empty td x 12
	for($empty=1;$empty<=12;$empty++){
		echo "<td></td>";
	}
	echo "</tr>";

	//////////////////////////////////////////////////////////////////////////////////////  TOTAL (percentage)

	echo "<tr>";
	echo "<td colspan='2'><b>Percentage</b></td><td></td>";

	#get all quota, combined
	$getAllLimit = $ki->query("select sum(health) as fullquota from `limit`");
	$gAL = $getAllLimit->fetch_assoc();

	#get all use monthly
	for($x=1;$x<=12;$x++){
		${'getTotalEachMonth' . $x} = 
		$ki->query("select ifnull(sum(a.jumlah),0) as bulanan, b.no_claim as no_claim, b.status_dok as status_dok 
			from claim_kesehatan_detail a inner join claim_kesehatan b on a.no_claim = b.no_claim 
			where month(a.tgl) = ".$x." and year(a.tgl) = ".$thisyear." and b.status_dok = 'PAID'");
		${'TEM' . $x} = ${'getTotalEachMonth' . $x}->fetch_assoc();
	}

	$temJan = ((int) $TEM1['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temFeb = ((int) $TEM2['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temMar = ((int) $TEM3['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temApr = ((int) $TEM4['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temMay = ((int) $TEM5['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temJun = ((int) $TEM6['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temJul = ((int) $TEM7['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temAug = ((int) $TEM8['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temSep = ((int) $TEM9['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temOct = ((int) $TEM10['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temNov = ((int) $TEM11['bulanan'] / (int) $gAL['fullquota']) * 100;
	$temDec = ((int) $TEM12['bulanan'] / (int) $gAL['fullquota']) * 100;

	echo "<td>".number_format($temJan,2)."%</td>";
	echo "<td>".number_format($temFeb,2)."%</td>";
	echo "<td>".number_format($temMar,2)."%</td>";
	echo "<td>".number_format($temApr,2)."%</td>";
	echo "<td>".number_format($temMay,2)."%</td>";
	echo "<td>".number_format($temJun,2)."%</td>";
	echo "<td>".number_format($temJul,2)."%</td>";
	echo "<td>".number_format($temAug,2)."%</td>";
	echo "<td>".number_format($temSep,2)."%</td>";
	echo "<td>".number_format($temOct,2)."%</td>";
	echo "<td>".number_format($temNov,2)."%</td>";
	echo "<td>".number_format($temDec,2)."%</td>";
	echo "</tr>";


?>

</table>
</div>

<?php
include "__footer.php";
?>