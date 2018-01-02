$(document).ready(function() {
		$(chart_id).highcharts({
			chart: chart,
			title: title,
			xAxis: xAxis,
			yAxis: yAxis,
			series: series
		});
		//values();
});

function values() {
  $.get("/_random_temperature",
	function(data) {
		$("#reading").text(data.temperature+" °C")
	});
};

function start_update() {
	values();
	reading=setInterval(values,2000)
};

function stop_update() {
	clearInterval(reading);
	$("#reading").text("Stopped!")
}
