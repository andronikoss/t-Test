
source("helpers1.R")
source("helpers2.R")

shinyServer(function(input, output){
    output$tplot <- renderPlot({
        
    	
    
        select <- input$Number.of.Samples
        method <- switch(input$method, 
                         "beidseitig" = "beidseitig",
                         "linksseitig" = "linksseitig",
                         "rechtsseitig"= "rechtsseitig")
        Significance.Level <- reactive({(100 - input$Significance.Level)/100})
        mu <- isolate(input$mu)
        sim <- input$action
        input$action2
        N <- input$Number.of.Observation

        
        M <- reactive({generate(N=N, sim=sim)})
        t.plot(M=M(), mu=mu, method = method,sig.level = Significance.Level(), 
               inside.color = "grey",out.color = "red",
               select=select)
        
        output$downloadPlot <- downloadHandler(
            filename = function() { paste(method, '.jpg', sep='') },
            content = function(file) {
            	jpeg(file, width = 800, height = 550)
                print(t.plot(M=M(), mu=mu, method = method,sig.level = Significance.Level(), 
                						 inside.color = "grey",out.color = "red",
                						 select=select))
                dev.off()
            })
        
    })
})





















