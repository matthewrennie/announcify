$( document ).ready(function() {

	//determine if we are on the statistics page
	if(!$('#announcement_statistics').length > 0)
		return;		

  var updateStatistics = function() {
  	$.getJSON( '/announcements/summary.json', {
	    format: "json"
	  })
	  .done(function( data ) {
	  	//update the statistics  	
	  	$("#n_impressions").text(""+data.n_impressions)
	  	$("#n_clicks").text(""+data.n_clicks)
	  	$("#n_events").text(""+data.n_events)
	  });
	  _.delay(updateStatistics, 5000);	
  }

  _.delay(updateStatistics, 2000);	

});