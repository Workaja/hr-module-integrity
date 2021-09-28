<?php
$module = array("title" => "Report Variable Pay Claim", "appname" => "HR");
include "__header.php";

$owner = array(5,6,99);
if(in_array($_SESSION['fprv'], $owner)) { } else { echo "<script>window.location.replace('index.php');</script>"; } 

?>

<div class="container-fluid">
<h3>Active Periode 2016</h3>

<div class="row">
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">December 2016 - January 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=12&sy=2016&em=1&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">January 2017 - February 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=1&sy=2017&em=2&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">February 2017 - March 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=2&sy=2017&em=3&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">March 2017 - April 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=3sy=2017&em=4&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">April 2017 - May 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=4&sy=2017&em=5&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">May 2017 - June 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=5&sy=2017&em=6&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">June 2017 - July 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=6&sy=2017&em=7&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">July 2017 - August 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=7&sy=2017&em=8&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">August 2017 - September 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=8&sy=2017&em=9&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">September 2017 - October 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=9&sy=2017&em=10&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">October 2017 - November 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=10&sy=2017&em=11&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">November 2017 - December 2017</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=11&sy=2017&em=12&ey=2017' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">December 2017 - January 2018</div>
			<div class="panel-body">
				<a href='report_vpay.php?sm=12&sy=2017&em=1&ey=2018' class="btn btn-primary btn-sm btn-block">Generate This</a>
			</div>
		</div>
	</div>
</div>

</div>

<?php
include "__footer.php";
?>