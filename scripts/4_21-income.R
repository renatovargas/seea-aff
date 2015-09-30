# SEEA AFF Guatemala
# Renato Vargas
# https://gt.linkedin.com/in/revargas
# SEEA AFF GT Github: https://github.com/renatovargas/seea-aff#

# ------------------------------------------------------------------
#        TABLE 4.21 EXTENDED PRODUCTION AND INCOME ACCOUNT
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
    to_char(ntg9.id, '09') || ' ' || ntg9.trans as transaction,
    CASE 
		WHEN
			scn.naeg = 110
		THEN 	'01. Coffee'
		WHEN
			scn.naeg = 120
		THEN 	'02. Bananas'
		WHEN
			scn.naeg = 130
		THEN 	'03. Cardamum'
		WHEN
			scn.naeg = 210
		THEN 	'04. Cereals and other npc'
		WHEN
			scn.naeg = 220
		THEN 	'05. Tubers, roots, vegetables, legumes, horticulture, and greenhouse crops'
		WHEN
			scn.naeg = 230
		THEN 	'06. Fruits, nuts, teas, spices'
		WHEN
			scn.naeg = 240
		THEN 	'07. Other crops (Food/non-food)'
		WHEN
			scn.naeg BETWEEN 310 AND 520
		THEN 	'08. Livestock and livestock services (excl. vet.)'
		WHEN
			scn.naeg = 620
		THEN 	'09. Forestry'
		WHEN
			scn.naeg BETWEEN 710 AND 750
		THEN 	'10. Fisheries and aquaculture'
		WHEN
			scn.naeg BETWEEN 810 AND 3620
		THEN 	'11. Manufactures, mineral extraction, construction, and utilities (excl. electricity)'
		WHEN
			scn.naeg BETWEEN 3810 AND 3910
		THEN 	'11. Manufactures, mineral extraction, construction, and utilities (excl. electricity)'
		WHEN
			scn.naeg = 3710
		THEN 	'12. Electricity'
		WHEN
			scn.naeg BETWEEN 4010 AND 5910
		THEN 	'13. Other industries'
    ELSE '17. Other adjustments'
    END as seeaaff
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
     scn.flujo BETWEEN 3 AND 4
ORDER BY
     seeaaff, ntg20.cod;");

dbDisconnect(con)
dbUnloadDriver(drv)
rm("con")
rm("drv")

#sup$transaction <- factor(sup$transaction, levels=unique(sup$transaction))
supTable <- as.table(xtabs(monetary ~ seeaaff + transaction , data=sup))
supTable <- addmargins(supTable)


# EXCEL REPORT
# ============ 

wb <- createWorkbook("SEEA AFF Guatemala")

## Create styles
headerStyle <- createStyle(border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")
bodyStyle <- createStyle(numFmt="COMMA", fontName="Arial Narrow", fontSize=10)
rowNamesStyle <- createStyle(fontName="Arial Narrow", fontSize=10)
footerStyle <- createStyle(numFmt="COMMA", border="TopBottom", borderStyle ="medium", fontName="Arial Narrow", fontSize=10, textDecoration = "bold")

## Add data to Excel sheets

addWorksheet(wb, "4.21 Extended Income Account")
##write data to worksheet 1
writeData(wb, sheet = 1, supTable, rowNames = TRUE, startRow = 2)
addStyle(wb, sheet = 1, headerStyle, rows = 2:2, cols = 1:(dim(supTable)[2]+1), gridExpand = TRUE)
addStyle(wb, sheet = 1, bodyStyle, rows = 3:(3+dim(supTable)[1]), cols = 2:(dim(supTable)[2] + 1), gridExpand = TRUE)
addStyle(wb, sheet = 1, rowNamesStyle, rows = 3:(dim(supTable)[1]+1), cols=1, gridExpand = TRUE)
addStyle(wb, sheet = 1, footerStyle, rows = 1+(dim(supTable)[1] + 1), cols = 1:(dim(supTable)[2]+1), gridExpand = TRUE)
setColWidths(wb, 1, cols=1:(dim(supTable)[2]+1), widths = "auto") 



## set column width for row names column
saveWorkbook(wb, "table0421.xlsx", overwrite = TRUE)
openXL("table0421.xlsx")



# Where is it?
paste("Check out your file at: ",currentdir,"/table0421.xlsx.", " Enjoy!", sep = "")

#rm(list=ls())

