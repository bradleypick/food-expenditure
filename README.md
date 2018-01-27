# Canadian Food Expenditure Shiny Application

### Where is it

The deployed app can be located [here](https://bradleypick.shinyapps.io/CanadianFoodExpenditure/)

### The data

The dataset being visualized in the app is a Statistics Canada Survey of Household Spending on Food Expenditure
from [here](http://www5.statcan.gc.ca/cansim/a26?lang=eng&retrLang=eng&id=2030028&&pattern=&stByVal=1&p1=1&p2=31&tabMode=dataTable&csid=).

### Running it locally

If you wish to run the app locally, you can:

```
cd <directory-of-choice>
git clone https://github.com/bradleypick/food-expenditure.git
cd food-expenditure/src/
```

Opening any of the `global.R`, `ui.R`, and `server.R` in Rstudio should give you the option of running the application locally.

### Dependencies/ development environment

This app was developed using

```
R version 3.4.2 (2017-09-28)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS
```

The packages explicitly called inside the app are


-`plotly` v 4.7.1  

-`scales` v 0.5.0  

-`forcats` v 0.2.0

-`ggplot2` v 2.2.1

-`dplyr` v 0.7.4   

-`readr` v 1.1.1  

-`shiny` v 1.0.5
