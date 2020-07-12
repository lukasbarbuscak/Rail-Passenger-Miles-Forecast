#loading libraries
#if needed, use "install.packages("")"
options(warn = -1)
library(ggplot2)
library(tseries)
library(ggfortify)
library(fpp)
library(forecast)
library(patchwork)

#author info
author = "Lukas Barbuscak"
email = "lukas.barbuscak@gmail.com"

#loading the dataset
df = read.csv("data.csv")

#column names
colnames(df)

#renaming the columns
names(df)[names(df) == "DATE"] = "date"
names(df)[names(df) == "RAILPM"] = "miles"

#observing the data
head(df)

#dataset info
str(df)

#changing the "date" column type
df$date = as.Date(df$date)

#summary statistics
summary(df$miles)

#plotting the data (not seasonally adjusted)
options(repr.plot.width = 16, repr.plot.height = 4)
plot1 = ggplot(data = df, aes(x = date, y = miles))+
          geom_line(color = "darkblue", size=1) +
          labs(title = "Number of Rail Passenger Miles 2000 - 2020",
               x = "", 
               y = "") +
          theme(axis.text=element_text(size=12), 
          plot.title = element_text(hjust = 0.5,size=16))

#creating a time series object
dfts = ts(df[,2], start = c(2000, 1), frequency = 12)

#plotting the data (seasonally adjusted)
decomposed = decompose(dfts, type = c("additive"))
adjusted = dfts - decomposed$seasonal
plot2 = autoplot(adjusted) +
          geom_line(color = "darkred", size=1) +
          labs(title = "Number of Rail Passenger Miles (Seasonally Adjusted) 2000 - 2020",
               x = "", 
               y = "") +
          theme(axis.text=element_text(size=12), 
          plot.title = element_text(hjust = 0.5,size=16))

#displaying the plots
plot1
plot2
plot1 + plot2

#plotting time series decomposition
options(repr.plot.width = 16, repr.plot.height = 12)
autoplot(decompose(dfts), type = c("additive")) +
  labs(title = "Time Series Additive Decomposition",
               x = "", 
               y = "") +
  theme(axis.text=element_text(size=12), plot.title = element_text(hjust = 0.5, size=18),
       axis.text.y = element_blank(),axis.ticks = element_blank(),
       strip.text.y = element_text(size = 15, face = "bold.italic"))

#performing the D-F test for stationarity
adf.test(dfts,alternative="stationary")

#plotting ACF and PACF
options(repr.plot.width = 16, repr.plot.height = 4)
acf(dfts, main="")
pacf(dfts, main="")

#choosing the best ARIMA model
best = auto.arima(dfts, 
                  stepwise = F, 
                  approximation = F, 
                  trace = T)

#forecasting for the next 12 months
best
best_forecast = forecast(best, h=12)

#plotting the forecast
best_plot = autoplot(best_forecast) +
              labs(title = "Forecast: ARIMA (1,0,1) (0,1,1) [12] with Drift ",
                   x = "", 
                   y = "") +
              theme(axis.text=element_text(size=12), 
              plot.title = element_text(hjust = 0.5,size=16))
best_plot

#saving the predictions
write.csv(best_forecast, file = "Rail-Passenger-Miles-Pred.csv", row.names = F)
