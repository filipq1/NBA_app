
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(markdown)


shinyUI(navbarPage("Analiza statystyczna danych z NBA",
 tabPanel("Wstępna analiza",
    sidebarLayout(
      sidebarPanel(h4("Wybierz statystykę", align = "center"), br(),
      selectInput("stats", "Statystyka", colnames(nba)[c(24:28,30,32,33)]),
      checkboxInput("check1", "Wartości odstające", value = TRUE), br(),br(),
      img(src = "logo2.png", height = 160, width = 250, style="display: block; margin-left: auto; margin-right: auto;"), br(), br(), br()),
     mainPanel(
      div(h3("Wstępna analiza danych", align = "center"), style = "color:darkred"),br(),
      strong(textOutput("podpis1"), align = "center"),
      verbatimTextOutput("pods"),
      plotOutput("wstep")
    )
    )
 ),
 tabPanel("Korelacja",
 sidebarLayout(
     sidebarPanel(h4("Wybierz statystykę", align = "center"), br(),
     selectInput("stats2", "Statystyka", colnames(nba)[c(24:27,30,33)]),
     checkboxInput("check2", "Linia regresji", value = FALSE), br(),br(),
     img(src = "kasa2.jpg", height = 200, width = 250, style="display: block; margin-left: auto; margin-right: auto;"), br(), br()
   ),
   mainPanel(
    div(h3("Zależność między statystykami a zarobkami?", align = "center"), style = "color:darkgreen"),br(),
    strong(textOutput("podpis2"), align = "center"),
    verbatimTextOutput("kor"),
    plotOutput("wkor")
   )
   )
 ),
 tabPanel("ANOVA",
 sidebarLayout(
   sidebarPanel(h4("Wybierz statystykę", align = "center"), br(),
   selectInput("stats3", "Statystyka", colnames(nba)[c(24:27,30,32,33)]),br(), br(),
   #checkboxInput("check3", "Test normalności", value = FALSE), br(),br(),
   img(src = "logo.jpg", height = 280, width = 180, style="display: block; margin-left: auto; margin-right: auto;"), br(), br()
   ),
   mainPanel(
     div(h3("Czy pozycja ma wpływ na statystyki i zarobki?", align = "center"), style = "color: darkblue"), br(),
     #strong(textOutput("shapiro"), align= "center"),
     strong(textOutput("bartlett"), align= "center"),
     verbatimTextOutput("test"), br(),
     div(h4("Analiza jednoczynnikowa wariancji ANOVA", align = "center")), 
     verbatimTextOutput("anova")
   )
 )         
 ),
 tabPanel("Klasyfikacja zespółów",
    sidebarLayout(
      sidebarPanel(h4("Wybierz liczbę grup do podziału", align = "center"), br(),
      numericInput("slider1", strong("Liczba grup"), min = 2, max = 5, value = 3, step = 1), br(), br(),
      img(src = "stats.png", height = 150, width = 250, style="display: block; margin-left: auto; margin-right: auto;"), br(), br()
    ),
    mainPanel(
      #div(h3("Drzewo klasyfikacyjne", align = "center"), style = "color: darkmagenta"), br(),
      plotOutput("drzewo"), br(),
      h4("Średnie dla grup", align = "center"),
      verbatimTextOutput("grupy")
      )
  )
),
 tabPanel("Klasteryzacja k-średnich",
    sidebarLayout(
      sidebarPanel(
        h4("Wybierz statystyki", align = "center"), br(),
        selectInput("stats4", "Statystyka X", colnames(nba)[c(24:27,30,33)]),
        selectInput("stats5", "Statystyka Y", colnames(nba)[c(24:27,30,33)], selected = names(nba)[[26]]),
        sliderInput("grupy2", "Liczba grup", min = 2, max = 6, value = 3),br(),
        img(src = "final.jpg", height = 200, width = 250, style="display: block; margin-left: auto; margin-right: auto;"), br(), br()
      ),
      mainPanel(
        div(h3("Klasteryzacja k-średnich", style = "color: darkblue", align = "center")),
        plotOutput("klast")
      )
    )
)
)
)

