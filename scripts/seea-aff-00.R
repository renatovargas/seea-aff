# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff
#
# seea-aff-01 - Main .R file and SEEA GT data acquisition
#
# The System of Environmental-Economic Accounting for Agriculture,
# Forestry and Fisheries (SEEA AFF) is "a statistical framework for
# the organization of data that permits the description and analysis
# of the relationship between the environment and the economic 
# activities of agriculture, forestry and fisheries".
#
# Install packages:
#   "RPostgreSQL" 
#   "reshape"
#   "plyr"
#
# 1. Obtain data from SEEA database in PostgreSQL
# ===============================================

# Preamble

rm(list=ls())
library(RPostgreSQL)

# PostgreSQL data connection

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
host="78.138.104.206", port="5432", user="naturacc_onil", 
password="onilidb1234")

# Check the connection

dbListConnections(drv)
dbGetInfo(drv)
summary(con)

# List available tables

dbListTables(con)

# For Guatemala:
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
# Get the tables:
# "scn"       : Monetary value added, supply and use.
# "scae"      : System of Environmental and Economic Accounts.
# "scaeemis"  : Greenhouse gas emission data.
# "scaeresid" : Waste data.

scn       <- dbReadTable(con, "scn")
scae      <- dbReadTable(con, "scae")   
scaeemis  <- dbReadTable(con, "scaeemis")
scaeresid <- dbReadTable(con, "scaeresid")

# For now we leave classification definitions on the server.

# Close the connection to free resources locally and in the server.

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

# First few observations of the tables for basic check:

head(scn)
head(scae)
head(scaeemis)
head(scaeresid)

# Remember to empty workspace before ending the session (uncomment).
# rm(list=ls())