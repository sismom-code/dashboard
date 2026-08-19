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

  const frames = [
  {
    mes: 'Setembro/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202609.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202609.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202609.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202609.png'
  },

  {
    mes: 'Outubro/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202610.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202610.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202610.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202610.png'
  },

  {
    mes: 'Novembro/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202611.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202611.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202611.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202611.png'
  },

  {
    mes: 'Dezembro/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202612.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202612.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202612.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202612.png'
  },

  {
    mes: 'Janeiro/2027',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202701.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202701.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202701.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202701.png'
  },

  {
    mes: 'Fevereiro/2027',
    tsm:      'figs/IC082026/IC082026_aTSM_mensal_202702.png',
    prec:     'figs/IC082026/IC082026_aprec_mensal_202702.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_mensal_202702.png',
    temp:     'figs/IC082026/IC082026_aT2m_mensal_202702.png'
  }

];

let frameAtual = 1;
let timerAnimacao = null;


function atualizarFrame(){

  const f = frames[frameAtual];

  $('#tituloMes').text(
    'Previsão Mensal BESM - ' + f.mes
  );

  $('#img_tsm').attr('src', f.tsm);
  $('#img_prec').attr('src', f.prec);
  $('#img_precperc').attr('src', f.precperc);
  $('#img_temp').attr('src', f.temp);

  $('#sliderMes').val(frameAtual);
}


function mudarFrame(direcao){

  frameAtual += direcao;

  if(frameAtual >= frames.length)
    frameAtual = 0;

  if(frameAtual < 0)
    frameAtual = frames.length - 1;

  atualizarFrame();
}


function selecionarFrame(valor){

  frameAtual = parseInt(valor);

  atualizarFrame();
}


function iniciarAnimacao(){

  if(timerAnimacao !== null)
    return;

  timerAnimacao = setInterval(function(){

    mudarFrame(1);

  }, 1200);
}


function pararAnimacao(){

  clearInterval(timerAnimacao);

  timerAnimacao = null;
}

const framesTri = [

  {
    periodo: 'SON/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_sazonal_SON_2026.png',
    prec:     'figs/IC082026/IC082026_aprec_sazonal_SON.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_sazonal_SON.png',
    temp:     'figs/IC082026/IC082026_aT2m_sazonal_SON_2026.png'
  },

  {
    periodo: 'OND/2026',
    tsm:      'figs/IC082026/IC082026_aTSM_sazonal_OND_2026.png',
    prec:     'figs/IC082026/IC082026_aprec_sazonal_OND.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_sazonal_OND.png',
    temp:     'figs/IC082026/IC082026_aT2m_sazonal_OND_2026.png'
  },

  {
    periodo: 'NDJ/2026-2027',
    tsm:      'figs/IC082026/IC082026_aTSM_sazonal_NDJ_2026_2027.png',
    prec:     'figs/IC082026/IC082026_aprec_sazonal_NDJ.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_sazonal_NDJ.png',
    temp:     'figs/IC082026/IC082026_aT2m_sazonal_NDJ_2026_2027.png'
  },

  {
    periodo: 'DJF/2026-2027',
    tsm:      'figs/IC082026/IC082026_aTSM_sazonal_DJF_2026_2027.png',
    prec:     'figs/IC082026/IC082026_aprec_sazonal_DJF.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_sazonal_DJF.png',
    temp:     'figs/IC082026/IC082026_aT2m_sazonal_DJF_2026_2027.png'
  },

  {
    periodo: 'JFM/2027',
    tsm:      'figs/IC082026/IC082026_aTSM_sazonal_JFM_2027.png',
    prec:     'figs/IC082026/IC082026_aprec_sazonal_JFM.png',
    precperc: 'figs/IC082026/IC082026_aprec_porcentagem_sazonal_JFM.png',
    temp:     'figs/IC082026/IC082026_aT2m_sazonal_JFM_2027.png'
  },

];

let frameTriAtual = 0;
let timerTri = null;


function atualizarFrameTri(){

  const f = framesTri[frameTriAtual];

  $('#tituloTri').text(
    'Previsão Trimestral BESM - ' + f.periodo
  );

  $('#img_tsm_tri').attr('src', f.tsm);
  $('#img_prec_tri').attr('src', f.prec);
  $('#img_precperc_tri').attr('src', f.precperc);
  $('#img_temp_tri').attr('src', f.temp);

  $('#sliderTri').val(frameTriAtual);
}


function mudarFrameTri(direcao){

  frameTriAtual += direcao;

  if(frameTriAtual >= framesTri.length)
    frameTriAtual = 0;

  if(frameTriAtual < 0)
    frameTriAtual = framesTri.length - 1;

  atualizarFrameTri();
}


function selecionarFrameTri(valor){

  frameTriAtual = parseInt(valor);

  atualizarFrameTri();
}


function iniciarAnimacaoTri(){

  if(timerTri !== null)
    return;

  timerTri = setInterval(function(){

    mudarFrameTri(1);

  }, 1500);
}


function pararAnimacaoTri(){

  clearInterval(timerTri);

  timerTri = null;
}

")))),

nav_panel(
    title = "BESM Sazonal",

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
          div(class = "valor-card", "Ago2026")
        ),

        div(
          class = "card-operacional",
          div(class = "titulo-card", "Período"),
          div(class = "valor-card", "Set/2026 a Fev/2027")
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
          )),
        br(),
      div(class="text-font","Fonte: https://www.cpc.ncep.noaa.gov/products/analysis_monitoring/enso_update/sstanim.shtml. Acessado: 15/agosto/2026"),
      ),

  div(
  class = "painel-previsao",
    h3(id = "tituloMes",
      "Previsão Mensal BESM - Setembro/2026"
      ),

  div(
    class = "mapas-mensais",

    tags$figure(
      class = "figura-mensal figura-tsm",
      tags$figcaption(
        "Anomalia da temperatura da superfície do mar (°C)"
      ),
      tags$img(
        id = "img_tsm",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aTSM_mensal_202609.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia de precipitação (mm/mês)"
      ),
      tags$img(
        id = "img_prec",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aprec_mensal_202609.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia percentual de precipitação (%)"
      ),
      tags$img(
        id = "img_precperc",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aprec_porcentagem_mensal_202609.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia da temperatura a 2 m (°C)"
      ),
      tags$img(
        id = "img_temp",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aT2m_mensal_202609.png"
      )
    )
  ),

div(
  class = "controle-animacao",

  # Linha 1: botões
  div(
    class = "botoes-animacao",

    actionButton(
      "dummy",
      NULL,
      class = "controle-btn",
      icon = icon("backward"),
      onclick = "mudarFrame(-1)"
    ),

    actionButton(
      "dummy2",
      NULL,
      class = "controle-btn",
      icon = icon("play"),
      onclick = "iniciarAnimacao()"
    ),

    actionButton(
      "dummy3",
      NULL,
      class = "controle-btn",
      icon = icon("pause"),
      onclick = "pararAnimacao()"
    ),

    actionButton(
      "dummy4",
      NULL,
      class = "controle-btn",
      icon = icon("forward"),
      onclick = "mudarFrame(1)"
    )
  ),

  # Linha 2: slider
  div(
    class = "linha-slider",

    tags$input(
      id = "sliderMes",
      type = "range",
      min = "0",
      max = "4",
      value = "0",
      step = "1",
      oninput = "selecionarFrame(this.value)"
    )
  ),

  # Linha 3: meses
  div(
    class = "labels-meses",
    span("Set"),
    span("Out"),
    span("Nov"),
    span("Dez"),
    span("Jan")
  )
)
),
br(),
#### Previsão Trimestral 
div(
  class = "painel-previsao",

  h3(
    id = "tituloTri",
    "Previsão Trimestral BESM - SON/2026"
  ),

  div(
    class = "mapas-mensais",

    tags$figure(
      class = "figura-mensal figura-tsm",
      tags$figcaption(
        "Anomalia da temperatura da superfície do mar (°C)"
      ),
      tags$img(
        id = "img_tsm_tri",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aTSM_sazonal_SON_2026.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia de precipitação (mm/mês)"
      ),
      tags$img(
        id = "img_prec_tri",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aprec_sazonal_SON.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia percentual de precipitação (%)"
      ),
      tags$img(
        id = "img_precperc_tri",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aprec_porcentagem_sazonal_SON.png"
      )
    ),

    tags$figure(
      class = "figura-mensal figura-sec",
      tags$figcaption(
        "Anomalia da temperatura a 2 m (°C)"
      ),
      tags$img(
        id = "img_temp_tri",
        class = "img-zoom",
        src = "figs/IC082026/IC082026_aT2m_sazonal_SON_2026.png"
      )
    )
  ),

  div(
    class = "controle-animacao",

    div(
      class = "botoes-animacao",

      actionButton(
        "tri_back",
        NULL,
        class = "controle-btn",
        icon = icon("backward"),
        onclick = "mudarFrameTri(-1)"
      ),

      actionButton(
        "tri_play",
        NULL,
        class = "controle-btn",
        icon = icon("play"),
        onclick = "iniciarAnimacaoTri()"
      ),

      actionButton(
        "tri_pause",
        NULL,
        class = "controle-btn",
        icon = icon("pause"),
        onclick = "pararAnimacaoTri()"
      ),

      actionButton(
        "tri_forward",
        NULL,
        class = "controle-btn",
        icon = icon("forward"),
        onclick = "mudarFrameTri(1)"
      )
    ),

    div(
      class = "linha-slider",

      tags$input(
        id = "sliderTri",
        type = "range",
        min = "0",
        max = "4",
        value = "0",
        step = "1",
        oninput = "selecionarFrameTri(this.value)"
      )
    ),

    div(
      class = "labels-meses",
      span("SON"),
      span("OND"),
      span("NDJ"),
      span("DJF"),
      span("JFM")
    )
  )
),


###### Mapas Trimestrais com botões ### 
# div(
#   class = "painel-previsao",

#   h2(
#     id = "tituloTri",
#     "Previsão Trimestral BESM - JAS/2026"
#   ),

#   div(
#     class = "mapas-mensais",

#     tags$figure(
#       class = "figura-mensal figura-tsm",
#       tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
#       tags$img(
#         id = "img_tri_tsm",
#         class = "img-zoom-tri",
#         `data-variavel` = "tsm",
#         src = "figs/IC082026/IC082026_aTSM_sazonal_SON_2026.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal",
#       tags$figcaption("Anomalia de precipitação (mm/mês)"),
#       tags$img(
#         id = "img_tri_prec",
#         class = "img-zoom-tri",
#         `data-variavel` = "prec",
#         src = "figs/IC082026/IC082026_aprec_sazonal_SON.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal",
#       tags$figcaption("Anomalia percentual de precipitação (%)"),
#       tags$img(
#         id = "img_tri_precperc",
#         class = "img-zoom-tri",
#         `data-variavel` = "precperc",
#         src = "figs/IC082026/IC082026_aprec_porcentagem_sazonal_SON.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal",
#       tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
#       tags$img(
#         id = "img_tri_temp",
#         class = "img-zoom-tri",
#         `data-variavel` = "temp",
#         src = "figs/IC082026/IC082026_aT2m_sazonal_SON_2026.png"
#       )
#     )
#   ),

#   div(
#     class = "controle-animacao",

#     div(
#       class = "botoes-animacao",

#       tags$button(
#         class = "controle-btn",
#         onclick = "mudarFrameTri(-1)",
#         HTML("&#9664;&#9664;")
#       ),

#       tags$button(
#         class = "controle-btn",
#         onclick = "iniciarAnimacaoTri()",
#         HTML("&#9654;")
#       ),

#       tags$button(
#         class = "controle-btn",
#         onclick = "pararAnimacaoTri()",
#         HTML("&#10074;&#10074;")
#       ),

#       tags$button(
#         class = "controle-btn",
#         onclick = "mudarFrameTri(1)",
#         HTML("&#9654;&#9654;")
#       )
#     ),

#     div(
#       class = "linha-slider",

#       tags$input(
#         id = "sliderTri",
#         type = "range",
#         min = "0",
#         max = "5",
#         value = "0",
#         step = "1",
#         oninput = "selecionarFrameTri(this.value)"
#       )
#     ),

#     div(
#       class = "labels-meses",
#       span("JAS"),
#       span("ASO"),
#       span("SON"),
#       span("OND"),
#       span("NDJ"),
#       span("DJF")
#     )
#   )
# )




    )
  ),  
##### Fim Pagina 1 #### 
########################################### 
# Pagina Resumo Metas #### 
# Desativada 
  # nav_panel(
  #   title = "Resumo das Metas",

  #   div(
  #     class = "pagina-infograficos",

  #     div(
  #       class = "cabecalho-pagina",
  #       h2("Resumo Integrado do SisMOM"),
  #       h3("Síntese visual das componentes do programa")
  #     ),

  #     div(
  #       class = "grade-infograficos",

  #       tags$figure(
  #         class = "card-infografico",
  #         tags$figcaption(
  #           "Monitoramento marítimo e detecção de embarcações - Metas 1, 2, 3 e 4"
  #         ),
  #         tags$img(
  #           class = "img-zoom",
  #           src = "figs/SisMOM_Infografico.png",
  #           alt = "Resumo integrado das metas 1, 2, 3 e 4 do SisMOM"
  #         )
  #       ),

  #       tags$figure(
  #         class = "card-infografico",
  #         tags$figcaption(
  #           "Meta 1 - Monitoramento marítimo e detecção de embarcações"
  #         ),
  #         tags$img(
  #           class = "img-zoom",
  #           src = "figs/meta01.png",
  #           alt = "Resumo integrado da Meta 1 do SisMOM"
  #         )
  #       ),

  #       tags$figure(
  #         class = "card-infografico",
  #         tags$figcaption(
  #           "Meta 4 - Avaliação da componente atmosférica do BESM"
  #         ),
  #         tags$img(
  #           class = "img-zoom",
  #           src = "figs/Infografico_Meta4_BESM.png",
  #           alt = "Resumo integrado da avaliação atmosférica do BESM"
  #         )
  #       )
  #     )
  #   )
  # ),

########## Pagina dos Videos 
### 
## 
  nav_panel(
    title = "Monitoramento Satélite",

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
########### Paginas Testes ########## 
#   nav_panel(
#     title = "Desenvolvimento",

#     div(
#       class = "page-sazonal",

#       div(
#         class = "topo",

#         div(
#           class = "topo-texto",
#           h1("Sistema de Monitoramento de Óleo no Mar - SisMOM"),
#           h2("Brazilian Earth System Model - BESM"),
#           h3("Dashboard Temporário da Sala de Situação")
#         ),

#         div(
#           class = "topo-logo",
#           tags$img(src = "icons/sismom_ftransp.png"),
#           tags$img(src = "icons/inpe.png")
#         )
#       ),

#       br(),

#       div(
#         class = "cards-columns",

#         div(
#           class = "card-operacional",
#           div(class = "titulo-card", "Previsão"),
#           div(class = "valor-card", "Sazonal")
#         ),

#         div(
#           class = "card-operacional",
#           div(class = "titulo-card", "Rodada"),
#           div(class = "valor-card", "Jul/2026")
#         ),

#         div(
#           class = "card-operacional",
#           div(class = "titulo-card", "Período"),
#           div(class = "valor-card", "Agosto a dezembro de 2026")
#         )
#       ),

#       br(),

#       div(
#         class = "painel-gif",

#         tags$figure(
#           class = "fig-tsm-gif",
#           tags$img(
#             class = "img-zoom",
#             src = "figs/sst/sstanim.gif",
#             alt = "Temperatura da superfície do mar"
#           )
#         ),

#         tags$figure(
#           class = "fig-tsm-gif",
#           tags$img(
#             class = "img-zoom",
#             src = "figs/sst/asstanim.gif",
#             alt = "Anomalia da temperatura da superfície do mar"
#           )
#         ),
#         br()
#       ),
#   div(
#   class = "painel-previsao",

#   h3(
#     id = "tituloMes",
#     "Previsão Mensal BESM - Setembro/2026"
#   ),

#   div(
#     class = "mapas-mensais",

#     tags$figure(
#       class = "figura-mensal figura-tsm",
#       tags$figcaption(
#         "Anomalia da temperatura da superfície do mar (°C)"
#       ),
#       tags$img(
#         id = "img_tsm",
#         class = "img-zoom",
#         src = "figs/IC082026/IC082026_aTSM_mensal_202609.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal figura-sec",
#       tags$figcaption(
#         "Anomalia de precipitação (mm/mês)"
#       ),
#       tags$img(
#         id = "img_prec",
#         class = "img-zoom",
#         src = "figs/IC082026/IC082026_aprec_mensal_202609.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal figura-sec",
#       tags$figcaption(
#         "Anomalia percentual de precipitação (%)"
#       ),
#       tags$img(
#         id = "img_precperc",
#         class = "img-zoom",
#         src = "figs/IC082026/IC082026_aprec_porcentagem_mensal_202609.png"
#       )
#     ),

#     tags$figure(
#       class = "figura-mensal figura-sec",
#       tags$figcaption(
#         "Anomalia da temperatura a 2 m (°C)"
#       ),
#       tags$img(
#         id = "img_temp",
#         class = "img-zoom",
#         src = "figs/IC082026/IC082026_aT2m_mensal_202609.png"
#       )
#     )
#   ),

# div(
#   class = "controle-animacao",

#   # Linha 1: botões
#   div(
#     class = "botoes-animacao",

#     actionButton(
#       "dummy",
#       NULL,
#       class = "controle-btn",
#       icon = icon("backward"),
#       onclick = "mudarFrame(-1)"
#     ),

#     actionButton(
#       "dummy2",
#       NULL,
#       class = "controle-btn",
#       icon = icon("play"),
#       onclick = "iniciarAnimacao()"
#     ),

#     actionButton(
#       "dummy3",
#       NULL,
#       class = "controle-btn",
#       icon = icon("pause"),
#       onclick = "pararAnimacao()"
#     ),

#     actionButton(
#       "dummy4",
#       NULL,
#       class = "controle-btn",
#       icon = icon("forward"),
#       onclick = "mudarFrame(1)"
#     )
#   ),

#   # Linha 2: slider
#   div(
#     class = "linha-slider",

#     tags$input(
#       id = "sliderMes",
#       type = "range",
#       min = "0",
#       max = "5",
#       value = "0",
#       step = "1",
#       oninput = "selecionarFrame(this.value)"
#     )
#   ),

#   # Linha 3: meses
#   div(
#     class = "labels-meses",
#     span("Set"),
#     span("Out"),
#     span("Nov"),
#     span("Dez"),
#     span("Jan"),
#     span("Fev")
#   )
# )
# ),
#       br(),

#       div(
#         class = "mapa-box-main",
#         h3("Previsão Trimestral BESM - ASO/2026"),

#         div(
#           class = "bloco-mapas",

#           div(
#             class = "mapas-sec",

#             tags$figure(
#               class = "figura-sec-tsm",
#               tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
#               tags$img(
#                 class = "img-zoom",
#                 src = "figs/IC072026/tsm/IC072026_aTSM_ASO2026.png"
#               )
#             ),

#             tags$figure(
#               class = "figura-sec",
#               tags$figcaption("Anomalia de precipitação (mm/mês)"),
#               tags$img(
#                 class = "img-zoom",
#                 src = "figs/IC072026/prec/IC072026_aprec_mmmes_ASO2026.png"
#               )
#             ),

#             tags$figure(
#               class = "figura-sec",
#               tags$figcaption("Anomalia percentual de precipitação (%)"),
#               tags$img(
#                 class = "img-zoom",
#                 src = "figs/IC072026/prec/IC072026_aprec_porcentagem_ASO2026.png"
#               )
#             ),

#             tags$figure(
#               class = "figura-sec",
#               tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
#               tags$img(
#                 class = "img-zoom",
#                 src = "figs/IC072026/t2m/IC072026_aT2m_C_ASO2026.png"
#               )
#             )
#           )
#         )
#       )
#     )
#   ),
##### Inicio Pagina Inicial Deslocada #######
  #   nav_panel(
  #   title = "Operacional",

  #   div(
  #     class = "page-sazonal",

  #     div(
  #       class = "topo",

  #       div(
  #         class = "topo-texto",
  #         h1("Sistema de Monitoramento de Óleo no Mar - SisMOM"),
  #         h2("Brazilian Earth System Model - BESM"),
  #         h3("Dashboard Temporário da Sala de Situação")
  #       ),

  #       div(
  #         class = "topo-logo",
  #         tags$img(src = "icons/sismom_ftransp.png"),
  #         tags$img(src = "icons/inpe.png")
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "cards-columns",

  #       div(
  #         class = "card-operacional",
  #         div(class = "titulo-card", "Previsão"),
  #         div(class = "valor-card", "Sazonal")
  #       ),

  #       div(
  #         class = "card-operacional",
  #         div(class = "titulo-card", "Rodada"),
  #         div(class = "valor-card", "Jul/2026")
  #       ),

  #       div(
  #         class = "card-operacional",
  #         div(class = "titulo-card", "Período"),
  #         div(class = "valor-card", "Setembro de 2026 a fevereiro de 2027")
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "painel-gif",

  #       tags$figure(
  #         class = "fig-tsm-gif",
  #         tags$img(
  #           class = "img-zoom",
  #           src = "figs/sst/sstanim.gif",
  #           alt = "Temperatura da superfície do mar"
  #         )
  #       ),

  #       tags$figure(
  #         class = "fig-tsm-gif",
  #         tags$img(
  #           class = "img-zoom",
  #           src = "figs/sst/asstanim.gif",
  #           alt = "Anomalia da temperatura da superfície do mar"
  #         )
  #       ),
  #       br()
  #     ),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Mensal BESM - Agosto/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_202608.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_202608.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202608.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C202608.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Trimestral BESM - ASO/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_ASO2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia de precipitação (mm/mês)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_ASO2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia percentual de precipitação (%)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_ASO2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C_ASO2026.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Mensal BESM - Setembro/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_202609.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_202609.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202609.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C202609.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Trimestral BESM - SON/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_SON2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia de precipitação (mm/mês)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_SON2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia percentual de precipitação (%)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_SON2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C_SON2026.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Mensal BESM - Outubro/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_202610.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_202610.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202610.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C202610.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Trimestral BESM - OND/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_OND2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia de precipitação (mm/mês)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_OND2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia percentual de precipitação (%)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_OND2026.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C_OND2026.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Mensal BESM - Novembro/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_202611.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_202611.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202611.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C202611.png"
  #             )
  #           )
  #         )
  #       )
  #     ),

  #     br(),

  #     div(
  #       class = "mapa-box-main",
  #       h3("Previsão Mensal BESM - Dezembro/2026"),

  #       div(
  #         class = "bloco-mapas",

  #         div(
  #           class = "mapas-sec",

  #           tags$figure(
  #             class = "figura-sec-tsm",
  #             tags$figcaption("Anomalia da temperatura da superfície do mar (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/tsm/IC072026_aTSM_202612.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia de precipitação<br>(mm/mês)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_mmmes_202612.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption(HTML("Anomalia percentual<br>de precipitação (%)")),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/prec/IC072026_aprec_porcentagem_202612.png"
  #             )
  #           ),

  #           tags$figure(
  #             class = "figura-sec",
  #             tags$figcaption("Anomalia da temperatura a 2 m (°C)"),
  #             tags$img(
  #               class = "img-zoom",
  #               src = "figs/IC072026/t2m/IC072026_aT2m_C202612.png"
  #             )
  #           )
  #         )
  #       )
  #     )
  #   )
  # ),
##### Fim Pagina Inicial Deslocada #######  

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
