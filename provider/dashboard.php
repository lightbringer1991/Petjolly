<?php
defined('APPHP_EXEC') or die('Restricted Access');

if($objLogin->IsLoggedInAsDoctor()){
    draw_title_bar(prepare_breadcrumbs(array(_DASHBOARD=>'')));
	$action = $_REQUEST['mode'];
	if ($action == 'chart') {
?>
<style type="text/css">
.fnameShow {
	color: blue;
	font-weight: bold;
}

thead th.c_table {

}
</style>

<div class="row">
	<div class="col-md-6 col-sm-12">
		<div id="summaryTable_container"></div>
	</div>
	<div class="col-md-6 col-sm-12">
		<div id="summaryChart_container"></div>
	</div>
</div>
<!--<div id="summaryChart_container" style="min-width: 310px; height: 400px; margin: 0 auto"></div> -->

<script type="text/javascript">
$(document).ready(function() {
	renderChartAndTable($('#summaryChart_container'), $("#summaryTable_container"));
});
</script>

<?php
	}	// end action == 'chart'
}
?>