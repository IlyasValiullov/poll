var myround=function(t,o){var e=Math.pow(10,o),n=t*e;return Math.round(n)/e},refresh_data=function(){console.log("project ready!"),$("tbody tr").empty(),$.get("results.json").done(function(t){console.log(t),$.each(t,function(t,o){var e=myround(o.answer_count/o.all_answer_count*100,1),n=e.toFixed(1).toString();$("tbody").append('<tr style="display: none;">\t  \t\t\t   <td class="col-md-8">'+o.question+'</td>\t  \t\t\t   <td class="col-md-1">'+o.answer+'</td>\t  \t\t\t   <td class="col-md-1">'+o.answer_count.toString()+'</td>\t  \t\t\t   <td class="col-md-1">'+n+"</td>\t  \t\t\t</tr>")}),$("tbody tr").show("highlight")})};$(document).ready(function(){console.log("project ready!"),setInterval(refresh_data,5e3),$("#refresh").click(refresh_data)});