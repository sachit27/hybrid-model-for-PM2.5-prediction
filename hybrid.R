setwd("/Users/sachitmahajan/Desktop/untitled")
dat <-read.csv("best3.csv")
library(forecast)
attach(dat)
library(forecastHybrid)
ptm <- proc.time()
#for i=2:25
pm25.ts <-ts(pm74DA3895C48C)
train = pm25.ts[1:600]
test = pm25.ts[601:620]

hm3 <- hybridModel(train, weights = "insample.errors", errorMethod = "MASE", models = "an")
accuracy(hm3,individual = TRUE)

hForecast <- forecast(hm3, h = 6) 
hForecast

fit_accuracy <- accuracy(hForecast, test)
fit_accuracy

proc.time()-ptm


