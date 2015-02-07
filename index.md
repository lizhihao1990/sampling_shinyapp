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

For now it just uses one dataset, but it could include more of the datasets available in R:


```r
head(x = as.data.frame(data()$results)[,-(1:2)], n = 3)
```

```
##            Item                                       Title
## 1          nasa                   NASA spatio-temporal data
## 2 AirPassengers Monthly Airline Passenger Numbers 1949-1960
## 3       BJsales           Sales Data with Leading Indicator
```


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
 -10.97,
166.26,
180,
   4.7,
26 
],
[
 -21.56,
183.23,
271,
   4.4,
36 
],
[
  -18.4,
 183.4,
343,
   4.1,
10 
],
[
 -23.54,
179.93,
574,
     4,
12 
],
[
 -23.49,
180.06,
530,
     4,
23 
],
[
 -28.23,
182.68,
74,
   4.4,
20 
],
[
 -13.82,
172.38,
613,
     5,
61 
],
[
 -17.97,
181.66,
626,
   4.1,
19 
],
[
 -16.45,
167.54,
125,
   4.6,
18 
],
[
 -18.54,
168.93,
100,
   4.4,
17 
],
[
 -12.16,
167.03,
264,
   4.4,
14 
],
[
  -27.6,
 182.4,
61,
   4.6,
11 
],
[
 -18.19,
181.74,
616,
   4.3,
17 
],
[
 -15.24,
185.11,
262,
   4.9,
56 
],
[
 -14.28,
167.26,
211,
   5.1,
51 
],
[
 -30.04,
 181.2,
49,
   4.8,
20 
],
[
 -12.84,
166.78,
150,
   4.9,
35 
],
[
 -12.85,
165.67,
75,
   4.4,
30 
],
[
 -21.35,
170.04,
56,
     5,
22 
],
[
 -27.98,
181.96,
53,
   5.2,
89 
],
[
    -26,
182.12,
205,
   5.6,
98 
],
[
 -17.74,
181.25,
559,
   4.1,
16 
],
[
 -14.32,
167.33,
204,
     5,
49 
],
[
 -20.36,
181.19,
637,
   4.2,
23 
],
[
 -24.39,
178.98,
562,
   4.5,
30 
],
[
  -13.9,
167.18,
221,
   4.2,
21 
],
[
 -25.59,
180.02,
485,
   4.9,
48 
],
[
 -30.69,
 182.1,
62,
   4.9,
25 
],
[
 -21.18,
180.92,
619,
   4.5,
18 
],
[
 -18.07,
181.54,
546,
   4.3,
28 
],
[
 -11.76,
165.96,
45,
   4.4,
51 
],
[
 -34.89,
 180.6,
42,
   4.4,
25 
],
[
 -17.66,
 181.4,
585,
   4.1,
17 
],
[
 -30.01,
 180.8,
286,
   4.8,
43 
],
[
 -34.12,
181.75,
75,
   4.7,
41 
],
[
 -28.15,
 183.4,
57,
     5,
32 
],
[
  -19.7,
182.44,
397,
     4,
12 
],
[
 -23.47,
180.24,
511,
   4.8,
37 
],
[
 -17.94,
181.51,
601,
     4,
16 
],
[
 -16.65,
185.51,
218,
     5,
52 
],
[
 -18.55,
182.23,
563,
     4,
17 
],
[
  -17.7,
   185,
383,
     4,
10 
],
[
 -20.64,
182.02,
497,
   5.2,
64 
],
[
 -20.47,
185.68,
93,
   5.4,
85 
],
[
 -23.19,
 182.8,
237,
   4.3,
18 
],
[
 -27.17,
183.68,
44,
   4.8,
27 
],
[
 -20.97,
181.47,
582,
   4.5,
25 
],
[
 -19.06,
169.01,
158,
   4.4,
10 
],
[
 -12.93,
169.52,
663,
   4.4,
30 
],
[
    -16,
182.82,
431,
   4.4,
16 
],
[
 -33.29,
 181.3,
60,
   4.7,
33 
],
[
 -22.36,
171.65,
130,
   4.6,
39 
],
[
 -13.44,
166.53,
44,
   4.7,
27 
],
[
 -12.34,
167.43,
50,
   5.1,
47 
],
[
    -23,
 170.7,
43,
   4.9,
20 
],
[
  -17.8,
 181.2,
530,
     4,
15 
],
[
  -26.6,
182.77,
119,
   4.5,
29 
],
[
 -11.37,
166.55,
188,
   4.7,
24 
],
[
 -20.08,
182.74,
298,
   4.5,
33 
],
[
  -17.7,
 188.1,
45,
   4.2,
10 
],
[
 -19.64,
 169.5,
204,
   4.6,
35 
],
[
 -13.65,
166.66,
71,
   4.9,
52 
],
[
 -15.94,
184.95,
306,
   4.3,
11 
],
[
 -23.46,
180.17,
541,
   4.6,
32 
],
[
 -21.33,
180.69,
636,
   4.6,
29 
],
[
 -17.95,
181.65,
619,
   4.3,
26 
],
[
 -18.94,
182.43,
566,
   4.3,
20 
],
[
 -16.24,
167.95,
188,
   5.1,
68 
],
[
 -19.13,
184.97,
210,
   4.1,
22 
],
[
 -25.46,
179.98,
479,
   4.5,
27 
],
[
 -18.12,
181.88,
649,
   5.4,
88 
],
[
 -18.05,
180.86,
632,
   4.4,
15 
],
[
  -27.6,
 182.1,
154,
   4.6,
22 
],
[
 -21.56,
 185.5,
47,
   4.5,
29 
],
[
 -17.67,
187.09,
45,
   4.9,
62 
],
[
 -15.28,
185.98,
162,
   4.4,
36 
],
[
 -19.02,
184.23,
270,
   5.1,
72 
],
[
 -19.57,
182.38,
579,
   4.6,
38 
],
[
 -17.99,
181.57,
579,
   4.9,
49 
],
[
 -15.96,
166.69,
150,
   4.2,
20 
],
[
  -20.9,
181.51,
548,
   4.7,
32 
],
[
 -22.42,
 171.4,
86,
   4.7,
33 
],
[
 -12.28,
167.06,
248,
   4.7,
35 
],
[
 -23.11,
179.15,
564,
   4.7,
17 
],
[
 -19.45,
184.48,
246,
   4.3,
15 
],
[
  -23.7,
184.13,
51,
   4.8,
27 
],
[
  -20.1,
 184.4,
186,
   4.2,
10 
],
[
 -15.43,
185.19,
249,
     4,
11 
],
[
 -19.92,
183.91,
264,
   4.2,
23 
],
[
  -19.6,
184.53,
199,
   4.3,
21 
],
[
 -20.61,
 182.6,
488,
   4.6,
12 
],
[
  -11.7,
 166.3,
139,
   4.2,
15 
],
[
 -12.57,
166.72,
137,
   4.3,
20 
],
[
 -21.58,
 181.9,
409,
   4.4,
19 
],
[
 -18.07,
181.58,
603,
     5,
65 
],
[
 -22.28,
183.52,
90,
   4.7,
19 
],
[
 -21.31,
180.84,
586,
   4.5,
17 
],
[
 -15.83,
182.51,
423,
   4.2,
21 
],
[
 -17.72,
181.42,
565,
   5.3,
89 
],
[
 -21.75,
180.67,
595,
   4.6,
30 
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

