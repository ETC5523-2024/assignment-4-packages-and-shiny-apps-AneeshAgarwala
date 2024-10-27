library(shiny)
library(DT)

# Define UI for the application
ui <- semanticPage(
  title = "Stock Data Viewer",

  # Minimalist CSS styling
  tags$head(tags$style(HTML("
    body {
      font-family: Arial, sans-serif;
      background-color: #f9f9f9;
      color: #333;
    }
    h2 {
      color: #333;
      text-align: center;
      margin-bottom: 20px;
    }
    .ui.segment {
      border: none;
      box-shadow: none;
      margin-bottom: 20px;
    }
  "))),

  h2("Stock Data Viewer"),

  fluidRow(
    column(4,
           div(class = "ui segment",
               selectInput("ind", "Industry Group:",
                           choices = c("All", unique(as.character(asxdata$`GICs industry group`))),
                           selected = "All")
           )
    ),
    column(4,
           div(class = "ui segment",
               sliderInput("mcap", "Market Capitalisation",
                           value = c(1, 50000),
                           min = 0,
                           max = 250000,
                           step = 50000)
           )
    )
  ),

  fluidRow(
    column(12,
           div(class = "ui segment",
               DT::dataTableOutput("table")
           )
    )
  )
)

# Define server logic to filter and render data
server <- function(input, output) {

  # Filter data based on user selections
  output$table <- DT::renderDataTable({
    data <- asxdata[asxdata$MarketCap >= input$mcap[1] & asxdata$MarketCap <= input$mcap[2], ]
    if (input$ind != "All") {
      data <- data[data$`GICs industry group` == input$ind, ]
    }
    datatable(data, options = list(
      pageLength = 10,
      autoWidth = TRUE,
      dom = 't'  # Show only the table without extra features
    ))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
