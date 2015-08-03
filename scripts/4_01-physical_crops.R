# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.1 PHYSICAL FLOW ACCOUNT FOR CROPS
# ------------------------------------------------------------------

# Comments start with #

# The System of Environmental-Economic Accounting for Agriculture,
# Forestry and Fisheries (SEEA AFF) is "a statistical framework for
# the organization of data that permits the description and analysis
# of the relationship between the environment and the economic 
# activities of agriculture, forestry and fisheries".

# I. PREAMBLE 
# ===========

# Read instalation instructions for your system and install packages
# "RpostgreSQL":
# https://cran.r-project.org/web/packages/RPostgreSQL/index.html
# and "openxlsx":
# https://cran.r-project.org/web/packages/openxlsx/index.html 
# For "openxlsx" make sure you install "Rtools.exe" under Windows
# https://cran.r-project.org/bin/windows/Rtools/
# Other OSs Rtools not necessary.

library("RPostgreSQL")
library("openxlsx")

# Clean work area
rm(list=ls())

# It's good to know where you are
currentdir <- getwd()


# II. SUPPLY TABLE
# ================

# See APPENDIX at the end to understand data acquisition basics

# Connect to database
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
host="78.138.104.206", port="5432", user="naturacc_onil", 
password="onilidb1234")

# In order to avoid accented character encoding issues on Windows,
# Windows users uncomment next line / Linux and Mac users comment it out with #
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");

# Query database
# We are interested in the output in tonnes for all 
# agricultural products.

# This query extracts the information that we need:
sup <- dbGetQuery(con, 
"SELECT
  npg336.producto AS product,
  ntg20.trans AS transaction,
  scn.datofisico AS physical
FROM scn
LEFT JOIN npg336
  ON scn.npg = npg336.cod
LEFT JOIN ntg20
  ON scn.ntg = ntg20.cod
WHERE
     scn.ann = 2010
AND
     scn.npg BETWEEN 10100 AND 129900
AND
     scn.flujo = 1
AND
     (scn.ntg = 6001 
OR
     scn.ntg = 6010)
ORDER BY
     scn.npg, ntg20.trans;");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

sup$product <- factor(sup$product, levels=unique(sup$product))
table0401a <- as.table(xtabs(physical ~., data=sup))
colnames(table0401a) <- c("Agriculture Industry", "Imports")
# Write it out for the report:

write.xlsx2(table0401a, "table0401a.xlsx", sheetName="table 4.01", encoding = "latin1")

# If you don't want an Excel file and prefer a Comma Separated Values file,
# uncomment next line
#write.csv(table0401a, "table0401a.csv")

# We leave utf-8 commented out just in case
#write.csv(xt, "table0401.csv", fileEncoding = "UTF-8")


# III. USE TABLE
# ==============




# APPENDIX 1. PostgreSQL data connection basics with R
# ====================================================

## Use package "RPostgreSQL" to connect
## More at: https://code.google.com/p/rpostgresql/
## https://cran.r-project.org/web/packages/RPostgreSQL/index.html
#
#library("RPostgreSQL")
#drv <- dbDriver("PostgreSQL")
#con <- dbConnect(drv, dbname="naturacc_cuentas", 
#host="78.138.104.206", port="5432", user="naturacc_onil", 
#password="onilidb1234")
#
## Check the connection
#
#dbListConnections(drv)
#dbGetInfo(drv)
#summary(con)
#
## List available tables
#
#dbListTables(con)
#
## For Guatemala:
##
## [1] "naeg59"           "cuenconas"       "capa1"       "ggrn_dep"       
## [5] "npg227"           "ntt"             "topology"       "layer"          
## [9] "npg9"             "spatial_ref_sys" "cuencas"        "cta2"           
## [13] "cta1"            "naeg25"          "censo02"       "resid1"         
## [17] "censo02"         "scae"            "scn"            "naeg8"          
## [21] "naeg18"          "naeg100"         "flujos"        "npg336"         
## [25] "npg67"           "npg18"           "npgm"           "ntg20"          
## [29] "undepa"          "Munis_Segeplan"  "gpa_gc"          "depa"           
## [33] "scaeemis"        "clasifemis"      "region"        "koppen"         
## [37] "capa0"           "gpa_gl"          "tamanno"      "estragr"        
## [41] "cultanuales"     "anuales"         "pibdepa"         "cgrn"           
## [45] "ggrn_gc"         "cegi"            "ggrn_gl"         "cigg"           
## [49] "cultpermanentes" "permanentes"     "niv1_anual"      "ntg9"           
## [53] "cen2002"         "scaeresid"       "resid2" "munis_seg_n27"  
## [57] "cgen"            "cta_gc"          "cta0"          "cta_gl"         
## [61] "niv1"            "cuentas"         "unidades"    
##
## Relevant tables:
## "scn"       : Monetary value added, supply and use.
## "scae"      : System of Environmental and Economic Accounts.
## "scaeemis"  : Greenhouse gas emission data.
## "scaeresid" : Waste data.
#
## Example of how to get an entire table
#
#scn       <- dbReadTable(con, "scn")
#
## Close the connection to free resources locally and in the server.
#
#dbDisconnect(con)
#dbUnloadDriver(drv)
#rm("con")
#rm("drv")
#
## First few observations of the tables for basic check:
#
#head(scn)
#
## Remember to empty workspace before ending the session (uncomment).
#rm(list=ls())
