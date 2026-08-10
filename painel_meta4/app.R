library(shiny)
library(bslib)
library(shinyjs)

ui <- page_navbar(
  title = "SisMOM",

  theme = bs_theme(
    version = 5,
    bg = "#F8F4ED",
    fg = "#0F3131",
    primary = "#16566B"
  ),

  header = tagList(
    useShinyjs(),

    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "estilo.css"
      ),

      tags$script(HTML("
  // ABRIR ZOOM
  $(document).on('click', 'img.img-zoom', function(event) {
    event.preventDefault();
    event.stopPropagation();

    const figura = $(this).closest('figure');
    const titulo = figura.find('figcaption').first().text().trim();

    $('#imgZoom').attr('src', $(this).attr('src'));
    $('#tituloZoom').text(titulo || $(this).attr('alt') || '');

    $('#modalZoom').css('display', 'flex');
  });


  // FECHAR CLICANDO EM QUALQUER LUGAR DO ZOOM
  $(document).on('click', '#modalZoom', function() {
    $('#modalZoom').css('display', 'none');
  });


  // ESC também fecha
  $(document).on('keydown', function(event) {
    if (event.key === 'Escape') {
      $('#modalZoom').css('display', 'none');
    }
  });
      "))
    )
  ),

  nav_panel(
    title = "Operacional",

    div(
      class = "page-sazonal",

      div(
        class = "topo",

        div(
          class = "topo-texto",
          h1("Sistema de Monitoramento de Óleo no Mar - SisMOM"),
          h2("Brazilian Earth System Model - BESM"),
          h3("Dashboard Temporário da Sala de Situação")
        ),

        div(
          class = "topo-logo",
          tags$img(src = "icons/sismom_ftransp.png"),
          tags$img(src = "icons/inpe.png")
        )
      ),

      br(),

      div(
        class = "cards-columns",

        div(
          class = "card-operacional",
          div(class = "titulo-card", "Previsão"),
          div(class = "valor-card", "Sazonal")
        ),

        div(
          class = "card-operacional",
          div(class = "titulo-card", "Rodada"),
          div(class = "valor-card", "Jul/2026")
        ),

        div(
          class = "card-operacional",
          div(class = "titulo-card", "Período"),
          div(class = "valor-card", "Agosto a dezembro de 2026")
        )
      ),

      br(),

      div(
        class = "painel-gif",

        tags$figure(
          class = "fig-tsm-gif",
          tags$img(
            class = "img-zoom",
            src = "figs/sst/sstanim.gif",
            alt = "Temperatura da superfície do mar"
          )
        ),

        tags$figure(
          class = "fig-tsm-gif",
          tags$img(
            class = "img-zoom",
            src = "figs/sst/asstanim.gif",
            alt = "Anomalia da temperatura da superfície do mar"
          )
        ),
        br()
      ),

      div(
        class = "mapa-box-main",
        h3("Previsão Mensal BESM - Agosto/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_202608.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_202608.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202608.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C202608.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Trimestral BESM - ASO/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_ASO2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia de precipitação (mm/mês)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_ASO2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia percentual de precipitação (%)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_ASO2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C_ASO2026.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Mensal BESM - Setembro/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_202609.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_202609.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202609.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C202609.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Trimestral BESM - SON/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_SON2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia de precipitação (mm/mês)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_SON2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia percentual de precipitação (%)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_SON2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C_SON2026.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Mensal BESM - Outubro/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_202610.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_202610.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202610.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C202610.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Trimestral BESM - OND/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_OND2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia de precipitação (mm/mês)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_OND2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia percentual de precipitação (%)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_OND2026.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C_OND2026.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Mensal BESM - Novembro/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_202611.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_202611.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202611.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C202611.png"
              )
            )
          )
        )
      ),

      br(),

      div(
        class = "mapa-box-main",
        h3("Previsão Mensal BESM - Dezembro/2026"),

        div(
          class = "bloco-mapas",

          div(
            class = "mapas-sec",

            tags$figure(
              class = "figura-sec-tsm",
              tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/tsm/IC072026_aTSM_202612.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_mmmes_202612.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202612.png"
              )
            ),

            tags$figure(
              class = "figura-sec",
              tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
              tags$img(
                class = "img-zoom",
                src = "figs/IC072026/t2m/IC072026_aT2m_C202612.png"
              )
            )
          )
        )
      )
    )
  ),

  nav_panel(
    title = "Resumo das Metas",

    div(
      class = "pagina-infograficos",

      div(
        class = "cabecalho-pagina",
        h2("Resumo Integrado do SisMOM"),
        h3("Síntese visual das componentes do programa")
      ),

      div(
        class = "grade-infograficos",

        tags$figure(
          class = "card-infografico",
          tags$figcaption(
            "Monitoramento marítimo e detecção de embarcações - Metas 1, 2, 3 e 4"
          ),
          tags$img(
            class = "img-zoom",
            src = "figs/SisMOM_Infografico.png",
            alt = "Resumo integrado das metas 1, 2, 3 e 4 do SisMOM"
          )
        ),

        tags$figure(
          class = "card-infografico",
          tags$figcaption(
            "Meta 1 - Monitoramento marítimo e detecção de embarcações"
          ),
          tags$img(
            class = "img-zoom",
            src = "figs/meta01.png",
            alt = "Resumo integrado da Meta 1 do SisMOM"
          )
        ),

        tags$figure(
          class = "card-infografico",
          tags$figcaption(
            "Meta 4 - Avaliação da componente atmosférica do BESM"
          ),
          tags$img(
            class = "img-zoom",
            src = "figs/Infografico_Meta4_BESM.png",
            alt = "Resumo integrado da avaliação atmosférica do BESM"
          )
        )
      )
    )
  ),

  nav_panel(
    title = "Constelação Satelite",

    div(
      class = "pagina-infograficos",

      div(
        class = "video-box",
          tags$video(
                class = "video-besm",
            src = "videos/Construindo.mp4",
            type = "video/mp4",
            autoplay = NA,
            loop = NA,
          muted = NA,
      playsinline = NA
          )
        )
      )
    ),

  nav_panel(
    title = "Constelação Satelite",

    div(
      class = "pagina-infograficos",
      div(
        class = "video-box",
          tags$video(
                class = "video-besm",
            src = "videos/satelites.mp4",
            type = "video/mp4",
            autoplay = NA,
            loop = NA,
          muted = NA,
      playsinline = NA
          )
        )
      )
    ),

  footer = tagList(
    div(
      id = "modalZoom",
      class = "modal-zoom",
      h2(
        id = "tituloZoom",
        class = "titulo-zoom"
      ),

      tags$img(
        id = "imgZoom",
        class = "conteudo-zoom",
        src = "",
        alt = "Imagem ampliada"
      )
    )
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
