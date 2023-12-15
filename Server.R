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
}