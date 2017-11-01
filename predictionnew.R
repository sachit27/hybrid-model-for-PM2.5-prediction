setwd("/Users/sachitmahajan/Desktop/untitled")
dat1 <-read.csv("smart.csv")
library(forecast)
attach(dat1)
library(forecastHybrid)
ptm <- proc.time()
result<-data.frame(auto=0,nnetar=0)
for(i in 2:135) {
   pm25.ts <-ts(dat1[i])
   train = pm25.ts[1:600]
   test = pm25.ts[601:620]

   hm3 <- hybridModel(train, weights = "insample.errors", errorMethod = "MASE", models = "an")
   accuracy(hm3,individual = TRUE)

   hForecast <- forecast(hm3, h = 1) 
   hForecast
   result<-rbind(result,data.frame(auto=hForecast$pointForecasts[1],nnetar=hForecast$pointForecasts[2]))
   fit_accuracy <- accuracy(hForecast, test)
   fit_accuracy

}

proc.time()-ptm

write.csv(result, file= "prediction.csv")
