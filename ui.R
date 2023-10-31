library(shiny)
library(shinydashboard)
library(DT)
library(SummarizedExperiment)
library(org.Hs.eg.db)
library(pheatmap)
library(shinyjs)
library(scatterplot3d)
require(EnhancedVolcano)

#use shinydashboard package
#https://rstudio.github.io/shinydashboard/structure.html

# sidebar
sidebar <- dashboardSidebar(sidebarMenu(
        menuItem(text = "Qc plot", tabName = "plot1",icon = icon("images")),
        menuItem(text = "Qc data", tabName = "plot1new",icon = icon("images")),
        menuItem(text = "Boxplot", tabName = "plot2",icon = icon("images")),
        menuItem(text = "Boxplot after normalisation", tabName = "plot3",icon = icon("images")),
        menuItem(text = "MA plot after normalisation", tabName = "plot4",icon = icon("images")),
        menuItem(text = "MA plot before normalisation", tabName = "plot5",icon = icon("images")),
        menuItem(text = "Cluster plot", tabName = "plot6",icon = icon("images")),
        menuItem(text = "PCA", tabName = "plot7",icon = icon("images")),
        menuItem(text = "Fold change table", tabName = "table1",icon = icon("table")),
        menuItem(text = "Sample table", tabName = "table2", icon = icon("table")),
        menuItem(text = "Annotation table", tabName = "table3", icon = icon("table")),
        menuItem(text = "venn diagram", tabName = "plot8",icon = icon("images")),
        menuItem(text = "volcano diagram", tabName = "plot10",icon = icon("images")),
        menuItem(text = "Enrichment table", tabName = "table4", icon = icon("table")),
        menuItem(text = "heatmap", tabName = "plot9",icon = icon("images"))
    )
)

#use fluidPage
#https://shiny.rstudio.com/reference/shiny/1.0.5/fluidPage.html

# Show a plot of the generated distribution
plot1<-fluidPage(mainPanel(plotOutput("plot1")))
plot1new<-fluidPage(mainPanel(plotOutput("plot1new")))
plot2<-fluidPage(mainPanel(plotOutput("plot2")))
plot3<-fluidPage(mainPanel(plotOutput("plot3")))
plot4<-fluidPage(mainPanel(plotOutput("plot4")))
plot5<-fluidPage(mainPanel(plotOutput("plot5")))
plot6<-fluidPage(mainPanel(plotOutput("plot6")))
plot7<-fluidPage(mainPanel(plotOutput("plot7")))
plot8<-fluidPage(mainPanel(plotOutput("plot8")))
plot10<-fluidPage(mainPanel(plotOutput("plot10")))
# Define UI for application that draws a histogram
plot9 <- fluidPage(
    # Application title
    titlePanel("myHeatmap"),
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("font_row","Font size row:",min = 6,max = 14,value = 10),
            sliderInput("font_col","Font size col:",min = 6,max = 14,value = 10),
            selectInput("select", "Select annotation", choices=c("none",colnames(myresults)),selected = NULL, multiple = T,selectize = TRUE),
            checkboxInput("srownames", "Show Row Names", FALSE),
            checkboxInput("logtansform", "Log transform values", FALSE),
            radioButtons("norm", "Scale by", choices=c("none","row","column"))),
         # Show a plot of the generated distribution
        mainPanel(plotOutput("plot9"))))

tab1 <- fluidPage(fluidRow(DT::dataTableOutput("table1")))
tab2 <- fluidPage(fluidRow(DT::dataTableOutput("table2")))
tab3 <- fluidPage(fluidRow(DT::dataTableOutput("table3")))
tab4 <- fluidPage(fluidRow(DT::dataTableOutput("table4")))


#use shinydashboard package
#https://rstudio.github.io/shinydashboard/structure.html
# subject
body <- dashboardBody(
    tabItems(
        tabItem(tabName = "plot1", plot1),
        tabItem(tabName = "plot1new", plot1new),
        tabItem(tabName = "plot2", plot2),
        tabItem(tabName = "plot3", plot3),
        tabItem(tabName = "plot4", plot4),
        tabItem(tabName = "plot5", plot5),
        tabItem(tabName = "plot6", plot6),
        tabItem(tabName = "plot7", plot7),
        tabItem(tabName = "table2", tab2),
        tabItem(tabName = "table1", tab1),
        tabItem(tabName = "table3", tab3),
        tabItem(tabName = "table4", tab4),
        tabItem(tabName = "plot8", plot8),
        tabItem(tabName = "plot10", plot10),
        tabItem(tabName = "plot9", plot9)
    )
)

#use shinydashboard package
#https://rstudio.github.io/shinydashboard/structure.html
# put together
dashboardPage(dashboardHeader(title = "Options"),sidebar,body)



