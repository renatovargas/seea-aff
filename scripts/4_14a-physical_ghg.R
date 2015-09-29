 # SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# --------------------------------------------------------------------
#        TABLE 4.14a PHYSICAL FLOW ACCOUNT FOR GREENHOUSE GAS EMISSIONS
# --------------------------------------------------------------------

# IMPORTANT NOTE: As proposed by the SEEA AFF Manual this file will 
# yield a multi dimensional cross table of emmission type by energy 
# commodity it is combusted from, repeating by Economic Activity 
# aggregations. See manual, p. 98.

# The result is an unwieldy table, of 3 rows by 78 columns, which
# in turn requires the introduction of yet another table-ad-hoc 
# industry classification.

# For manageability, we propose a different presentation of the data
# with three separate commodity by industry table similar to the energy
# use table 4.13 for each greenhouse gas that can be stacked on top of
# one another. We call that one 4.14 and dispense with the recommendation.


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
# Rtools not necessary for other operating systems (e.g. Mac, Linux).

library("RPostgreSQL")
library("openxlsx")

# Clean work area
rm(list=ls())

# It's good to know where you are
currentdir <- getwd()


# II. GHG Emissions table
# =======================

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
host="78.138.104.206", port="5432", user="naturacc_onil", 
password="onilidb1234")

# In order to avoid accented character encoding issues on Windows,
sys <- Sys.info()["sysname"]
if(sys["sysname"] == "Windows"){
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");} 

# Query database
# We are interested in emissions for all 
# agricultural industries mainly.

use <- dbGetQuery(con, 
                  "SELECT	
                  scaeemis.npg
                  ,npg336.producto AS product
                  ,scaeemis.ntg
                  ,ntg20.trans AS transaction
                  ,scaeemis.naeg
                  ,naeg100.actividad AS industry
                  ,CASE 
                  WHEN
                  scaeemis.naeg BETWEEN 110 AND 240
                  THEN 	'01. Agriculture'
                  WHEN
                  scaeemis.naeg BETWEEN 310 AND 520
                  THEN 	'02. Livestock and livestock services (excl. vet.)'
                  WHEN
                  scaeemis.naeg = 620
                  THEN 	'03. Forestry'
                  WHEN
                  scaeemis.naeg BETWEEN 710 AND 750
                  THEN 	'04. Fisheries and aquaculture'
                  WHEN
                  scaeemis.naeg BETWEEN 810 AND 5910
                  THEN 	'05. Other industries'
                  WHEN
                  (scaeemis.naeg = 0
                  AND
                  scaeemis.ntg = 6150) 
                  THEN '06. Households'
                  WHEN
                  (scaeemis.naeg = 0
                  AND
                  scaeemis.ntg BETWEEN 6160 AND 6170) 
                  THEN '07. Other final consumption'
                  WHEN
                  (scaeemis.naeg = 0
                  AND
                  scaeemis.ntg BETWEEN 6040 AND 6050) 
                  THEN '08. Exports'
                  ELSE '09. Other adjustments'
                  END as seeaaff
                  ,unidades.abrev
                  ,scaeemis.datofisico as ph_output
                  ,scaeemis.id_emis
                  ,clasifemis.nombre as em_type
                  FROM scaeemis
                  LEFT JOIN npg336
                  ON scaeemis.npg = npg336.cod
                  LEFT JOIN ntg20
                  ON scaeemis.ntg = ntg20.cod
                  LEFT JOIN naeg100
                  ON scaeemis.naeg = naeg100.cod
                  LEFT JOIN unidades
                  ON scaeemis.dimfisico = unidades.id
                  LEFT JOIN clasifemis
                  ON scaeemis.id_emis = clasifemis.cod
                  WHERE
                  scaeemis.ann = 2010
                  AND
                  scaeemis.flujo = 5
                  AND
                  scaeemis.cuenta = 8
                  AND
                  scaeemis.ntg BETWEEN 6001 AND 6260
                  ORDER BY
                  scaeemis.npg,seeaaff,scaeemis.naeg;
                  ")

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")


use$product <- factor(use$product, levels=unique(use$product))
#use$seeaaff <- factor(use$seeaaff, levels=unique(use$seeaaff))
useTable <- as.table(ftable(xtabs(ph_output ~ em_type + product + seeaaff, data=use)))
useTable <- addmargins(useTable)



# EXCEL REPORT
# ============ 

wb <- createWorkbook("SEEA AFF Guatemala")

## create and add a style to the column headers
headerStyle <- createStyle(border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
#addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:5, gridExpand = TRUE)

## Font style for all body
bodyStyle <- createStyle(numFmt="COMMA", fontName="Arial Narrow", fontSize=10)
#addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(supplyTable)[1]), cols = 2:5, gridExpand = TRUE)

rowNamesStyle <- createStyle(fontName="Arial Narrow", fontSize=10)
#addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(supplyTable)[1]+1), cols=1, gridExpand = TRUE)

footerStyle <- createStyle(numFmt="COMMA", border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
#addStyle(wb, sheet = 1, footerStyle, rows = (dim(supplyTable)[1] + 2), cols = 1:5, gridExpand = TRUE)
#setColWidths(wb, 1, cols=1:5, widths = "auto") 


# Note that I changed worksheet 2 to 1 down here because there is no supply table

addWorksheet(wb, "4.14a GHG Emissions as Manual")
##write data to worksheet 1
writeData(wb, sheet = 1, useTable, rowNames = TRUE, startRow = 2)

#addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:78, gridExpand = TRUE)

#addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(useTable)[1]), cols = 2:(dim(useTable)[2] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(useTable)[1]), cols = 2:78, gridExpand = TRUE)

addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(useTable)[1]+1), cols=1, gridExpand = TRUE)

#addStyle(wb, sheet = 1, footerStyle, rows = 1+(dim(useTable)[1] + 1), cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 1, footerStyle, rows = 1+(dim(useTable)[1] + 1), cols = 1:78, gridExpand = TRUE)

#setColWidths(wb, 1, cols=1:(dim(useTable)[2]+1), widths = "auto") 
setColWidths(wb, 1, cols=1:78, widths = "auto") 


## set column width for row names column
saveWorkbook(wb, "table0414a.xlsx", overwrite = TRUE)
openXL("table0414a.xlsx")



# Where is it?
paste("Check out your file at: ",currentdir,"/table0414a.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())
