
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("NBA.R")


shinyServer(function(input, output) {

  dane <- reactive({data.frame(nba$Pos, nba[,input$stats])})
  gr.com = reactive({cutree(hclust(dd, method = "complete"), k = input$slider1)})
  srednie.gr <- reactive({aggregate(nba2, by = list(gr.com), FUN = mean)})
  
  dane2 <- reactive({nba[,c(input$stats4, input$stats5)]})
  clusters <- reactive({kmeans(dane2(), input$grupy2)})
  
  output$podpis1 <- renderText({paste("Podsumowanie", input$stats)})
  output$pods <- renderPrint({summary(dane()[,2])})
  output$wstep <- renderPlot({plot(dane(), main = "Podstawowe statystyki w zależności od pozycji", col = (c("gold", "red", "lightblue", "brown", "darkgreen")),outline = input$check1, ylab = input$stats, xlab = 'POZYCJA')})
  output$podpis2 <- renderText({paste("Korelacja zarobków z ", input$stats2, "wyznaczona metodą Pearsona")})
  output$kor <- renderPrint({cor(nba[,input$stats2], nba$SALARY, method = "pearson")})
  output$wkor <- renderPlot({plot(nba$SALARY, nba[,input$stats2], main = paste("Zarobki a ", input$stats2), cex= 1.3, pch = 16, col = "blue", xlab = "PENSJA", ylab = input$stats2)
    if(input$check2 == TRUE){abline(lm(nba[,input$stats2] ~ nba$SALARY), col = "red")}})
  #output$shapiro <- renderText({paste("Test Shapiro-Wilka dla ", input$stats3)})
  output$bartlett <- renderText({paste("Test Bartletta dla ", input$stats3)})
  output$test <- renderPrint({bartlett.test(nba[,input$stats3]~nba$Pos)})
  output$anova <- renderPrint({
    model.0 <- lm(nba[,input$stats3]~1)
    model.1 <- lm(nba[,input$stats3]~nba$Pos)
    anova(model.0,model.1)
  })
  output$grupy <- renderPrint({gr.com = cutree(hclust(dd, method = "complete"), k = input$slider1)
  srednie.gr <-aggregate(nba2, by = list(gr.com), FUN = mean)
  print(srednie.gr[,c(1, 21:24 ,27:29)])})
  output$drzewo <- renderPlot({plot(hclust(dd,method="complete"),col = "gray0", col.main = "darkblue", col.lab = "darkblue",
                                    lwd = 2, lty = 5, sub = "", hang = -1, xlab = "Zespoły")})
  output$klast <- renderPlot({
    par(mar = c(5.1,4.1,0,1))
    plot(dane2(), col = clusters()$cluster, pch = 20, cex =2)
    points(clusters()$centers, pch = 3, cex = 3, lwd = 3)
  })
})
