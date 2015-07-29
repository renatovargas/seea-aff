---
title: SEEA-AFF Guatemala 
css: stylesheets/main.css
---

<!-- 
Compile with Pandoc:
pandoc -f markdown -t html5 -s index.md --toc -o index.html 
-->

[[English]](/index.html)  [[Español]](/index_es.html) 

_Repository created and mantained by [Renato Vargas](https://gt.linkedin.com/in/revargas) for the Guatemalan System of Environmental and Economic Accounts (SEEA), with support from the Wealth Accounting and the Valuation of Ecosystem Services [(WAVES)](http://www.wavespartnership.org) initiative._

## Downloads

||
|:---:|
| Explore and download the project files, including this page, on [GitHub](https://github.com/renatovargas/seea-aff).|    

**Information processing scripts (R, PostgreSQL, etc.)**

| File | Description |
|---|---|
| [**seea-aff-00.R**](https://github.com/renatovargas/seea-aff/blob/master/scripts/seea-aff-00.R) | Connect to Guatemalan SEEA database and load tables into R. |

**Datasets (Excel, SPSS, CSV, etc.)**

**Documentation (HTMl, docx, pptx, pdf)**

## Introduction

The **System of Environmental and Economic Accounts of Guatemala (SEEA GT)** adds a new member to its existing family of analytical frameworks. A new manual called [System of Environmental-Economic Accounting for Agriculture, Forestry and Fisheries (SEEA AFF)](http://unstats.un.org/unsd/envaccounting/aff/chapterList.asp) is being developed with support from FAO. It is "a statistical framework for the organization of data that permits the description and analysis of the relationship between the environment and the economic activities of agriculture, forestry and fisheries".

The [**seea-aff**](https://github.com/renatovargas/seea-aff) repository is a collection of files which allow for a pilot compilation of the SEEA-AFF for Guatemala. It has the dual purpose of documenting the compilation efforts and contributing techniques that can help other countries replicate the exercise with their own data or globally available datasets. 

The point of departure for this exercise is the SEEA-GT PostgreSQL database (**naturacc_cuentas**) developed by José Miguel Barrios, with support from the WAVES initiative. We build on top of it, using information from other sources.

## Objective

According to the [draft manual](http://unstats.un.org/unsd/envaccounting/aff/GC_Draft.pdf), the SEEA AFF has the objective of examining the connection between economic activity and the environment. Its scope covers agricultural, forestry and fisheries activities as defined in the [International Standard Industrial Clasification (ISIC)](http://unstats.un.org/unsd/cr/registry/default.asp?Lg=3), section [A](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=A), divisions [01](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=01), [02](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=02) y [03](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=03). The purpose of this coverage of three different types of activity is to facilitate understanding and analysis of the trade-offs and dependencies between these activities that should be considered as part of national and local level planning.

## Scope

The draft SEEA AFF has the following data domains and base accounts:

**1. Agricultural products and related environmental assets**	
  * Physical flow account for crops
  * Physical flow account for livestock products
  * Asset account for livestock
  * Asset account for plantation crops
  
**2. Forestry products and related environmental assets**
  * Physical flow account for timber and non-wood forest products
  * Asset account for forests
  * Asset account for timber resources

**3. Fisheries products and related environmental assets**
  * Physical flow account for fish and aquatic products
  * Asset account for fish and other aquatic resources

**4. Water resources	Asset account for water resources**
  * Physical flow account for water abstraction
  * Physical flow account for water distribution and use

**5. Energy**
  * Physical flow account for energy use

**6. Greenhouse Gas GHG emissions**
  * Physical flow account for GHG emissions
  
**7. Fertilizers, nutrient flows and pesticides**
  * Physical flow account for fertilizers
  * Nitrogen and phosphorous budgets[^1]
  * Physical flow account for pesticides

**8. Land**
  * Asset account for land use
  * Asset account for land cover

**9. Soil resources**
  * Asset account for soil resources 

**10. Other economic data**
  * Monetary supply and use table for agricultural, forestry and fisheries products
  * Extended production and income account for agricultural, forestry and fisheries activities


## Implementation roadmap

The SEEA AFF Guatemala pilot exercise has been prepared in the month of August 2015, under the following principles:

1. SEEA-AFF Guatemala compilation is replicable.
2. Methodological decisions and assumptions during compilation are documented.
3. Data sources are available.
4. Human error is sought after with automatized methods.
5. Access to information is actively pursued through the use of open formats and propietary formats of ample diffusion to make data and documents available online.

|Dates 2015 (dd/mm)| Actions |
|---|---|
| **(24/07 - 31/07)** | Adapt SEEA AFF draft manual recommendations to local context.|
| **(03/08 - 07/08)** | Document information sources, data availability, and information gaps. |
| **(10/08 - 21/08)** | Compile and document SEEA-AFF Guatemala. |
|**(24/08 - 28/08)**| Develop report of recommendations for regular compilation of SEEA AFF (includes tables, relevant findings, and potential policy uses). |
| **(27/08 - 01/09)** | Coordination with public entities. |
| **(02/09 - 03/09)** | Presentation at _FAO Regional Statistical Commision for latin America and the Caribbean Meeting_ celebrated on September 02 and 03 in Panamá. |
| **(04/09 - 18/09)** | Incorporate comments to the presentation. |

