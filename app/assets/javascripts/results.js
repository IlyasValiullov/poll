var myround = function(number, precision) {
    var factor = Math.pow(10, precision);
    var tempNumber = number * factor;
    var roundedTempNumber = Math.round(tempNumber);
    return roundedTempNumber / factor;
};

var refresh_data = function(){
		$.get("results.json").done(
			function( data ) {
				$("tbody tr").empty();
				$.each(data,function(index, value){
					var rounded_int = myround(((value.answer_count / value.all_answer_count)*100),1);
					var rounded = rounded_int.toFixed(1).toString();

					$("tbody").append(
					"<tr style=\"display: none;\">\
	  			   <td class=\"col-md-8\">"+ value.question +"</td>\
	  			   <td class=\"col-md-1\">"+ value.answer +"</td>\
	  			   <td class=\"col-md-1\">"+ value.answer_count.toString() +"</td>\
	  			   <td class=\"col-md-1\">"+ rounded +"</td>\
	  			</tr>");
	  			});

					$("tbody tr").show("highlight");

 		});
};

$( document ).ready(function() {
  setInterval(refresh_data, 5 * 1000);
	$("#refresh").click(refresh_data);
});