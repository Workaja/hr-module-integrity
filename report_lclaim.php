<?php
$module = array("title" => "Report Health Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

$year = 2016;
$neyr = 2017;
?>
<style type="text/css">
	.v_title{background-color: #e0e1e2;}
</style>

<div class="container-fluid">
<h3>Active Periode 2016</h3>
<table width="100%" class="table">
<!-- Header -->
<thead>
<tr>
	<th rowspan="2" style="vertical-align: middle;">No</th>
	<th rowspan="2" style="vertical-align: middle;">NIK</th>
	<th rowspan="2" style="vertical-align: middle;">Name</th>
	<th rowspan="2" style="vertical-align: middle;">Leave<br>Entitlement</th>
	<th colspan="12" style="vertical-align: middle;"><center>Months</center></th>
	<th rowspan="2" style="vertical-align: middle;">Total</th>
	<th rowspan="2" style="vertical-align: middle;">Remaining</th>
</tr>
<tr>
	<!-- Below of #Months# -->
	<th>JAN</th><th>FEB</th><th>MAR</th><th>APR</th><th>MAY</th><th>JUN</th><th>JUL</th><th>AUG</th><th>SEP</th><th>OCT</th><th>NOV</th><th>DEC</th>
</tr>
</thead>
<!-- Body -->
<tbody>
<?php
//add variable to list_jenis
$list_jenis = "";
//get jenis cuti that used on cuti log, requirement : not rejected and on 2016 period
$get_used_jenis = $ki->query("select jenis_cuti from cuti_log where status = 'APPROVED' and periode = ".$year);
//print the result into list_jenis variable
while($used_jenis = $get_used_jenis->fetch_assoc()) {
	$list_jenis .= $used_jenis['jenis_cuti'] . ",";
}
//remove last comma inside of list_jenis variable
$jenis_cuti_list = substr($list_jenis, 0, -1);
//get id, jenis_cuti where periode 2016 and jenis cuti id in list jenis (called by $jenis_cuti_list, look above)
$get_jenis_cuti = $ki->query("select id, jenis_cuti from cuti_jenis where periode = ".$year." and id in (".$jenis_cuti_list.")");
if($get_jenis_cuti == NULL) {
	header("Location: report.php");
}
while($jenis_cuti = $get_jenis_cuti->fetch_assoc()) {
	echo "<tr>";
	//every jenis cuti, called the description and print out as row on table
	echo "<td colspan='18' class='v_title'><b>Leave Type : ".$jenis_cuti['jenis_cuti']."</b></td>";
	echo "</tr>";
	//get our users list based on jenis cuti they made
	$get_user_list = $ki->query("select a.user as user, b.nik as nik, b.name as name from cuti_log a inner join users b on a.user = b.username where a.status = 'APPROVED' and a.jenis_cuti = ".$jenis_cuti['id']." group by a.user order by b.nik asc");
	//create numbering variable to give numbering in each list of jenis cuti
	$numbering = 0;
	while($user_list = $get_user_list->fetch_assoc()) {
		echo "<tr>";
		//print the numbering, add 1 for every nik and name
		echo "<td>".++$numbering."</td>";
		echo "<td>".$user_list['nik']."</td>";
		echo "<td>".$user_list['name']."</td>";

		//call table name if related to jenis cuti
		switch($jenis_cuti['id']) {
			case '1':
  			$tbd = 'quota_nonworkdaybefore'; //sisa izin masuk tahun 2015
  			break;
  			case '2':
  			$tbd = 'quota_nonworkday'; //cuti tukar day off / izin masuk hari libur 2016
  			break;
  			case '3':
  			$tbd = 'quota_remainbefore'; //sisa cuti tahun 2015
  			break;
  			case '4':
  			$tbd = 'quota_cuti'; //cuti tahun 2016
  			break;
  			case '5':
  			$tbd = 'quota_sick'; //cuti sakit
  			break;
  			case '6':
  			$tbd = 'quota_wedding'; //cuti menikah
  			break;
  			case '7':
  			$tbd = 'quota_wedding2'; //cuti menikahkan/wali anak
  			break;
  			case '8':
  			$tbd = 'quota_kidbless'; //cuti khitan atau baptis
  			break;
  			case '9':
  			$tbd = 'quota_maternity'; //cuti melahirkan
  			break;
  			case '10':
  			$tbd = 'quota_internaldecease'; //cuti anggota keluarga inti meninggal
  			break;
  			case '11':
  			$tbd = 'quota_onehomedecease'; //cuti anggota keluarga serumah meninggal
  			break;
  		}
  		//sum the quota of jenis cuti based on users that listed above
		$get_jenis_quota = $ki->query("select sum(".$tbd.") as quota from cuti_quota where user = '".$user_list['user']."';");
		$jenis_quota = $get_jenis_quota->fetch_assoc(); 
		echo "<td class='sum'>".$jenis_quota['quota']."</td>";

		for($mo=1;$mo<=12;$mo++) {
			//variable, ambil dari POST form
			$varBulan 	= $mo;
			$varTahun 	= $year;
			$varUser 	= $user_list['user'];
			#echo "Laporan Cuti $varUser  periode $varBulan - $varTahun<br>";

			//SELECT 1 : ambil cuti yg FROM dan TO dibulan yg sama
			$jmlCuti1 = 0;
			$q1 = $ki->query("SELECT * FROM cuti_log where month(tgl_cuti_from) = '$varBulan' AND month(tgl_cuti_to) = '$varBulan' AND year(tgl_cuti_from) = '$varTahun' AND user = '$varUser' and status = 'APPROVED'");
			while ($r1 = $q1->fetch_assoc()) {
				#echo $r1['totaldate'] ."<br>";
				$jmlCuti1 += $r1['totaldate'];
			}
			#echo "Total Cuti SELECT 1 : $jmlCuti1";
			#echo "<hr>";
			//exit;


			//SELECT 2 :ambil cuti yg FROM = varBulan dan TP <> varBulan
			$jmlCuti2 = 0;
			//ambil hari terakhir dari varBulan
			$tmpTgl = $varTahun . '-' . $varBulan . '-01';
			$d = new DateTime($tmpTgl);
			$day = $d->format( 'Y-m-t' );
			$jmlHariDalamBulan = date("d",strtotime($day));
			$tglAkhirDalamBulan = $varTahun . '-' . $varBulan . '-' .$jmlHariDalamBulan;
			//echo "Jml hari : $jmlHari</br>"; DAPET!

			$q2 = $ki->query("SELECT * FROM cuti_log where month(tgl_cuti_from) = '$varBulan' AND month(tgl_cuti_to) <> '$varBulan' AND year(tgl_cuti_from) = '$varTahun' AND user = '$varUser' and status = 'APPROVED'");
			while ($r2 = $q2->fetch_assoc()) {
				//crosscheck ke table kalender apakah ada tgl merah 
				$fromDate = $r2['tgl_cuti_from'];
				$toDate = $r2['tgl_cuti_to'];
				#echo $fromDate ."-". $jmlHariDalamBulan;
				$qmerah = $ki->query("SELECT count(*) FROM `kalender` WHERE (tanggal BETWEEN '$fromDate' AND '$tglAkhirDalamBulan') AND merah = 'Y'");
				$rmerah = $qmerah->fetch_row();
				$jmlMerah = $rmerah[0];
				#echo "<br>Jml Merah : $jmlMerah<br>";
				
				//ambil hari fromDate
				$fromDateHariSaja = date("d",strtotime($fromDate));
				//echo $fromDateHariSaja; echo $fromDate; exit;
				//kalkulasi jumlah cuti
				$tmpJmlCuti = $jmlHariDalamBulan - $fromDateHariSaja +1 - $jmlMerah;
				#echo "tmpJmlCuti : " . $tmpJmlCuti . "<br>";
				$jmlCuti2 += $tmpJmlCuti;

			}
			#echo "Jumlah Cuti SELECT 2  : $jmlCuti2<br>";
			#echo "<hr>";
			//exit;
			#echo "<td class='sum'>".$jmlCuti2."</td>";


			//SELCT 3 :  ambil cuti yg from <> varBulan dan to = varBulan
			#echo "SELECT 3<br>";
			$jmlCuti3 = 0;
			$tglAwalDalamBulan = $varTahun . '-' . $varBulan . '-01';
			#echo $tglAwalDalamBulan; echo "<br>";
			$q3 = $ki->query("SELECT * FROM cuti_log where month(tgl_cuti_from) <> '$varBulan' AND month(tgl_cuti_to) = '$varBulan' AND year(tgl_cuti_to) = '$varTahun' AND user = '$varUser' and status = 'APPROVED'");
			while ($r3 = $q3->fetch_assoc()) {
				#echo $r3['totaldate']; echo "<br>";
				
				//crosscheck ke table kalender apakah ada tgl merah
				$toDate = $r3['tgl_cuti_to'];	
				$qmerah = $ki->query("SELECT count(*) FROM `kalender` WHERE (tanggal BETWEEN '$tglAwalDalamBulan' AND '$toDate') AND merah = 'Y'");
			        $rmerah = $qmerah->fetch_row();
			        $jmlMerah = $rmerah[0];
			        #echo "<br>Jml Merah : $jmlMerah<br>";
				//kalkulasi jumlah cuti bulan ini
				$hariAkhirToDate = date("d", strtotime($toDate));
				$tmpJmlCuti = $hariAkhirToDate - $jmlMerah;
				$jmlCuti3 += $tmpJmlCuti;
			}
			#echo " Jumlah Cuti SELECT 3 : $jmlCuti3<br>";
			$totCuti = $jmlCuti1 + $jmlCuti2 + $jmlCuti3;
			#echo "<hr>";
			#echo "Total cuti $varUser bulan $varBulan - $varTahun adalah " . $totCuti;
			echo "<td class='sum'>".$totCuti."</td>";
		}


		$get_total_nrem = $ki->query("select (select ifnull(sum(totaldate),0) from cuti_log where user = '".$user_list['user']."' and tgl_cuti_from >= '".$year."-01-01' and tgl_cuti_to < '".$neyr."-01-01' and status = 'APPROVED' and jenis_cuti = ".$jenis_cuti['id'].") as `ttl`,
		(select ifnull(sum(".$tbd."),0) from cuti_quota where user = '".$user_list['user']."') - (select ifnull(sum(totaldate),0) from cuti_log where user = '".$user_list['user']."' and tgl_cuti_from >= '".$year."-01-01' and tgl_cuti_to < '".$neyr."-01-01' and status = 'APPROVED' and jenis_cuti = ".$jenis_cuti['id'].") as `rem`
		");
		$total_nrem = $get_total_nrem->fetch_assoc();
		#echo "<td class='sum'>".$totCuti."</td>";
		echo "<td class='sum'>".$total_nrem['ttl']."</td>";
		echo "<td class='sum'>".$total_nrem['rem']."</td>";
		echo "</tr>";
	}
	//add space after last list (name)
	echo "<tr><td colspan='18'><div style='height: 10px'></div></td></tr>";
}
?>

</tbody>

</table>
</div>

<?php
include "__footer.php";
?>