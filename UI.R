ui <- dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Venta de videojuegos", titleWidth = 300),
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      menuItem("Datos sobre ventas", 
               
               tabName = "datos", icon = icon("table")),
      menuItem("Estado de ventas", 
               
               tabName = "grafico", icon = icon("chart-bar")),
      menuItem("Estado de ventas por género y plataforma", 
               tabName = "grafico_plataformas", icon = icon("chart-bar"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        title = "Contenido de la pestaña Datos",
        tabName = "datos",
        tabsetPanel(
          tabPanel("Año",
                   h3("Año de lanzamiento"),
                   selectInput("Año", "Escoja año de lanzamiento", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_Año", "Filtrar"),
                   
                   dataTableOutput("tabla_Año")
                   
          ),
          tabPanel("Plataforma",
                   h3("Lista de plataforma"),
                   selectInput("Plataforma", "Escoja la plataforma del juego",
                               choices = NULL, selected = NULL),
                   selectInput("año", "Escoja el año", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_año", "Filtrar"),
                   dataTableOutput("tabla_plataforma")  
          ),
          tabPanel("Editor",
                   h3("Lista de editores del juego"),
                   selectInput("editor", "Escoja el editor del juego", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_editor", "Filtrar"),
                   dataTableOutput("tabla_editor")
          )
        )
      ),
      tabItem(
        title = "Contenido de la pestaña Gráficos",
        tabName = "grafico",
        tabsetPanel(
          tabPanel("Estado de ventas",
                   br(),
                   selectInput("genero_del_juego", "Selecciona el género del juego", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_genero", "Filtrar"),
                   br(),
                   br(),
                   selectInput("region", "Selecciona la región", 
                               choices = NULL, selected = NULL),
                   plotOutput("plot_genero")
          ),
          tabPanel("Estado de plataforma",
                   br(),
                   selectInput("plataforma_del_juego", "Selecciona la plataforma del juego", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_plataforma", "Filtrar"),
                   br(),
                   br(),
                   selectInput("region_", "Selecciona la región", 
                               choices = NULL, selected = NULL),
                   plotOutput("plot_plataforma")
          )
        )
      ),
      tabItem(
        title = "Estado de ventas por género y plataforma",
        tabName = "grafico_plataformas",
        tabsetPanel(
          tabPanel("Top 3 de Plataformas por Género",
                   br(),
                   selectInput("genero_del_juego_plataforma", "Selecciona el género del juego", 
                               choices = NULL, selected = NULL),
                   actionButton("filtro_genero_plataforma", "Filtrar"),
                   br(),
                   br(),
                   plotOutput("plot_genero_plataforma")
          )
        )
      )
    )
  )
)