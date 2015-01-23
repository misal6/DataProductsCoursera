library(shiny)
library(datasets)
library(forecast)

## Sourcing the data from datasets package
## Original data starts from 1991 up until 1998
## I am changing the indexes to 2007 to 2014 to 
## make it more relevant. 
## (For economics pros. Markets are cyclical !!)
## http://ugrad.stat.ubc.ca/R/library/ts/data/EuStockMarkets.R
srcdata=ts(EuStockMarkets, start = c(2007,130), frequency = 260)

shinyServer(function(input, output) {
  
  ## Using just on render sesion for simplicity
  ## Including the data in titles and subtitles.
  output$plot1 <- renderPlot({
    
    ## Subsetting the data for the input index selected.
    idxdata=ts(srcdata[,input$idx])
    
    ## The main forecast model (just a simple arima fit and forecast)
    idxarima=auto.arima(idxdata)    
    fcst=forecast(idxarima,h=260*input$per,input$ci)
    
    ## Rest of this code is to prepare the title and subtitles
    resfcst=tail(as.data.frame(fcst),1)
    year=input$per+2014
    ttxt=paste("ARIMA Forecast for",input$idx,"2014 ~ ",year,seperator="")
    curval=round(tail(idxdata,1))
    fctval=round(resfcst[,1])
    pct=round(((fctval-curval)/curval)*100)
    mtxt=paste("Forecast change of ",pct,"%, from current=",curval," to projected=",fctval,
               seperator="")
    stxt=paste(input$ci,"% Confidance interval ",round(resfcst[,2])," - ",
               round(resfcst[,3]))
    xt=seq(0,3500,by=265)
    xl=2007:2020
    yt=c(curval,fctval)
    yl=c("Current","Forecast")
    
    ## And Finally the plot
    plot(fcst,type="l",main=ttxt,  axes=FALSE,
         xlab="", ylab="", pch=18, 
         sub=stxt,col.sub="blue",cex.sub=1.2)
    axis(side=1,at=xt,labels=xl)
    axis(side=2,at=yt,las=1)
    abline(h=curval,col = "orange", lty = 3)
    abline(h=fctval,col = "green", lty = 3)
    mtext(mtxt,side=3,col="blue",cex=1.2)
    lines(fitted(fcst),col="red")
    
  })
})