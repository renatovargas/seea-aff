# SEEA-AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA-AFF Github: https://github.com/renatovargas/seea-aff
#
#  SEEA-AFF 01 - DATOS INICIALES
#
# El SEEA-AFF tiene el objetivo general de examinar la conexión
# entre el ambiente y las actividades económicas relacionadas con
# la agricultura, la silvicultura y las actividades de pesca.
#
# Instalar paquetes:
#   "RPostgreSQL" 
#   "reshape"
#   "plyr"
#
# 1. DESCARGAR DATOS DE POSTGRESQL
# ================================
rm(list=ls())
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", host="78.138.104.206", port="5432", user="naturacc_onil", password="onilidb1234")

# Chequear la conexion

dbListConnections(drv)
dbGetInfo(drv)
summary(con)

# Ver las tablas disponibles

#dbListTables(con)

# En el caso de la bd del SCAE:
#
# [1] "naeg59"           "cuenconas"       "capa1"       "ggrn_dep"       
# [5] "npg227"           "ntt"             "topology"       "layer"          
# [9] "npg9"             "spatial_ref_sys" "cuencas"        "cta2"           
# [13] "cta1"            "naeg25"          "censo02"       "resid1"         
# [17] "censo02"         "scae"            "scn"            "naeg8"          
# [21] "naeg18"          "naeg100"         "flujos"        "npg336"         
# [25] "npg67"           "npg18"           "npgm"           "ntg20"          
# [29] "undepa"          "Munis_Segeplan"  "gpa_gc"          "depa"           
# [33] "scaeemis"        "clasifemis"      "region"        "koppen"         
# [37] "capa0"           "gpa_gl"          "tamanno"      "estragr"        
# [41] "cultanuales"     "anuales"         "pibdepa"         "cgrn"           
# [45] "ggrn_gc"         "cegi"            "ggrn_gl"         "cigg"           
# [49] "cultpermanentes" "permanentes"     "niv1_anual"      "ntg9"           
# [53] "cen2002"         "scaeresid"       "resid2" "munis_seg_n27"  
# [57] "cgen"            "cta_gc"          "cta0"          "cta_gl"         
# [61] "niv1"            "cuentas"         "unidades"    
#
# Obtenemos las bases de datos:
# "scn"       : Oferta y utilizacion monetaria.
# "scae"      : Contabilidad ambiental.
# "scaeemis"  : Emisiones de gases efecto invernadero.
# "scaeresid" : Residuos.

scn       <- dbReadTable(con, "scn")
scae      <- dbReadTable(con, "scae")   
scaeemis  <- dbReadTable(con, "scaeemis")
scaeresid <- dbReadTable(con, "scaeresid")

# Por el momento dejamos las tablas de definiciones en el servidor.

# Cerrar la conexion para liberar recursos y el servidor.

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

# Por ultimo chequeamos la integridad de las tablas:

head(scn)
head(scae)
head(scaeemis)
head(scaeresid)

# Vaciar el area de trabajo antes de salir