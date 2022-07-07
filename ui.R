
### Johns Hopkins Data Science Capstone Final Project
### WORD PREDICTOR GENIE!
## The following code describes the user interface of the word prediction app.


## Load packages.

library(shiny)
library(markdown)


## User interface.

shinyUI(navbarPage("Johns Hopkins Data Science Capstone Final Project",
    tabPanel("WORD PREDICTOR GENIE!",
        HTML("<strong>Created by Jason Parise on July 7th 2022</strong>"),
        br(),
        br(),
        img(src = "https://hosting.photobucket.com/images/ac205/JasonP_2010/Efreet.png"),
# Sidebar
sidebarLayout(
sidebarPanel(
textInput("inputString", "Enter a word or phrase here (1-5 words)",value = ""),
helpText("Press the button below for the Word Genie to predict the next word!"),
submitButton('ALAKAZAM'),
br(),
br(),
br(),
br()),
mainPanel(
h2("Word Genie says the next word is:"),
verbatimTextOutput("prediction"),
strong("Your query to the Word Genie was:"),
tags$style(type='text/css', '#text1 {background-color: rgba(255,255,0,0.40); color: black;}'),
textOutput('text1'))))))

