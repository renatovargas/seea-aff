# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.2 PHYSICAL FLOW ACCOUNT FOR LIVESTOCK
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
# We are interested in the output in tonnes for all 
# agricultural products.

# This query extracts the information that we need:
sup <- dbGetQuery(con, 
"SELECT
    scn.npg as npg,
    npg336.producto as product,
    scn.naeg as naeg,
    naeg100.actividad as industry,
    scn.ntg as ntg,
    ntg20.trans as transaction,
	CASE 
		WHEN 
			scn.naeg BETWEEN 110 AND 750
		AND
			scn.ntg = 6001
		THEN 	'1. Agricultural Industries'
		WHEN
			scn.naeg BETWEEN 810 AND 5910
		AND
			scn.ntg = 6001
		THEN	'3. Manufacturing and other Industries'
		WHEN
			scn.naeg = 0
		AND
			scn.ntg = 6010
		THEN 	'4. Imports'
		WHEN    
			scn.naeg=0 
		AND
			scn.ntg != 6010	
		THEN	ntg20.trans
    END as seeaaff,
    scn.datofisico AS physical
FROM scn
LEFT JOIN npg336
  ON scn.npg = npg336.cod
LEFT JOIN ntg20
  ON scn.ntg = ntg20.cod
LEFT JOIN naeg100
  ON scn.naeg = naeg100.cod
WHERE
     scn.ann = 2010
AND
	(scn.npg BETWEEN 130100 AND 149900
OR
	scn.npg BETWEEN 200100 AND 209900)
AND
     scn.flujo = 1
AND
     (scn.ntg = 6001
OR
	scn.ntg = 6010)
ORDER BY
     scn.npg, seeaaff;");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

sup$product <- factor(sup$product, levels=unique(sup$product))
table0401a <- as.table(xtabs(physical ~ product + seeaaff, data=sup))
table0401a <- addmargins(table0401a)
#colnames(table0401a)[4] <- "Total Supply"
#rownames(table0401a)[dim(table0401a)[1]] <- "Total"

# Write it out for the report:

#write.xlsx(table0401a, "table0401a.xlsx", sheetName="table 4.01", encoding = "latin1")

# If you don't want an Excel file and prefer a Comma Separated Values file,
# uncomment either of the next files, depending on the wished Encoding
#write.csv(table0401a, "table0401a.csv")
#write.csv(xt, "table0401.csv", fileEncoding = "UTF-8")

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
    scn.npg as npg,
    npg336.producto as product,
    scn.naeg as naeg,
    naeg100.actividad as industry,
    scn.ntg as ntg,
    ntg20.trans as transaction,
	CASE 
		WHEN 
			scn.naeg BETWEEN 110 AND 240
		AND
			scn.ntg = 6002
		THEN 	'1. Agricultural Industries for seed'
		WHEN
			scn.naeg BETWEEN 310 AND 460
		AND
			scn.ntg = 6002
		THEN	'2. Agricultural Industries for feed'
		WHEN
			scn.naeg BETWEEN 520 AND 710
		AND	
			scn.ntg = 6002
		THEN	'3. Other agriculture'
		WHEN
			scn.naeg = 720
		THEN	'2. Agricultural Industries for feed'
		WHEN
			scn.naeg BETWEEN 730 AND 750
		AND	
			scn.ntg = 6002
		THEN	'3. Other Agricultural Industries'
		WHEN
			scn.naeg BETWEEN 810 AND 1020
		AND	
			scn.ntg = 6002
		THEN	'6. Non-Food Processing Industries'
		WHEN
			scn.naeg BETWEEN 1110 AND 2050
		AND	
			scn.ntg = 6002
		THEN	'5. Food Processing Industries'
		WHEN
			scn.naeg BETWEEN 2110 AND 3620
		AND	
			scn.ntg = 6002
		THEN	'6. Non-Food Processing Industries'
		WHEN
			scn.naeg = 3710
		THEN	'4. Energy Industries (Electricity)'
		WHEN
			scn.naeg BETWEEN 3810 AND 4030
		AND	
			scn.ntg = 6002
		THEN	'6. Non-Food Processing Industries'
		WHEN
			scn.naeg BETWEEN 4110 AND 4120
		AND	
			scn.ntg = 6002
		THEN	'7. Hotels and Restaurants'
		WHEN
			scn.naeg BETWEEN 4210 AND 5910
		AND	
			scn.ntg = 6002
		THEN	'6. Non-Food Processing Industries'
		WHEN
			scn.naeg = 0
		THEN 	ntg20.trans
    END as seeaaff,
    scn.datofisico AS physical
FROM scn
LEFT JOIN npg336
  ON scn.npg = npg336.cod
LEFT JOIN ntg20
  ON scn.ntg = ntg20.cod
LEFT JOIN naeg100
  ON scn.naeg = naeg100.cod
WHERE
     scn.ann = 2010
AND
	(scn.npg BETWEEN 130100 AND 149900
OR
	scn.npg BETWEEN 200100 AND 209900)
AND
     scn.flujo = 2
AND
     scn.ntg BETWEEN 6002 AND 6260

ORDER BY
     scn.npg,scn.naeg, scn.ntg")

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

use$product <- factor(use$product, levels=unique(use$product))
#use$seeaaff <- factor(use$seeaaff, levels=unique(use$seeaaff))
table0401b <- as.table(xtabs(physical ~ product + seeaaff, data=use))
table0401b <- addmargins(table0401b)



# EXCEL REPORT
# ============ 

wb <- createWorkbook("SEEA AFF")
## Add a worksheet
addWorksheet(wb, "4.02 Livestock Supply")
##write data to worksheet 1
writeData(wb, sheet = 1, table0401a, rowNames = TRUE, startRow = 2)

## create and add a style to the column headers
headerStyle <- createStyle(border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:5, gridExpand = TRUE)

## Font style for all body
bodyStyle <- createStyle(numFmt="COMMA", fontName="Arial Narrow", fontSize=10)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(table0401a)[1]), cols = 2:5, gridExpand = TRUE)

rowNamesStyle <- createStyle(fontName="Arial Narrow", fontSize=10)
addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(table0401a)[1]+1), cols=1, gridExpand = TRUE)

footerStyle <- createStyle(numFmt="COMMA", border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
addStyle(wb, sheet = 1, footerStyle, rows = (dim(table0401a)[1] + 2), cols = 1:5, gridExpand = TRUE)
setColWidths(wb, 1, cols=1:5, widths = "auto") 



addWorksheet(wb, "4.02 Livestock Use")
##write data to worksheet 2
writeData(wb, sheet = 2, table0401b, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 2, headerStyle, rows = 2:2, cols = 1:(dim(table0401b)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 2, bodyStyle, rows = 3:(3+dim(table0401a)[1]), cols = 2:(dim(table0401a)[1] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 2, rowNamesStyle, rows = 3:(dim(table0401b)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 2, footerStyle, rows = 1+(dim(table0401a)[1] + 1), cols = 1:(dim(table0401b)[2]+1), gridExpand = TRUE)
setColWidths(wb, 2, cols=1:(dim(table0401b)[2]+1), widths = "auto") 

## set column width for row names column
saveWorkbook(wb, "table0402.xlsx", overwrite = TRUE)





openXL("table0402.xlsx")

# Where is it?
paste("Check out your file at: ",currentdir,"/table04002.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())
