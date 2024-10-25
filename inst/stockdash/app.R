
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Basic DataTable"),

  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("ind",
                       "Industry Group:",
                       c("All",
                         unique(as.character(asxdata$`GICs industry group`))))
    ),
    column(4,
           sliderInput("mcap",
                       "Market Capitalisation",
                       value = c(1,10),
                       min = 0,
                       max = 250000)
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- asxdata[asxdata$MarketCap >= input$mcap[1] & asxdata$MarketCap <= input$mcap[2],]
    if (input$ind != "All") {
      data <- data[data$`GICs industry group` == input$ind,]
    }
    data
  }))

}
# Run the application
shinyApp(ui = ui, server = server)

