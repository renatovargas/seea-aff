# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.5 PHYSICAL FLOW ACCOUNT FOR TIMBER
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
# Rtools not necessary for other operating systems (e.g. Mac, Linux).

library("RPostgreSQL")
library("openxlsx")

# Clean work area
rm(list=ls())

# It's good to know where you are
currentdir <- getwd()


# II. SUPPLY TABLE
# ================

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
# We are interested in the output in tonnes for all 
# agricultural products.

# This query extracts the information that we need:
sup <- dbGetQuery(con, "
SELECT
	scae.npg
	,npg336.producto AS product
	,scae.ntg
	,ntg20.trans AS transaction
	,scae.naeg
	,naeg100.actividad AS industry
	,CASE
		WHEN 
			scae.naeg BETWEEN 110 AND 750
		AND
			scae.ntg = 6001
		THEN 	'1. Agricultural Industries'
		WHEN
			scae.naeg BETWEEN 810 AND 5910
		AND
			scae.ntg = 6001
		THEN	'2. Manufacturing and other Industries'
		WHEN
			scae.naeg = 0
		AND
			scae.ntg = 6010
		THEN 	'3. Imports'
		WHEN    
			scae.naeg=0 
		AND
			scae.ntg != 6010	
		THEN	ntg20.trans
	END AS seeaaff
	,unidades.abrev
	,scae.datofisico as ph_output
FROM scae
LEFT JOIN npg336
  ON scae.npg = npg336.cod
LEFT JOIN ntg20
  ON scae.ntg = ntg20.cod
LEFT JOIN naeg100
  ON scae.naeg = naeg100.cod
LEFT JOIN unidades
  ON scae.dimfisico = unidades.id
WHERE
     scae.ann = 2010
AND
     scae.flujo = 1
AND
     (scae.ntg = 6001
OR
	scae.ntg = 6010)
AND
	scae.cuenta = 3
ORDER BY
     scae.ntg, seeaaff, scae.naeg, scae.npg;
");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

sup$product <- factor(sup$product, levels=unique(sup$product))
supplyTable <- as.table(xtabs(ph_output ~ product + seeaaff, data=sup))
supplyTable <- addmargins(supplyTable)
#colnames(supplyTable)[dim(table0401a)[2]] <- "Total Supply"
#rownames(supplyTable)[dim(table0401a)[1]] <- "Total"

# Notes:
# 1. There is no distinction between forestry and logging in SEEA GT
# 2. Animal species might have recording issues, but we leave it preliminarily.


# III. USE TABLE
# ==============

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
host="78.138.104.206", port="5432", user="naturacc_onil", 
password="onilidb1234")

# In order to avoid accented character encoding issues on Windows,
sys <- Sys.info()["sysname"]
if(sys["sysname"] == "Windows"){
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");} 

# Query database
# We are interested in the use in tonnes for all 
# agricultural products.

# This query extracts the information that we need:
use <- dbGetQuery(con, 
"SELECT	
	scae.npg
	,npg336.producto AS product
	,scae.ntg
	,ntg20.trans AS transaction
	,scae.naeg
	,naeg100.actividad AS industry
	,CASE 
		WHEN 
			scae.naeg BETWEEN 110 AND 750
		AND
			scae.ntg = 6002
		THEN 	'1. Agricultural Industries'
		WHEN
			scae.naeg BETWEEN 810 AND 5910
		AND
			scae.ntg = 6002
		THEN	'2. Manufacturing and other Industries'
		WHEN
			scae.naeg = 0
		THEN 	ntg20.trans
    END as seeaaff
	,unidades.abrev
	,scae.datofisico as ph_output
FROM scae
LEFT JOIN npg336
  ON scae.npg = npg336.cod
LEFT JOIN ntg20
  ON scae.ntg = ntg20.cod
LEFT JOIN naeg100
  ON scae.naeg = naeg100.cod
LEFT JOIN unidades
  ON scae.dimfisico = unidades.id
WHERE
     scae.ann = 2010
AND
     scae.flujo = 2
AND
	scae.cuenta = 3
AND
     scae.ntg BETWEEN 6002 AND 6260

ORDER BY
     scae.npg,seeaaff,scae.naeg;
     ")

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")


use$product <- factor(use$product, levels=unique(use$product))
#use$seeaaff <- factor(use$seeaaff, levels=unique(use$seeaaff))
useTable <- as.table(xtabs(ph_output ~ product + seeaaff, data=use))
useTable <- addmargins(useTable)



# EXCEL REPORT
# ============ 

wb <- createWorkbook("SEEA AFF Guatemala")
## Add a worksheet
addWorksheet(wb, "4.05 Timber Supply")
##write data to worksheet 1
writeData(wb, sheet = 1, supplyTable, rowNames = TRUE, startRow = 2)

## create and add a style to the column headers
headerStyle <- createStyle(border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:5, gridExpand = TRUE)

## Font style for all body
bodyStyle <- createStyle(numFmt="COMMA", fontName="Arial Narrow", fontSize=10)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(supplyTable)[1]), cols = 2:5, gridExpand = TRUE)

rowNamesStyle <- createStyle(fontName="Arial Narrow", fontSize=10)
addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(supplyTable)[1]+1), cols=1, gridExpand = TRUE)

footerStyle <- createStyle(numFmt="COMMA", border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
addStyle(wb, sheet = 1, footerStyle, rows = (dim(supplyTable)[1] + 2), cols = 1:5, gridExpand = TRUE)
setColWidths(wb, 1, cols=1:5, widths = "auto") 



addWorksheet(wb, "4.05 Timber Use")
##write data to worksheet 2
writeData(wb, sheet = 2, useTable, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 2, headerStyle, rows = 2:2, cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 2, bodyStyle, rows = 3:(3+dim(useTable)[1]), cols = 2:(dim(useTable)[1] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 2, rowNamesStyle, rows = 3:(dim(useTable)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 2, footerStyle, rows = 1+(dim(useTable)[1] + 1), cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
setColWidths(wb, 2, cols=1:(dim(useTable)[2]+1), widths = "auto") 



## set column width for row names column
saveWorkbook(wb, "table0405.xlsx", overwrite = TRUE)
openXL("table0405.xlsx")



# Where is it?
paste("Check out your file at: ",currentdir,"/table04002.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())
