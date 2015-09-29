 # SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.13 PHYSICAL FLOW ACCOUNT FOR ENERGY
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


# II. ENERGY USE TABLE
# ====================

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="naturacc_cuentas", 
host="78.138.104.206", port="5432", user="naturacc_onil", 
password="onilidb1234")

# In order to avoid accented character encoding issues on Windows,
sys <- Sys.info()["sysname"]
if(sys["sysname"] == "Windows"){
postgresqlpqExec(con, "SET client_encoding = 'windows-1252'");} 

# Query database
# We are interested in energy use for all 
# agricultural industries mainly.

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
			scae.naeg = 110
		THEN 	'01. Coffee'
		WHEN
			scae.naeg = 120
		THEN 	'02. Bananas'
		WHEN
			scae.naeg = 130
		THEN 	'03. Cardamum'
		WHEN
			scae.naeg = 210
		THEN 	'04. Cereals and other npc'
		WHEN
			scae.naeg = 220
		THEN 	'05. Tubers, roots, vegetables, legumes, horticulture, and greenhouse crops'
		WHEN
			scae.naeg = 230
		THEN 	'06. Fruits, nuts, teas, spices'
		WHEN
			scae.naeg = 240
		THEN 	'07. Other crops (Food/non-food)'
		WHEN
			scae.naeg BETWEEN 310 AND 520
		THEN 	'08. Livestock and livestock services (excl. vet.)'
		WHEN
			scae.naeg = 620
		THEN 	'09. Forestry'
		WHEN
			scae.naeg BETWEEN 710 AND 750
		THEN 	'10. Fisheries and aquaculture'
		WHEN
			scae.naeg BETWEEN 810 AND 3620
		THEN 	'11. Manufactures, mineral extraction, construction, and utilities (excl. electricity)'
		WHEN
			scae.naeg BETWEEN 3810 AND 3910
		THEN 	'11. Manufactures, mineral extraction, construction, and utilities (excl. electricity)'
		WHEN
			scae.naeg = 3710
		THEN 	'12. Electricity'
		WHEN
			scae.naeg BETWEEN 4010 AND 5910
		THEN 	'13. Other industries'
    WHEN
      (scae.naeg = 0
    AND
      scae.ntg = 6150) 
    THEN '14. Households'
    WHEN
      (scae.naeg = 0
    AND
      scae.ntg BETWEEN 6160 AND 6170) 
    THEN '15. Other final consumption'
    WHEN
      (scae.naeg = 0
    AND
      scae.ntg BETWEEN 6040 AND 6050) 
    THEN '16. Exports'
    ELSE '17. Other adjustments'
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
	scae.cuenta = 4
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

addWorksheet(wb, "4.13 Enegy Use")
##write data to worksheet 1
writeData(wb, sheet = 1, useTable, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(useTable)[1]), cols = 2:(dim(useTable)[2] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(useTable)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 1, footerStyle, rows = 1+(dim(useTable)[1] + 1), cols = 1:(dim(useTable)[2]+1), gridExpand = TRUE)
setColWidths(wb, 1, cols=1:(dim(useTable)[2]+1), widths = "auto") 



## set column width for row names column
saveWorkbook(wb, "table0413.xlsx", overwrite = TRUE)
openXL("table0413.xlsx")



# Where is it?
paste("Check out your file at: ",currentdir,"/table0413.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())
