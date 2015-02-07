---
title       : Visualizing sampling strategies
subtitle    : An aid to explain sampling strategies
author      : Oscar de León
job         : Developing data products
framework   : io2012
hitheme     : tomorrow 
mode        : selfcontained
ext_widgets : {rCharts: "libraries/nvd3"}
---

## What is this application for?

- Overview

This shiny application is intended as a didactic tool to help visualize some sampling strategies. A dataset is provided and a responsive interface presented to explore some variables and visualize which elements get selected.

The application provides examples of sampling strategies commonly used in surveys. The dataset itself represents a sample of the US population, but for the purposes of this application is presented as data on a complete fictious population (which wierdly resembles the US population).

The data comes from the National Health and Nutrition Examination Survey. It includes 4000 observations about demographic information (age, sex, poverty status) and dietary practices (daily energy [calories], protein, carbs and fat intake) of US individuals.

You can access the app in [https://odeleon.shinyapps.io/sampling/](https://odeleon.shinyapps.io/sampling/).

---

## Who can use this application

This app was prepared as a course project for the [Developing data products](https://www.coursera.org/course/devdataprod) course.

It was designed for use as a resource to visually explain some common survey sampling methodologies in a lecture I am sometimes invited to give in a research methodologies course at the university I work in.

You can access the source code for the application in a [github repo](https://github.com/odeleongt/sampling_shinyapp). The source code for this presentation is found on the `gh-pages` branch of that same repository.


---

## Examples

- Use cases


<div id = 'chart1' class = 'rChart nvd3'></div>
<script type='text/javascript'>
 $(document).ready(function(){
      drawchart1()
    });
    function drawchart1(){  
      var opts = {
 "dom": "chart1",
"width":    800,
"height":    400,
"x": "Hair",
"y": "Freq",
"group": "Eye",
"type": "multiBarChart",
"id": "chart1" 
},
        data = [
 {
 "Hair": "Black",
"Eye": "Brown",
"Sex": "Male",
"Freq":             32 
},
{
 "Hair": "Brown",
"Eye": "Brown",
"Sex": "Male",
"Freq":             53 
},
{
 "Hair": "Red",
"Eye": "Brown",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Brown",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Black",
"Eye": "Blue",
"Sex": "Male",
"Freq":             11 
},
{
 "Hair": "Brown",
"Eye": "Blue",
"Sex": "Male",
"Freq":             50 
},
{
 "Hair": "Red",
"Eye": "Blue",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Blond",
"Eye": "Blue",
"Sex": "Male",
"Freq":             30 
},
{
 "Hair": "Black",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             10 
},
{
 "Hair": "Brown",
"Eye": "Hazel",
"Sex": "Male",
"Freq":             25 
},
{
 "Hair": "Red",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Hazel",
"Sex": "Male",
"Freq":              5 
},
{
 "Hair": "Black",
"Eye": "Green",
"Sex": "Male",
"Freq":              3 
},
{
 "Hair": "Brown",
"Eye": "Green",
"Sex": "Male",
"Freq":             15 
},
{
 "Hair": "Red",
"Eye": "Green",
"Sex": "Male",
"Freq":              7 
},
{
 "Hair": "Blond",
"Eye": "Green",
"Sex": "Male",
"Freq":              8 
} 
]
  
      if(!(opts.type==="pieChart" || opts.type==="sparklinePlus" || opts.type==="bulletChart")) {
        var data = d3.nest()
          .key(function(d){
            //return opts.group === undefined ? 'main' : d[opts.group]
            //instead of main would think a better default is opts.x
            return opts.group === undefined ? opts.y : d[opts.group];
          })
          .entries(data);
      }
      
      if (opts.disabled != undefined){
        data.map(function(d, i){
          d.disabled = opts.disabled[i]
        })
      }
      
      nv.addGraph(function() {
        var chart = nv.models[opts.type]()
          .width(opts.width)
          .height(opts.height)
          
        if (opts.type != "bulletChart"){
          chart
            .x(function(d) { return d[opts.x] })
            .y(function(d) { return d[opts.y] })
        }
          
         
        
          
        

        
        
        
      
       d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

       nv.utils.windowResize(chart.update);
       return chart;
      });
    };
</script>




---

## Future development

- Future improvement
