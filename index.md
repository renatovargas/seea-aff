---
title: SEEA AFF Guatemala 
css: stylesheets/main.css
---

[[Home]](/seea-aff/) [[English]](/seea-aff)  <!-- [[Español]](/seea-aff/index_es.html) --> 

_**WORK IN PROGRESS, DO NOT CITE.** Repository created and mantained by [Renato Vargas](https://gt.linkedin.com/in/revargas) for the Guatemalan System of Environmental and Economic Accounts (SEEA), with support from the Wealth Accounting and the Valuation of Ecosystem Services [(WAVES)](http://www.wavespartnership.org) initiative._

_Last updated: September 30, 2015._

## Tables and files  

**Tables and data sets (Preliminary for year 2010 only; do not cite)**

| Description | Access/Download |
| --- | :---: |
| [4.01. Physical flow account for crops](./data/table0401.html)  | [HTML](./data/table0401.html) / [Excel](./data/table0401.xlsx)  |
| [4.02. Physical flow account for livestock](./data/table0402.html)  | [HTML](./data/table0402.html) / [Excel](./data/table0402.xlsx)  |
| [4.05. Physical flow account for timber and forest products](./data/table0405.html)  | [HTML](./data/table0405.html) / [Excel](./data/table0405.xlsx)  |
| [4.08. Physical flow account for fish and aquatic products](./data/table0408.html)  | [HTML](./data/table0408.html) / [Excel](./data/table0408.xlsx)  
| [4.11. Water abstraction](./data/table0411.html)  | [HTML](./data/table0411.html) / [Excel](./data/table0411.xlsx)  
| [4.13. Energy use](./data/table0413.html)  | [HTML](./data/table0413.html) / [Excel](./data/table0413.xlsx)  
| [4.14. Greenhouse Gas Emissions (our suggestion)](./data/table0414.html)  | [HTML](./data/table0414.html) / [Excel](./data/table0414.xlsx)  
| [4.14x. Greenhouse Gas Emissions (as recommended)](./data/table0414a.html)  | [HTML](./data/table0414a.html) / [Excel](./data/table0414a.xlsx)  
| [4.20. Monetary Supply and Use table](./data/table0420.html)  | [HTML](./data/table0420.html) / [Excel](./data/table0420.xlsx)  
| [4.21. Extended Income Account](./data/table0421.html)  | [HTML](./data/table0421.html) / [Excel](./data/table0421.xlsx)  


**Documentation**

| Document | Access/Download |
| --- | :---: |
| [SEEA AFF Guatemala Report Outline](./site/en/outline.html)  | [HTML](./site/en/outline.html) / [PDF](./docs/outline.pdf)  |
| [SEEA AFF Data Assessment Template for Guatemala](./site/en/assessment.html)  | [HTML](./site/en/assessment.html) / [PDF](./docs/assessment.pdf)  |


**Information processing scripts (R, PostgreSQL, etc.)[^GH]**

| File | Description |
|---|---|
| [4_01-physical_crops.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_01-physical_crops.R) | Build table 4.01. Physical flow account for crops. |
| [4_02-physical_livestock.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_02-physical_livestock.R) | Build table 4.02. Physical flow account for livestock. |
[4_05-physical_timber.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_05-physical_timber.R) | Build table 4.05. Physical flow account for timber and forest products. |
[4_08-physical_fish.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_08-physical_fish.R) | Build table 4.08. Physical flow account for fish and aquatic products. |
[4_11-physical_water.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_11-physical_water.R) | Build table 4.11. Physical water abstraction. |
[4_13-physical_energy.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_13-physical_energy.R) | Build table 4.13. Energy use. |
[4_14-physical_ghg.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_14-physical_ghg.R) | Build table 4.14a. Greenhouse Gas Emissions (Our suggestion) |
[4_14a-physical_ghg.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_14a-physical_ghg.R) | Build table 4.14a. Greenhouse Gas Emissions (as recommended) |
[4_20-monetary.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_20-monetary.R) | Build table 4.20. Monetary Supply and Use |
[4_21-income.R](https://github.com/renatovargas/seea-aff/blob/master/scripts/4_21-income.R) | Build table 4.21. Extended Income Account |

[^GH]: Explore and download the project files, including this page, on [GitHub](https://github.com/renatovargas/seea-aff).


## Introduction

The **System of Environmental and Economic Accounts of Guatemala (SEEA GT)** adds a new member to its existing family of analytical frameworks. A new manual called [System of Environmental-Economic Accounting for Agriculture, Forestry and Fisheries (SEEA AFF)](http://unstats.un.org/unsd/envaccounting/aff/chapterList.asp) is being developed with support from FAO. It is "a statistical framework for the organization of data that permits the description and analysis of the relationship between the environment and the economic activities of agriculture, forestry and fisheries".

The [**seea-aff**](https://github.com/renatovargas/seea-aff) repository is a collection of files which allow for a pilot compilation of the SEEA-AFF for Guatemala. It has the dual purpose of documenting the compilation efforts and contributing techniques that can help other countries replicate the exercise with their own data or globally available datasets. 

The point of departure for this exercise is the SEEA-GT PostgreSQL database (**naturacc_cuentas**) developed by José Miguel Barrios, with support from the WAVES initiative. We build on top of it, using information from other sources.

## Objective

According to the [draft manual](http://unstats.un.org/unsd/envaccounting/aff/GC_Draft.pdf), the SEEA AFF has the objective of examining the connection between economic activity and the environment. Its scope covers agricultural, forestry and fisheries activities as defined in the [International Standard Industrial Clasification (ISIC)](http://unstats.un.org/unsd/cr/registry/default.asp?Lg=3), section [A](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=A), divisions [01](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=01), [02](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=02) y [03](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=03). The purpose of this coverage of three different types of activity is to facilitate understanding and analysis of the trade-offs and dependencies between these activities that should be considered as part of national and local level planning.

## Scope

The draft SEEA AFF has the following data domains and base accounts:

1. **Agricultural products and related environmental assets**
    * Physical flow account for crops
    * Physical flow account for livestock products
    * Asset account for livestock
    * Asset account for plantation crops
2. **Forestry products and related environmental assets**
    * Physical flow account for timber and non-wood forest products
    * Asset account for forests
    * Asset account for timber resources
3. **Fisheries products and related environmental assets**
    * Physical flow account for fish and aquatic products
    * Asset account for fish and other aquatic resources
4. **Water resources**	
    * Asset account for water resources
    * Physical flow account for water abstraction
    * Physical flow account for water distribution and use
5. **Energy**
    * Physical flow account for energy use
6. **Greenhouse Gas GHG emissions**
    * Physical flow account for GHG emissions
7. **Fertilizers, nutrient flows and pesticides**
    * Physical flow account for fertilizers
    * Nitrogen and phosphorous budgets[^1]
    * Physical flow account for pesticides
8. **Land**
    * Asset account for land use
    * Asset account for land cover
9. **Soil resources**
    * Asset account for soil resources 
10. **Other economic data**
    * Monetary supply and use table for agricultural, forestry and fisheries products
    * Extended production and income account for agricultural, forestry and fisheries activities

[^1]: Nitrogen and phosphorous budgets have been developed outside of the SEEA framework but, in essence, are a form of asset accounting for these particular elements.

## Implementation principles

The SEEA AFF Guatemala pilot exercise has been prepared in the month of August 2015, under the following principles:

1. SEEA-AFF Guatemala compilation is replicable.
2. Methodological decisions and assumptions during compilation are documented.
3. Data sources are available.
4. Human error is avoided with automatized methods to a sensible extent.
5. Access to information is actively pursued through the use of open formats and propietary formats of ample diffusion to make data and documents available online.

<!--
|Dates 2015 (dd/mm)| Actions |
|- - -|- - -|
| **(24/07 - 31/07)** | Adapt SEEA AFF draft manual recommendations to local context.|
| **(03/08 - 07/08)** | Document information sources, data availability, and information gaps. |
| **(10/08 - 21/08)** | Compile and document SEEA-AFF Guatemala. |
|**(24/08 - 28/08)**| Develop report of recommendations for regular compilation of SEEA AFF (includes tables, relevant findings, and potential policy uses). |
| **(27/08 - 01/09)** | Coordination with public entities. |
| **(02/09 - 03/09)** | Presentation at _FAO Regional Statistical Commision for latin America and the Caribbean Meeting_ celebrated on September 02 and 03 in Panamá. |
| **(04/09 - 18/09)** | Incorporate comments to the presentation. | -->

<!-- Compiled with Pandoc and the toc takes two hyphens, not one but it messes up the html comment
     when compiling with Pandoc if we leave it in here:
     pandoc -f markdown -t html5 -s index.md -toc -o index.html  -->

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-67331632-1', 'auto');
  ga('send', 'pageview');

</script>
  

