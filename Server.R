server <- function(input, output, session) {
  
  video_juegos <- read.csv("C:/Users/Fabi Hidalgo/Desktop/CETAV/PROGRAMACIÓN II/ProyectoFinal/datos/video_juegos.csv")
  
  video_juegos <- video_juegos |>
    rename(
      "Nombre_del_juego" = "Name",
      "Plataforma_del_juego" = "Platform",
      "Año_de_publicación" = "Year",
      "Género_del_juego" = "Genre",
      "Editor_del_juego" = "Publisher",
      "Ventas_de_Cartuchos_Norte_America" = "NA_Sales",
      "Ventas_de_Cartuchos_Europa" = "EU_Sales",
      "Ventas_de_Cartuchos_Japón" = "JP_Sales",
      "Otras_ventas" = "Other_Sales",
      "Ventas_mundiales_totales" = "Global_Sales"
    )
  
  order_years <- sort(unique(video_juegos$Año_de_publicación[video_juegos$Año_de_publicación != "N/A"]), decreasing = TRUE)
  
  updateSelectInput(session, "Año", 
                    choices = order_years)
  
  updateSelectInput(session, "año", 
                    choices = rev(order_years))
  
  observeEvent(input$Plataforma, {
    selected_platform <- input$Plataforma
    years_for_platform <- unique(video_juegos$Año_de_publicación[
      video_juegos$Plataforma_del_juego == selected_platform])
    
    updateSelectInput(session, "año", 
                      choices = rev(years_for_platform))
  })
  
  observe({
    updateSelectInput(session, "Plataforma", 
                      choices = unique(video_juegos$Plataforma_del_juego))
    
    updateSelectInput(session, "editor", 
                      choices = unique(video_juegos$Editor_del_juego))
    
    observe({
      updateSelectInput(session, "genero_del_juego", 
                        choices = c(
                          "Sports", "Platform", "Racing", "Role-Playing",
                          "Puzzle", "Misc", "Shooter", "Simulation", "Action",
                          "Fighting", "Adventure", "Strategy"
                        ))
    })
    
    observe({
      updateSelectInput(session, "genero_del_juego", 
                        choices = c(
                          "Sports", "Platform", "Racing", "Role-Playing",
                          "Puzzle", "Misc", "Shooter", "Simulation", "Action",
                          "Fighting", "Adventure", "Strategy"
                        ))
    })
    
    observe({
      updateSelectInput(session, "region",
                        choices = c("Ventas_de_Cartuchos_Norte_America", 
                                    "Ventas_de_Cartuchos_Europa", 
                                    "Ventas_de_Cartuchos_Japón",
                                    "Otras_ventas","Ventas_mundiales_totales"))
    })
    
    observe({
      updateSelectInput(session, "plataforma_del_juego", 
                        choices = c("Wii", "NES", "GB", "DS", "X360",
                                    "PS3", "PS2", "SNES", "GBA", "3DS",
                                    "PS4", "N64", "PS", "XB", "PC",
                                    "2600", "PSP", "XOne", "GC", "WiiU",
                                    "GEN", "DC", "PSV", "SAT", "SCD",
                                    "WS", "NG", "TG16", "3DO", "GG",
                                    "PCFX"))
    })
    
    observe({
      updateSelectInput(session, "region_",
                        choices = c("Ventas_de_Cartuchos_Norte_America", 
                                    "Ventas_de_Cartuchos_Europa", 
                                    "Ventas_de_Cartuchos_Japón",
                                    "Otras_ventas","Ventas_mundiales_totales"))
    })
    
    observe({
      updateSelectInput(session, "genero_del_juego_plataforma", 
                        choices = unique(video_juegos$Género_del_juego))
    })
  })
  
  observe({
    updateSelectInput(session, "genero_del_juego_plataforma", 
                      choices = unique(video_juegos$plataforma_del_juego))
  })
  
  datos_filtrados_Año <- eventReactive(input$filtro_Año, {
    video_juegos[video_juegos$Año_de_publicación == input$Año, ]
  })
  
  datos_filtrados_año <- eventReactive(input$filtro_año, {
    if (input$filtro_año > 0) {
      if (input$año == "N/A") {
        shinyalert(
          title = "Sin Fecha",
          text = "El año seleccionado no tiene fecha disponible.",
          type = "info"
        )
      }
      
      filtered_data <- video_juegos[
        video_juegos$Plataforma_del_juego == input$Plataforma &
          video_juegos$Año_de_publicación == input$año, ]
      
      return(filtered_data)
    }
    return(NULL)
  })
  
  
  datos_filtrados_editor <- eventReactive(input$filtro_editor, {
    video_juegos[video_juegos$Editor_del_juego == input$editor, ]
  })
  
  #
  
  output$tabla_Año<- renderDataTable({  
    datos <- datos_filtrados_Año()
    if (!is.null(datos)) {
      return(datos)
    }
    
    return(data.frame()) 
  }, options = list(scrollX = TRUE))
  
  output$tabla_plataforma <- renderDataTable({  
    datos <- datos_filtrados_año()
    if (!is.null(datos)) {
      return(datos)
    }
    
    return(data.frame()) 
  }, options = list(scrollX = TRUE))
  
  output$tabla_editor <- renderDataTable({ 
    datos <- datos_filtrados_editor()
    if (!is.null(datos)) {
      return(datos)
    }
    return(data.frame()) 
  }, options = list(scrollX = TRUE))
  
  
  datos_filtrados_genero <- eventReactive(input$filtro_genero, {
    video_juegos[video_juegos$Género_del_juego == input$genero_del_juego, ]
  })
  
  datos_filtrados_plataforma <- eventReactive(input$filtro_plataforma, {
    if (input$filtro_plataforma > 0) {
      filtered_data <- video_juegos[
        video_juegos$Plataforma_del_juego == input$plataforma_del_juego, ]
      
      return(filtered_data)
    }
    return(NULL)
  })
  
  datos_filtrados_genero_plataforma <- eventReactive(input$filtro_genero_plataforma, {
    video_juegos[video_juegos$Género_del_juego == input$genero_del_juego_plataforma, ]
  })
  
  output$plot_genero <- renderPlot({
    datos_genero <- datos_filtrados_genero()
    
    datos_resumen <- datos_genero |> 
      group_by(Año_de_publicación) |> 
      summarize(Ventas = sum(.data[[input$region]]), .groups = 'keep') |> 
      arrange(desc(Ventas))
    
    top_3_fechas <- head(datos_resumen, 3)
    
    ggplot(top_3_fechas, aes(x = reorder(as.factor(Año_de_publicación), -Ventas), 
                             y = Ventas, label = Ventas)) +
      geom_bar(stat = "identity", fill = "gold", color = "black") +
      geom_text(aes(label = Ventas), 
                position = position_stack(vjust = 0.5),  
                size = 5, color = "black") +
      labs(
        title = paste("Top 3 de Años con las ventas más altas de cartuchos"),
        subtitle = "Se muestran los datos en Millones de cartuchos" ,
        y = "Ventas",
        x = "Año de Publicación"
      ) +
      theme(
        plot.title = element_text(hjust = 0.5, face = "bold")
      )
  })
  
  
  output$plot_plataforma <- renderPlot({
    
    datos_plataforma <- datos_filtrados_plataforma()
    
    if (!is.null(datos_plataforma)) {
      
      datos_resumen <- datos_plataforma |> 
        
        group_by(Año_de_publicación) |> 
        
        summarize(Ventas = sum(.data[[input$region_]]), .groups = 'keep') |> 
        arrange(desc(Ventas))
      
      top_3_fechas <- head(datos_resumen, 3)
      
      g
      gplot(top_3_fechas, aes(x = reorder(as.factor(Año_de_publicación), -Ventas), 
                              y = Ventas, label = Ventas)) +
        geom_bar(stat = "identity", fill = "skyblue", color = "black") +
        
        geom_text(aes(label = Ventas), 
                  position = position_stack(vjust = 0.5),  
                  size = 5, color = "black") +
        
        labs(
          title = paste("Top 3 de Años con las ventas más altas de cartuchos"),
          subtitle = "Se muestran los datos en Millones",
          y = "Ventas",
          x = "Año de Publicación"
        ) +
        theme(
          plot.title = element_text(hjust = 0.5, face = "bold")
        )
    } else {
      
      return(NULL)
    }
  })
  
  
  
}