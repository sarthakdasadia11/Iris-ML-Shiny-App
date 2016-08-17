library(shiny)
library(ggplot2)
library(caret)
library(e1071)
library(randomForest)

data(iris)
data <- iris[,-5]


shinyUI(pageWithSidebar(
        headerPanel("Intro to Iris Dataset"),
        sidebarPanel(
                h3('Tweek the Plot'),
                h3(''),
                selectInput('x','X-axis',names(data),selected  = "Sepal.Length"),
                selectInput('y','Y-axis',names(data),selected = "Sepal.Width"),
                
                h3('Machine Learning'),
                h3(''),
                sliderInput('s', 'Choose Sample Size', min=0.2, max=0.9,
                            value=min(0.6, 0.9), step=0.1, round=0),
                selectInput('z','Choose ML-Method',c("Random Forest" = "rf","Decision Tree" = "rpart"),
                            selected = "rpart")
        ),
        mainPanel(
                h2('Introductory Exploratory Analysis'),
                
                h4('The Iris flower data set or Fisher\'s Iris data set is a multivariate data set introduced by Ronald Fisher in his 1936 paper.
                  The data set contains 5 features: Sepal Length, Sepal Width, Petal Length, Petal Width and Species. Make exploratory plot
                  by picking X and Y axis from the side panel.'),
                
                plotOutput('plot'),
                
                h2('Predicting Type of Species'),
                
                h4('Let\'s develop a machine learning algorithm to predict the type of Species. In this example, we will use all
                  4 features to develop our model. Choose the method from the sidebar.'),
                
                verbatimTextOutput('confusionmatrix'),
                
                h4(''),
                
                h4('We can also see which data points are tuely/falsely predicted'),
                
                plotOutput('plot2')
               
        )
))