library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Stock Index Forecast"),
  
  # Sidebar with controls to select a dataset and specify the
  # market index and number of years to forecast. 
  sidebarLayout(
    sidebarPanel(
      selectInput("idx", "Choose a Stock Index:", 
                  choices = c("DAX", "CAC", "SMI","FTSE")),
      br(),
      numericInput("per", "# of years (1-5):", 1,min=1,max=5),
      
      sliderInput("ci", "Confidance Level:", 
                  min = 50, max = 95, value = 90, step = 5),
      br(),
      submitButton("Update View"),
      br(),
      helpText("Select the Stock Market, # of years to forecast and the confidence interval to report and click on update view."),
      br(),
      helpText("Note: It will take less than a minute to 
                calculate the forecast. Thanks for your patience.")     
    ),
    
    # Show the plot with the projections and confidance intervals
    mainPanel(
      plotOutput('plot1'),
      h3('Explanation'),
      p('Stock market data is of vital importance to investors for the purpose of projecting future performance. Billions of dollars (whatever currency is used) is at stake in these markets with the expectations of future profits.'),
      p('This simple app presents a basic approach to forecasting the markets taking primarily the number of years to forecast. The plot projects the expected market value that could be expected at the end of input years.'),
      p('Data is sourced from EuStockMarkets dataset. Originally the data is from 1991 to 1998. I have re-indexed it to simulate more relevant years 2007-2014. The projection start from 2014 to 2014+N years.'),
      p('The output is represented in couple of ways. First in the heading of the plot, where the percentage change along with current and projected level is displayed. Second, in the plot where the years are on x axis and projections are on y axis.'),
      p('Confidence interval, as input is the % level for the forecast function and the output interval is displayed in the subsection. Notice that the projections does not change for different levels, just the interval changes.')
      
    )
  )
))