library(shiny)
library(ggplot2)
library(caret)
library(e1071)
library(randomForest)

data(iris)
data <- iris[,-5]


shinyServer(function(input, output) {
                output$plot <- reactivePlot( function() {
                        ggplot(data = iris, aes_string(x = input$x , y = input$y)) + aes(color = Species) + geom_point(lwd = 4) +theme(text = element_text(size=20))
                })
                
                
                inTrain <- reactive({
                        inTrain <- createDataPartition(y = iris$Species, p = input$s, list = FALSE) 
                        inTrain
                })
                
                
                getFit <- reactive({
                        training <- iris[inTrain(),]
                        testing <- iris[-inTrain(),]
                        modelFit <- train(Species ~.,data = iris , method = input$z)
                        modelFit
                })
                
                output$confusionmatrix <- renderPrint({
                        testing <- iris[-inTrain(),]
                        predictions <- predict(getFit(), newdata = testing)
                        confusionMatrix(predictions, testing$Species)
                })
                
                output$plot2 <- reactivePlot( function() {
                        testing <- iris[-inTrain(),]
                        predictions <- predict(getFit(), newdata = testing)
                        testing$predRight <- predictions == testing$Species
                        ggplot(data = testing, aes_string(x = input$x , y = input$y)) + aes(color = predRight) + geom_point(lwd = 4) +theme(text = element_text(size=20))
                })
})
