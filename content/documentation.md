### Overview

This shiny application is intended as a didactic tool to help visualize some sampling strategies. A dataset is provided and a responsive interface presented to explore some variables and visualize which elements get selected.


### Constraints on the application

This application provides examples of sampling strategies commonly used in surveys. The dataset itself represents a sample of the US population, but for the purposes of this application is presented as data on a complete fictious population (which wierdly resembles the US population).


### Using the application

You can use the application in the "Application" tab below the title. Follows a description of the available controls and their use:

**Axis variable** selectors: Drop down lists to select which numerical variables are represented in the plot as axes. If you select the same variable in both controls you will only get the points aligned on the identity line!

**Color based on** selector: Drop down lists to select which categorical variable is represented as color in the plot. You can use facets instead of color by enabling the **Use facet instead of color** checkbox.

**Sampling strategy** selector: Drop down list to select which sampling strategy will be used to select individuals in te population. You can highlight the selected individuals by enabling the **Enable sampling** checkbox.

**Emphasize immigrant status** checkbox: There are some immigrants in this population, enable this checkbox to highlight them using bigger points.


### The dataset

[National Health and Nutrition Examination Survey](http://wwwn.cdc.gov/nchs/nhanes/search/nhanes11_12.aspx "National Health and Nutrition Examination Survey")

It includes 4000 observations about demographic information (age, sex, poverty status) and dietary practices (daily energy [calories], protein, carbs and fat intake) of US individuals.


**Restricted information**

The NHANE survey collects some variables clasified as "restricted" to protect participant privacy. Among these is the geographic location. For the purposes of this application a mock (_i.e._ made up) geographic location is provided.
