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
  
  
  
}