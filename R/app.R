
#
# This is a Shiny web application. samples of the headers

library(shiny)
library(stringr)

# Define UI 
ui <- pageWithSidebar(
  headerPanel("Shiny Client Data"),
  sidebarPanel(
    uiOutput("headers"),
    uiOutput("clientdatakv")
  ),
  mainPanel(
    h3("Headers passed into Shiny"),
    verbatimTextOutput("summary"),
    h3("Value of specified header"),
    verbatimTextOutput("value"),
    verbatimTextOutput("queryvals"),
   verbatimTextOutput("clientdatavals"),
   verbatimTextOutput("clientdatavalue")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  #print(names(session$request))
  #print(session$request$HTTP_USER_AGENT)
  print(session$request$HTTP_COOKIE)
  print("--------------------")
  passed_userid <- str_match(session$request$HTTP_COOKIE, "mipid=([^;]+)")
  if (length(passed_userid) > 1) {
    print(str_match(session$request$HTTP_COOKIE, "mipid=([^;]+)")[[2]])
  } else {
    print("using default")
  }
  
  print("--------------------")
        
  output$summary <- renderText({
    ls(env=session$request)
  })

  output$headers <- renderUI({
    selectInput("header", "Header:", ls(env=session$request))
  })

  output$clientdatakv <- renderUI({
    selectInput("clientdatakeys", "Client Data:", names(session$clientData))
  })
  output$clientdatavalue <- renderText({
    if (!isTruthy(input$clientdatakeys)  ){
      return("NULL");
    }
    print(input$clientdatakeys)
    print(session$clientData[["allowDataUriScheme"]])
    return (session$clientData[[input$clientdatakeys]])

  })

  output$value <- renderText({
    if (!isTruthy(input$header)){
      return("NULL");
    }
    return (get(input$header, envir=session$request));
  })
  output$queryvals <- renderText({
        query <- getQueryString()
        queryText <- paste(names(query), query,
                       sep = "=", collapse=", ")
        paste("Your query string is:\n", queryText)

  })

    output$clientdatavals <- renderText({
      names(session$clientData)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

