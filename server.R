library(shiny)
library(DT)
library(shinydashboard)
library(SummarizedExperiment)
library(org.Hs.eg.db)
library(pheatmap)
library(shinyjs)
library(scatterplot3d)
require(EnhancedVolcano)

#use shinydashboard package
#https://rstudio.github.io/shinydashboard/structure.html

load('data.RData')#load data

#turn off the RStudio graphics
graphics.off()

#use Plot Output
#https://shiny.rstudio.com/reference/shiny/latest/renderPlot.html

#Using DT in Shiny
#https://rstudio.github.io/DT/shiny.html

shinyServer(function(input, output) {
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
  #use tutorial code
  output$plot9 <- renderPlot({
    #only show 50 rows
    genes<-rownames(myresults[1:50,])
    
    ex<-values[genes,]
    exp<-t(ex)
    ez<-rownames(exp)
    ea<-myresults[ez,]
    
    
    if(input$logtansform){
      exp <- log2(exp + 1)
    }
    
    if(is.null(input$select)){
      mysel<-NULL
    }else if(input$select[1]=="none"){
      mysel<-NULL
    }else if(length(input$select)==1){
      #if the data frame has one column it converts to a factor
      #force the type to be a data frame and restore row and column names
      mysel <-as.data.frame(ea[,input$select[1]])
      rownames(mysel) <-rownames(ex)
      colnames(mysel) <-input$select[1]
    }else{
      mysel<-ea[,input$select]
    }
    
    pheatmap(ex,
             fontsize_row = input$font_row,
             fontsize_col=input$font_col,
             show_rownames=input$srownames,
             scale=input$norm,
             annotation_col=mysel)
  }, execOnResize = F)
  
  observeEvent(input$refresh, {
    session$invalidate
  })
  
}) 


