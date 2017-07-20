// var myround = {};

// myround.round = 

var myround = function(number, precision) {
    var factor = Math.pow(10, precision);
    var tempNumber = number * factor;
    var roundedTempNumber = Math.round(tempNumber);
    return roundedTempNumber / factor;
};

var refresh_data = function(){
		console.log( "project ready!" );
    

		$("tbody tr").empty();

		$.get("results.json").done(
			function( data ) {
				console.log(data);
				$.each(data,function(index, value){
					var rounded_int = myround(((value.answer_count / value.all_answer_count)*100),1);
					var rounded = rounded_int.toFixed(1).toString();

					$("tbody").append(
					`<tr style="display: none;">
	  			   <td class="col-md-8">`+ value.question +`</td>
	  			   <td class="col-md-1">`+ value.answer +`</td>
	  			   <td class="col-md-1">`+ value.answer_count.toString() +`</td>
	  			   <td class="col-md-1">`+ rounded +`</td>
	  			</tr>`);
	  			});

					$("tbody tr").show("highlight");

 		});
};

$( document ).ready(function() {
  console.log( "project ready!" );
  setInterval(refresh_data, 5 * 1000); // 60 * 1000 milsec
	$("#refresh").click(refresh_data);
		// <tr>
  //     <td class="col-md-8">New ques</td>
  //     <td class="col-md-1">asn</td>
  //     <td class="col-md-1">0</td>
  //     <td class="col-md-1">0.0</td>
  //   </tr>


  //   var field = this;
  //   $.ajax( $('.simple_form').prop('action'), {
  //     method: 'PATCH',
  //     data: {project: {action: "do_invest", amount: $('#invest_amount')[0].value}},
  //     dataType: 'json',
  //     success: function(data){
  //       console.log(data.location);
  //       window.location.href = data.location;
  //     }
  //   } );
  
});