---
title       : Visualizing sampling strategies
subtitle    : An aid to explain sampling strategies
author      : Oscar de León
job         : Developing data products
framework   : io2012
highlighter : highlight.js
hitheme     : GitHub 
mode        : selfcontained
ext_widgets : {rCharts: "libraries/dataTables"}
---

## What is this application for?

This shiny application is intended as a didactic tool to help visualize some sampling strategies. A dataset is provided and a responsive interface presented to explore some variables and visualize which elements get selected.

The application provides examples of sampling strategies commonly used in surveys. The dataset itself represents a sample of the US population, but for the purposes of this application is presented as data on a complete fictious population (which wierdly resembles the US population).

The data comes from the [National Health and Nutrition Examination Survey](http://wwwn.cdc.gov/nchs/nhanes/search/nhanes11_12.aspx). It includes 4000 observations about demographic information (age, sex, poverty status) and dietary practices (daily energy [calories], protein, carbs and fat intake) of US individuals.

You can access the app in [https://odeleon.shinyapps.io/sampling/](https://odeleon.shinyapps.io/sampling/).

---

## What can you expect from this application

This app was prepared as a course project for the [Developing data products](https://www.coursera.org/course/devdataprod) course.

It was designed for use as a resource to visually explain some common survey sampling methodologies in a lecture I am sometimes invited to give in a research methodologies course at the university I work in.

You can access the source code for the application in a [github repo](https://github.com/odeleongt/sampling_shinyapp). The source code for this presentation is found on the `gh-pages` branch of that same repository.


---

The application has widgets to select which variables are mapped to the plot axes and point color (or plot facet), and to select the sampling strategy to visualize and enable highlighting of "selected individuals".

Follows an image depicting a plot obtained from the application, showing the "population" faceted by poverty level, with red circles highlighting the individuals selected by simple random sampling:

![Example plot](./content/example.png)

---

## Future development

<div style='float:left;width:78%;'>


<p>The application could be further developed to include:</p>

<ul>
<li><p>More sampling strategies and some theory / math behind each sampling strategy</p></li>
<li><p>More example data, such as the <code>quakes</code> dataset which is shipped with base R and a sample shown below using the <code>rCharts</code> package:</p></li>
</ul>

</div>
<div style='float:right;width:18.5%;border:3px solid red;'>
<b>Vote on the poll!</b><div style='height:10px'></div>

<form method="post" action="http://poll.pollcode.com/62814758"> <div style="background-color:#EEEEEE;padding:2px;width:175px;font-family:Arial;font-size:small;color:#000000;"> <div style="padding:2px 0px 4px 2px;"><strong><b>Which dataset will be included next?</b></strong></div>  <input type="radio" name="answer" value="1" id="answer628147581" style="float:left;" /> <label for="answer628147581" style="float:left;width:150px;">airquality</label> <div style="clear:both;height:2px;"></div>  <input type="radio" name="answer" value="2" id="answer628147582" style="float:left;" /> <label for="answer628147582" style="float:left;width:150px;">quakes</label> <div style="clear:both;height:2px;"></div>  <input type="radio" name="answer" value="3" id="answer628147583" style="float:left;" /> <label for="answer628147583" style="float:left;width:150px;">faithful</label> <div style="clear:both;height:2px;"></div>  <div align="center" style="padding:3px;"> <input type="submit" value=" Vote "> </div>  </div></form>

</div>


</div>
<div style='float:left;width:51%;'>

<pre><code style='font-size: 80%;'>library(package = rCharts)
n1 &lt;- dTable(quakes[sample(1:nrow(quakes), 100), ],
             iDisplayLength = 5,
             bLengthChange = FALSE,
             bFilter = FALSE,
             bInfo = FALSE,
             width = &quot;100%&quot;)
n1$print(&#39;chart1&#39;)
</code></pre>
</div>
<div style='float:right;width:45%;'>




<table id = 'chart1' class = 'rChart datatables'></table>
<script type="text/javascript" charset="utf-8">
  var chartParamschart1 = {
 "dom": "chart1",
"width":    800,
"height":    400,
"table": {
 "aaData": [
 [
 -16.24,
167.95,
188,
   5.1,
68 
],
[
  -23.2,
 184.8,
97,
   4.5,
13 
],
[
 -21.68,
180.63,
617,
     5,
63 
],
[
 -29.33,
182.72,
57,
   5.4,
61 
],
[
 -13.84,
170.62,
638,
   4.6,
20 
],
[
 -23.44,
 184.6,
63,
   4.8,
27 
],
[
 -28.15,
 183.4,
57,
     5,
32 
],
[
 -20.57,
181.33,
605,
   4.3,
18 
],
[
 -17.95,
184.68,
260,
   4.4,
21 
],
[
 -21.71,
183.58,
234,
   4.7,
55 
],
[
 -20.76,
185.77,
118,
   4.6,
15 
],
[
 -23.45,
180.23,
520,
   4.2,
19 
],
[
 -15.85,
185.13,
290,
   4.6,
29 
],
[
 -21.78,
183.11,
225,
   4.6,
21 
],
[
 -21.23,
181.09,
613,
   4.6,
18 
],
[
 -18.06,
181.59,
604,
   4.5,
23 
],
[
  -15.7,
 185.1,
70,
   4.1,
15 
],
[
 -29.09,
 183.2,
54,
   4.6,
23 
],
[
 -19.88,
 184.3,
161,
   4.4,
17 
],
[
 -26.67,
 182.4,
186,
   4.2,
17 
],
[
 -15.75,
185.23,
280,
   4.5,
28 
],
[
 -25.28,
181.17,
367,
   4.3,
25 
],
[
 -23.73,
   183,
118,
   4.3,
11 
],
[
 -22.09,
180.38,
590,
   4.9,
35 
],
[
 -20.36,
186.16,
102,
   4.3,
21 
],
[
 -10.78,
 166.1,
195,
   4.9,
45 
],
[
 -21.27,
173.49,
48,
   4.9,
42 
],
[
 -17.47,
179.59,
622,
   4.3,
19 
],
[
 -20.27,
181.51,
609,
   4.4,
32 
],
[
 -27.75,
182.26,
174,
   4.5,
18 
],
[
 -27.98,
181.96,
53,
   5.2,
89 
],
[
 -11.55,
 166.2,
96,
   4.3,
14 
],
[
 -10.96,
165.97,
76,
   4.9,
64 
],
[
 -20.83,
181.01,
622,
   4.3,
15 
],
[
 -17.78,
181.53,
511,
   4.8,
56 
],
[
  -20.9,
169.84,
93,
   4.9,
31 
],
[
  -15.7,
 184.5,
118,
   4.4,
30 
],
[
  -11.7,
 166.3,
139,
   4.2,
15 
],
[
 -24.39,
178.98,
562,
   4.5,
30 
],
[
 -12.16,
167.03,
264,
   4.4,
14 
],
[
 -19.67,
182.18,
360,
   4.3,
23 
],
[
 -24.97,
179.82,
511,
   4.4,
23 
],
[
  -22.3,
 181.9,
309,
   4.3,
11 
],
[
 -20.75,
184.52,
144,
   4.3,
25 
],
[
 -15.99,
167.95,
190,
   5.3,
81 
],
[
  -14.3,
167.32,
208,
   4.8,
25 
],
[
  -24.1,
 184.5,
68,
   4.7,
23 
],
[
 -20.02,
184.09,
234,
   5.3,
71 
],
[
 -19.85,
182.13,
562,
   4.4,
31 
],
[
 -21.19,
181.58,
490,
     5,
77 
],
[
 -24.12,
180.08,
493,
   4.3,
21 
],
[
 -23.28,
 184.6,
44,
   4.8,
34 
],
[
 -16.52,
 185.7,
90,
   4.7,
30 
],
[
 -22.87,
171.72,
47,
   4.6,
27 
],
[
 -12.26,
   167,
249,
   4.6,
16 
],
[
  -17.4,
 187.8,
40,
   4.5,
14 
],
[
 -26.18,
178.59,
548,
   5.4,
65 
],
[
 -21.46,
181.02,
584,
   4.2,
18 
],
[
 -21.62,
 182.4,
350,
     4,
12 
],
[
 -18.97,
185.25,
129,
   5.1,
73 
],
[
 -27.18,
182.53,
60,
   4.6,
21 
],
[
 -18.54,
182.11,
554,
   4.4,
19 
],
[
 -22.75,
170.99,
67,
   4.8,
35 
],
[
  -14.7,
   166,
48,
   5.3,
16 
],
[
  -21.3,
180.82,
624,
   4.3,
14 
],
[
 -18.69,
 169.1,
218,
   4.2,
27 
],
[
 -19.94,
182.39,
544,
   4.6,
30 
],
[
 -26.17,
 184.2,
65,
   4.9,
37 
],
[
 -17.59,
181.09,
536,
   5.1,
61 
],
[
 -12.08,
165.76,
63,
   4.5,
51 
],
[
 -24.68,
183.33,
70,
   4.7,
30 
],
[
 -19.34,
182.62,
573,
   4.5,
32 
],
[
  -22.7,
   181,
445,
   4.5,
17 
],
[
  -17.9,
181.41,
586,
   4.5,
33 
],
[
  -16.3,
   186,
48,
   4.5,
10 
],
[
 -21.31,
180.84,
586,
   4.5,
17 
],
[
 -21.56,
 185.5,
47,
   4.5,
29 
],
[
  -19.6,
184.53,
199,
   4.3,
21 
],
[
  -18.5,
 185.4,
243,
     4,
11 
],
[
 -17.98,
181.61,
598,
   4.3,
27 
],
[
 -16.43,
186.73,
75,
   4.1,
20 
],
[
 -22.64,
180.64,
544,
     5,
50 
],
[
 -22.95,
170.56,
42,
   4.7,
21 
],
[
 -22.55,
 185.9,
42,
   5.7,
76 
],
[
  -26.6,
182.77,
119,
   4.5,
29 
],
[
 -18.16,
183.41,
306,
   5.2,
54 
],
[
    -28,
   182,
199,
     4,
16 
],
[
 -15.54,
187.15,
60,
   4.5,
17 
],
[
 -19.13,
182.51,
579,
   5.2,
56 
],
[
 -17.97,
181.48,
578,
   4.7,
43 
],
[
  -20.7,
 184.3,
182,
   4.3,
17 
],
[
 -15.46,
187.81,
40,
   5.5,
91 
],
[
 -17.95,
 181.5,
593,
   4.3,
16 
],
[
  -31.8,
 180.6,
178,
   4.5,
19 
],
[
 -20.07,
169.14,
66,
   4.8,
37 
],
[
 -19.47,
169.15,
149,
   4.4,
15 
],
[
 -20.63,
181.61,
599,
   4.6,
30 
],
[
  -34.2,
179.43,
40,
     5,
37 
],
[
 -15.36,
186.71,
130,
   5.5,
95 
],
[
 -18.35,
185.27,
201,
   4.7,
57 
] 
],
"aoColumns": [
 {
 "sTitle": "lat" 
},
{
 "sTitle": "long" 
},
{
 "sTitle": "depth" 
},
{
 "sTitle": "mag" 
},
{
 "sTitle": "stations" 
} 
],
"iDisplayLength":      5,
"bLengthChange": false,
"bFilter": false,
"bInfo": false,
"width": "100%" 
},
"id": "chart1" 
}
  $('#' + chartParamschart1.id).removeClass("rChart")

  $(document).ready(function() {
		drawDataTable(chartParamschart1)
	});
  function drawDataTable(chartParams){
    var dTable = $('#' + chartParams.dom).dataTable(
      chartParams.table
    );
    //first use rCharts width
  	$('#'+chartParams.id+"_wrapper").css("width",chartParams.width)  
		$('#'+chartParams.id+"_wrapper").css("width",chartParams.table.width)
    
    //then if specified change to table width
    $('#'+chartParams.id+"_wrapper").css("margin-left", "auto");
    $('#'+chartParams.id+"_wrapper").css("margin-right", "auto");
		dTable.fnAdjustColumnSizing();
  }
		
</script>

