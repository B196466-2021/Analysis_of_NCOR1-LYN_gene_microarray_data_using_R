library(shiny)
library(DT)
library(SummarizedExperiment)
library(org.Hs.eg.db)
library(pheatmap)
library(shinyjs)
library(scatterplot3d)
require(EnhancedVolcano)



load('data.RData')#load data

#turn off the RStudio graphics
graphics.off()

#use Plot Output
#https://shiny.rstudio.com/reference/shiny/latest/renderPlot.html

#Using DT in Shiny
#https://rstudio.github.io/DT/shiny.html

ui<-fluidPage(
    mainPanel(plotOutput("plot1"),
                        plotOutput("plot1new"),
                        plotOutput("plot2"),
                        plotOutput("plot3"),
                        plotOutput("plot4"),
                        plotOutput("plot5"),
                        plotOutput("plot6"),
                        plotOutput("plot7"),
                        plotOutput("plot8"),
                        plotOutput("plot10"),
              tableOutput("table1"),
              tableOutput("table2"),
              tableOutput("table3"),
              tableOutput("table4"),
              
                        ))


server<-(function(input, output) {
    output$plot1<- renderPlot({hist(mydata)})
    output$plot1new<- renderPlot({plot(qcs)})
    output$plot2<- renderPlot({boxplot(mydata, col=targets2$Colour, las=2,names=targets2$Name,ylab="Log intensity",main="boxplot_before")})
    output$plot3<- renderPlot({boxplot(values, col=targets2$Colour,las=2,names=targets2$Name,ylab="Log intensity",main="boxplot_after")})
    output$plot4<- renderPlot({mva.pairs(values)})
    output$plot5<- renderPlot({mva.pairs(pm(mydata))})
    output$plot6<- renderPlot({plot(hc)})
    output$plot7<- renderPlot({
        s3d<-scatterplot3d(pca$x[,1:3], pch=19, color=rainbow(1))
        s3d.coords <- s3d$xyz.convert(pca$x[,1:3])
        text(s3d.coords$x, s3d.coords$y, labels = colnames(values),pos = 3,offset = 0.5)})
    output$table2 <- DT::renderDataTable(DT::datatable({exprsvals}))
    output$table1 <- DT::renderDataTable(DT::datatable({new.all.data}))
    output$table3 <- DT::renderDataTable(DT::datatable({myresults}))
    output$table4 <- DT::renderDataTable(DT::datatable({results}))
    output$plot8<- renderPlot({vennDiagram(clas)})
    output$plot10<- renderPlot({EnhancedVolcano(myresults,lab = rownames(myresults),x = "logFC",y = "P.Value")})
    
    
    
}) 
shinyApp(ui=ui, server=server)
