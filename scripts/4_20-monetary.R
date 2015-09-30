# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.20 MONETARY FLOW ACCOUNT
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
sys <- Sys.info()["sysname"]
if(sys["sysname"] == "Windows"){
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");} 

# Query database
# We are interested in monetary flows for agriculture,
# forestry, and fisheries.

# This query extracts the information that we need:
sup <- dbGetQuery(con, 
"SELECT
    scn.npg as npg,
    npg336.producto as product,
    scn.naeg as naeg,
    naeg100.actividad as industry,
    ntg9.id || ' ' || ntg9.trans as transaction,
    CASE
    WHEN
      scn.npg BETWEEN 10100 AND 129900
    THEN '1. Crop Products'
    WHEN
      scn.npg BETWEEN 130100 AND 139900
    THEN '2. Livestock Products'
    WHEN
      scn.npg BETWEEN 140100 AND 149900
    THEN '3. Other Agricultural Products'
    WHEN
      scn.npg BETWEEN 150100 AND 159900
    THEN '4. Forestry Products'
    WHEN
      scn.npg BETWEEN 160100 AND 169900
    THEN '5. Fisheries'
    ELSE '6. Rest of the economy'
    END as npgaff
    ,scn.datocou AS monetary
FROM scn
LEFT JOIN npg336
  ON scn.npg = npg336.cod
LEFT JOIN ntg20
  ON scn.ntg = ntg20.cod
LEFT JOIN ntg9
  ON ntg20.cod9 = ntg9.id
LEFT JOIN naeg100
  ON scn.naeg = naeg100.cod
WHERE
     scn.ann = 2010
AND
     scn.flujo = 1
AND
     scn.ntg BETWEEN 6001 AND 6260
ORDER BY
     npgaff, scn.ntg;");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

sup$product <- factor(sup$product, levels=unique(sup$product))
supTable <- as.table(xtabs(monetary ~ npgaff + transaction, data=sup))
supTable <- addmargins(supTable)


# III. USE TABLE
# ==============

# Connect to database
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
                 host="78.138.104.206", port="5432", user="naturacc_onil", 
                 password="onilidb1234")

# In order to avoid accented character encoding issues on Windows,
sys <- Sys.info()["sysname"]
if(sys["sysname"] == "Windows"){
  postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");} 

# Query database
# We are interested in monetary flows for agriculture,
# forestry, and fisheries.

# This query extracts the information that we need:
use <- dbGetQuery(con, 
                  "SELECT
                  scn.npg as npg,
                  npg336.producto as product,
                  scn.naeg as naeg,
                  naeg100.actividad as industry,
                  ntg9.id || ' ' || ntg9.trans as transaction,
                  CASE
                  WHEN
                  scn.npg BETWEEN 10100 AND 129900
                  THEN '1. Crop Products'
                  WHEN
                  scn.npg BETWEEN 130100 AND 139900
                  THEN '2. Livestock Products'
                  WHEN
                  scn.npg BETWEEN 140100 AND 149900
                  THEN '3. Other Agricultural Products'
                  WHEN
                  scn.npg BETWEEN 150100 AND 159900
                  THEN '4. Forestry Products'
                  WHEN
                  scn.npg BETWEEN 160100 AND 169900
                  THEN '5. Fisheries'
                  ELSE '6. Rest of the economy'
                  END as npgaff
                  ,scn.datocou AS monetary
                  FROM scn
                  LEFT JOIN npg336
                  ON scn.npg = npg336.cod
                  LEFT JOIN ntg20
                  ON scn.ntg = ntg20.cod
                  LEFT JOIN ntg9
                  ON ntg20.cod9 = ntg9.id
                  LEFT JOIN naeg100
                  ON scn.naeg = naeg100.cod
                  WHERE
                  scn.ann = 2010
                  AND
                  scn.flujo = 2
                  AND
                  scn.ntg BETWEEN 6001 AND 6260
                  ORDER BY
                  npgaff, scn.ntg;");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

use$product <- factor(use$product, levels=unique(use$product))
useTable <- as.table(xtabs(monetary ~ npgaff + transaction, data=use))
useTable <- addmargins(useTable)
#colnames(table0401a)[4] <- "Total Supply"
#rownames(table0401a)[dim(table0401a)[1]] <- "Total"


# EXCEL REPORT
# ============ 

wb <- createWorkbook("SEEA AFF Guatemala")

## Create styles
headerStyle <- createStyle(border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
bodyStyle <- createStyle(numFmt="COMMA", fontName="Arial Narrow", fontSize=10)
rowNamesStyle <- createStyle(fontName="Arial Narrow", fontSize=10)
footerStyle <- createStyle(numFmt="COMMA", border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")

## Add data to Excel sheets

addWorksheet(wb, "4.13a Monetary Supply")
##write data to worksheet 1
writeData(wb, sheet = 1, supTable, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:(dim(supTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(supTable)[1]), cols = 2:(dim(supTable)[2] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(supTable)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 1, footerStyle, rows = 1+(dim(supTable)[1] + 1), cols = 1:(dim(supTable)[2]+1), gridExpand = TRUE)
setColWidths(wb, 1, cols=1:(dim(supTable)[2]+1), widths = "auto") 

addWorksheet(wb, "4.13b Monetary Use")
writeData(wb, sheet = 2, useTable, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 2, headerStyle, rows = 2:2, cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 2, bodyStyle, rows = 3:(3+dim(useTable)[1]), cols = 2:(dim(useTable)[2] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 2, rowNamesStyle, rows = 3:(dim(useTable)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 2, footerStyle, rows = 1+(dim(useTable)[1] + 1), cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
setColWidths(wb, 2, cols=1:(dim(useTable)[2]+1), widths = "auto") 


## set column width for row names column
saveWorkbook(wb, "table0420.xlsx", overwrite = TRUE)
openXL("table0420.xlsx")



# Where is it?
paste("Check out your file at: ",currentdir,"/table0420.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())

