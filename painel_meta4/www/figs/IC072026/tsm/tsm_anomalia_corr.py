# =====================================================
# BIBLIOTECAS
# =====================================================

import xarray as xr
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import matplotlib.colors as mcolors
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from cartopy.util import add_cyclic_point

# =====================================================
# ARQUIVO DE ANOMALIA DE TSM
# =====================================================

arq_anom = "/mnt/d/sismom/dados/IC072026/dados/tsm/atemp_stdcor_ens.nc"

ds = xr.open_dataset(arq_anom)

# =====================================================
# VARIÁVEL
# =====================================================

anom = ds.temp

# =====================================================
# NORMALIZA LONGITUDE
# =====================================================

anom = anom.assign_coords(
    longitude=((anom.longitude + 180) % 360) - 180
)

anom = anom.sortby("longitude")

# =====================================================
# PALETA DE CORES ANOMALIA TSM
# =====================================================

niveis = np.array([
    -5.0, -4.0, -3.0, -2.0, -1.0, -0.5,
    0.5,  1.0, 2.0, 3.0, 4.0, 5.0
])

cores = [
    "#022758",
    '#313695',
    '#4575b4',
    '#74add1',
    '#abd9e9',
    '#f7f7f7',
    '#fee090',
    '#fdae61',
    '#f46d43',
    '#d73027',
    "#7a0303",
]

cmap = mcolors.ListedColormap(cores)
# menores que -4
cmap.set_under('#021126')
# maiores que +4
cmap.set_over('#330000')
norm = mcolors.BoundaryNorm(niveis, cmap.N)

# =====================================================
# FORMATADORES DE LAT/LON
# =====================================================

def fmt_lon(x):

    x = ((x + 180) % 360) - 180

    if x < 0:
        return f"{int(abs(x))}W"
    elif x > 0:
        return f"{int(x)}E"
    else:
        return "0"

def fmt_lat(y):

    if y < 0:
        return f"{int(abs(y))}S"
    elif y > 0:
        return f"{int(y)}N"
    else:
        return "0"

# =====================================================
# LOOP DOS 5 TEMPOS
# =====================================================

for t in range(min(5, anom.sizes["time"])):
    dado_mes = anom.isel(time=t)

    mes = int(dado_mes.time.dt.month.values)
    ano = int(dado_mes.time.dt.year.values)


    fig = plt.figure(figsize=(10, 6))


    ax = plt.axes(
        projection=ccrs.PlateCarree(
            central_longitude=-60
        )
    )


    ax.set_extent(
        [-180, 180, -65, 65],
        crs=ccrs.PlateCarree()
    )

    # =================================================
    # FECHAMENTO DA GRADE GLOBAL
    # =================================================

    dado_ciclico, lon_ciclico = add_cyclic_point(
        dado_mes.values,
        coord=dado_mes.longitude.values
    )

    # =================================================
    # PLOT
    # =================================================

    cf = ax.contourf(
        lon_ciclico,
        dado_mes.latitude,
        dado_ciclico,
        levels=niveis,
        cmap=cmap,
        norm=norm,
        extend="both",
        transform=ccrs.PlateCarree()
    )

    # =================================================
    # FEIÇÕES GEOGRÁFICAS
    # =================================================

    ax.add_feature(
        cfeature.LAND,
        facecolor="lightgray",
        zorder=2
    )

    ax.add_feature(
        cfeature.COASTLINE,
        linewidth=0.5,
    )

    ax.add_feature(
        cfeature.BORDERS,
        linewidth=0.3
    )

    # =================================================
    # TICKS
    # =================================================

    gl = ax.gridlines(
    crs=ccrs.PlateCarree(),
    draw_labels=True,
    xlocs=np.arange(-180, 181, 60),
    ylocs=np.arange(-60, 61, 30),
    linewidth=0.3,
    color="gray",
    linestyle="--",
    alpha=0.5
    )

    gl.top_labels = False
    gl.right_labels = False

    gl.xformatter = mticker.FuncFormatter(
        lambda x, pos: fmt_lon(x)
    )

    gl.yformatter = mticker.FuncFormatter(
        lambda y, pos: fmt_lat(y)
    )

    gl.xlabel_style = {"size": 8}
    gl.ylabel_style = {"size": 8}

    # =================================================
    # TÍTULO
    # =================================================

# ax.set_title(
#         f"Anomalia de TSM - {meses_pt[mes]} {ano}",
#         fontsize=12
#     )

    # =================================================
    # COLORBAR
    # =================================================

    cbar = plt.colorbar(
        cf,
        orientation="horizontal",
        pad=0.05,
        aspect=40
    )


    cbar.set_ticks([
        -5.0, -4.0, -3.0, -2.0, -1.0, -0.5,
    0.5,  1.0, 2.0, 3.0, 4.0, 5.0
    ])
    cbar.ax.tick_params(labelsize=8)

# cbar.set_label(
#         "Anomalia TSM (°C)"
#     )

    # =================================================
    # SALVA
    # =================================================

    nome = (
        f"IC072026_aTSM_"
        f"{ano}{mes:02d}.png"
    )

    plt.savefig(
        nome,
        dpi=300,
        bbox_inches="tight",
        transparent=True
    )

    plt.close(fig)

    print("Figura salva:", nome)

ds.close()
