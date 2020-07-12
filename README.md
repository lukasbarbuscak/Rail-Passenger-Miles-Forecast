# Predicting Rail Passenger Miles in the US: Time Series Analysis

Using data from <a href="https://fred.stlouisfed.org/series/RAILPM#0"> FRED </a> ranging from 2000 to 2019, I will forecast and plot values of rail passenger miles for 2020. 

Source: U.S. Bureau of Transportation Statistics, Rail Passenger Miles [RAILPM], retrieved from FRED, Federal Reserve Bank of St. Louis; https://fred.stlouisfed.org/series/RAILPM, July 11, 2020.

![1](https://github.com/lukasbarbuscak/Rail-Passenger-Miles-Forecast/blob/master/images/1.PNG)

The first graph plots the raw time series data, where the x-axis represents the time (observations were recorded monthly), while the y-axis represents the total number of rail passenger miles in the US (in millions). We can see clear fluctuations related to seasonality, with summers recording the highest number of miles, and winter the lowest. However, the variance seems relatively constant, with little change over time.

After adjusting for seasonality, we can see a general clear trend. The number of passengers gradually increase after suffering a dip around 2005, with again slightly decreasing after 2013, but holding relatively steadily. The third figure compares the not-seasonally adjusted and seasonally adjusted side-by-side.

![2](https://github.com/lukasbarbuscak/Rail-Passenger-Miles-Forecast/blob/master/images/2.PNG)

The further analyze the components, we perform a decomposition of the time series, highlighting the patterns we can account for (seasonality and trends), and a remainder component that contains anything else in the time series.

![6](https://github.com/lukasbarbuscak/Rail-Passenger-Miles-Forecast/blob/master/images/6.PNG)

The decomposition clearly shows the seasonality of the data, as well as a clear trend following roughly the same shape as seasonally adjusted number of passenger miles. The remainder shows the data "minus" the trend and the seasonality components, containing anything not picked up by these two elements.

After performing the stationarity test and satisfying the conditions for modeling this time series, I chose a seasonal autoregressive integrated moving average (ARIMA) model, since the data indicates both autoregressive and moving average components, as well as seasonality.

The best model for this dataset and the predictions are shown in the following figure:

![5](https://github.com/lukasbarbuscak/Rail-Passenger-Miles-Forecast/blob/master/images/5.PNG)

Using a seasonal ARIMA model, I predicted and plotted values of Rail Passenger Miles for the year 2020, and I saved the predictions to a .csv file. Future iterations of this time series analysis can introduce additional variables for a multivariate analysis, and can analyse the impact of the current recession on the transportation sector.
