---
title: SEEA AFF Draft Technical Report
css: ../../stylesheets/main.css
---

[[Home]](/seea-aff/) [[English]](/seea-aff/site/en/outline.html)  \[Español\] 

 | Wealth Accounting and the Valuation of Ecosystem Services (WAVES) |
 | --- |
 | SEEA AFF Guatemala Draft Technical Report |
 | _Updated: September 30, 2015._ |


# Introduction

Wealth Accounting and the Valuation of Ecosystem Services (WAVES) is a global partnership that aims to promote sustainable development by mainstreaming Natural Capital Accounting (NCA) into development planning and ensuring that the national accounts used to measure and plan for economic growth include the value of natural capital. Different actors at global, national and subnational levels, all work towards accomplishing WAVES’ four objectives: help countries adopt and implement accounts that are relevant for policies and compile a body of experience; develop an ecosystem accounting methodology; establish a global platform for training and knowledge sharing; and build international consensus around natural capital accounting. Guatemala is one of the core implementing countries and it is involved as a pilot country in the development of the System of Environmental-Economic Accounting for Agriculture, Forestry and Fisheries (SEEA AFF).

The SEEA AFF is an application of the international statistical standard SEEA 2012 Central Framework adopted in 2012 by the United Nations Statistical Commission. The SEEA AFF has the objective of examining the connection between economic activity and the environment with regards to agricultural, forestry and fisheries activities [@seeaaff14]. The purpose of this coverage of three different types of activity is to facilitate understanding and analysis of the trade-offs and dependencies between these activities that should be considered as part of national and local level planning.

Guatemala has about a decade's history in the compilation of the System of Environmental and Economic Accounts SEEA in order to develope an understanding of the interactions between the economy and the environment. The SEEA builds on top of the solid base of the System of National Accounts compiled by the Central Bank with the purpose of measuring economic performance. The Guatemalan implementation of the SEEA has developed accounts for water, forests, energy and emissions, residuals, fisheries, subsoil assets, land and ecosystems, and environmental expenditures, through a public-private effort between the academic sector and government institutions.

This experience has left Guatemala with appropriate conditions to focus the analytical capabilities of the SEEA on agriculture, forestry and fisheries. Furthermore, the importance of the agricultural industries in terms of employment, value added, and environmental impacts in Guatemala makes those sectors an important target for public policy. This document provides an initial aproximation to what the SEEA AFF could be in Guatemala and proposes a roadmap for its future regular compilation.

	
# Introduction to the SEEA AFF (objectives, domains, analytical potential).

According to the [draft manual](http://unstats.un.org/unsd/envaccounting/aff/GC_Draft.pdf), the SEEA AFF has the objective of examining the connection between economic activity and the environment. Its scope covers agricultural, forestry and fisheries activities as defined in the [International Standard Industrial Clasification (ISIC)](http://unstats.un.org/unsd/cr/registry/default.asp?Lg=3), section [A](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=A), divisions [01](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=01), [02](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=02) y [03](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=03). The purpose of this coverage of three different types of activity is to facilitate understanding and analysis of the trade-offs and dependencies between these activities that should be considered as part of national and local level planning.

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

With its strong connections to the SEEA Central Framework and the SNA, the SEEA AFF brings with it the many features that these accounting based statistical frameworks provide to the organization of information and statistical activities. Important possibilities in this regard include the following.

* Conceptual framework for a database and central point for organizing data.  
* Data gap analysis and gap filling. The SEEA AFF is a broad framework designed on the information that would be most relevant rather than on the basis of the information that are currently available. 
* Data collection and reporting. As a conceptual framework SEEA AFF is able to support and encourage the use of consistent data item definitions across different collections.
* One of the important motivations for the SEEA is to assist in the derivation of indicators that reflect cross-domain comparisons.
* The information in the SEEA AFF can also be used to support the compilation of environmentally extended input-output tables (EE-IOT). 
* Once EE-IOT are established a range of different types of analysis may be supported, like multiplier analysis, footprint indicators, structural decomposition analysis, extended productivity analysis, modeling of international trade, general and partial equilibrium analysis, life cycle analysis


The design of the SEEA AFF framework supports discussion in five broad policy themes.

* **Theme 1:** Activity and product specific inputs: Under this theme the focus is on the analysis of the economic and environmental information about the most important products for a country and the associated trends in the use of environmental inputs and the generation of residual flows.
* **Theme 2:** Food product consumption, losses and waste 
* **Theme 3:** Bioenergy
* **Theme 4:** Use of environmental assets (timber, fisheries, water, soil). 
* **Theme 5:** Cross-industry and activity perspectives. 

# Data

Guatemala has an experience of about a decade in the compilation of Environmental and Economic Accounts. There is available information for the period 2001-2010. Recent efforts by the Wealth Accounting and the Valuation of Ecosystem Services inititative have resulted in the construction of a PostgreSQL database to hold the information. Unlike IT solutions with which have been used in the past in order to translate the tables into database format, the Guatemalan SEEA database has been constructed by people with natural capital accounts compilation experience. This has lead to the construction of a database more suited for analytical needs, and has removed the "black box" limitations that remain when outsourcing this step to IT experts with no accounting experience.

Since the SEEA AFF manual explicitly states that it is not an experimental manual, but an application of the SEEA CF principles with a focus on the Agriculture, Forestry, and Fisheries, in this pilot implementation there was an expectation to test to which extent the Guatemalan SEEA database could provide the necessary inputs for the SEEA AFF framework.

The Guatemalan SEEA database has four core tables for the different conceptual domains of the information (name of the table given in parentheses), and contains data for the years 2001-2010.

* **Supply and use table data (scn)**: This table includes information from the System of National Accounts in monetary terms, including extended income accounts. For select commodities (especially agricultural) physical data in tonnes is also available. This information is compiled by the Guatemalan Central Bank (BANGUAT).
* **Environmental accounts data (scae)**: This table includes physical data from forest flow accounts, water flow accounts, and energy flow accounts.
* **Residual account data (scaeresid)**: This table includes waste generation information by economic activity. 
* **GHG emission flows (scaeemis)**: This table includes greenhouse gas emissions from the combustion of different energy sources.
* **Complementary tables**: Various tables complement the previous and describe activity names (naeg), product names (npg), transaction names (ntg), type of emissions (clasifemis), types of waste (resid), types of flows (flujos), units of measurement (unidades), and a listing of compiled accounts (cuentas).

In order to ensure replicability of the study and document the decisions made for this pilot implementation, processing scripts in the R programming language[^R] were used and are available upon request. One beneficial characteristic of this approach is that all data operations ar non-destructive and dispense with the end use of data files for compilation. These scripts facilitate various tasks, including:

[^R]: R is a language and environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS. It is freely available under the General Public Licence (GPL) at https://www.r-project.org.

* Query the PostgreSQL database using the SQL language for table information.
* Creating table ad-hoc orderings of SEEA AFF relevant industry, product, or transaction classifications.
* Creating cross-tabulations to produce tables as close as possible to the recommendations in the manual.
* Producing spreadsheet files with tables in popular office suite formats.

Below there is a description of the relevant data considerations for each of the SEEA AFF data domains. In some cases, the Guatemalan SEEA database has either not been supplied with existing accounting data, or is not equipped for the type of data requested. In those cases, we recommend a solution for later iterations of the Guatemalan SEEA AFF implementation.

Describe the data.
Where is it from?
What estimations/calculations are needed?
What are the limitations of the data?

## Agricultural products and related environmental assets

**Crops**

The base For this SEEA AFF domain comes from the physical base flow account for crops in table 4.01 of the manual. 

The Guatemalan SEEA database has relevant net output information for various agricultural products, as well as for some of their processed by-products down the manufacturing chain in tonnes for the relevant industries. This information comes from the agricultural, food industries, and commodity SNA worksheets. It has been included in the Supply and Use information compiled by the Central Bank. 

In the pilot implementation of [table 4.01](http://renatovargas.github.io/seea-aff/data/table0401.html) we have included all subproducts for stakeholder consultation purposes. In later implementations, focus could be placed on only those commodities and industries that are relevant from a food security perspective.

Following the SEEA AFF recommendation and taking into account the available information scope, we have grouped output into:

* Agricultural Industries
* Manufacturing and other Industries
* Imports'Agricultural Industries
* Manufacturing and other Industries

Conversely, product use has been divided by the following industry aggregations:

* Agricultural Industries for seed
* Agricultural Industries for feed
* Other Agricultural Industries
* Food Processing Industries
* Non-Food Processing Industries
* Hotels and Restaurants
* Household final consumption
* Stock variation
* Exports

The manual suggests the inclusion of gross output, and adds a column which tracks losses in the production process, which would then be substracted in order to obtain net output. As predicted in the manual, losses information is not readily available in the database and would have to be calculated with ratios. This has not yet been done in the pilot implementation and is a limitation for the construction of efficiency indicators.

**Livestock**

The base For this SEEA AFF domain comes from the physical base flow account for livestock products in table 4.02 of the manual. 

The Guatemalan SEEA database has relevant net output information for various animal assets, as well as for some of their processed by-products down the manufacturing chain in tonnes for the relevant industries. This information comes from the agricultural, food industries, and commodity SNA worksheets. It has been included in the Supply and Use information compiled by the Central Bank. 

The approach in [table 4.02](http://renatovargas.github.io/seea-aff/data/table0402.html) is similar to the agriculture table, but with a focus on livestock products and by-products. Following the SEEA AFF recommendation and taking into account the available information scope, we have grouped output into:

* Agricultural Industries
* Manufacturing and other Industries
* Imports'Agricultural Industries
* Manufacturing and other Industries

And product use has been divided by the following industry aggregations:

* Agricultural Industries for seed
* Agricultural Industries for feed
* Other Agricultural Industries
* Food Processing Industries
* Non-Food Processing Industries
* Hotels and Restaurants
* Household final consumption
* Stock variation
* Exports

**Assets limitations**

Tables 4.03 and 4.04 of the SEEA AFF study important asset information on livestock headcounts and plantations consistent with land use accounts, respectively. At this point, the Guatemalan SEEA database used in this excersise does not contain land use information, even if partial information exists outside of it.

Land use and land use change information exists as part of mapping initiatives of Guatemala for select years and could be included as reference. Yearly information is not available.

Livestock information is only available for select years, as well as from an Agricultural Census conducted in the period 2002-2003. There is also an agricultural survey from 2014. Tables for those years could be constructed in a new iteration of this effort.


## Forestry products and related environmental assets 

The base For this SEEA AFF domain comes from the Physical flow account for timber products in table 4.05 of the manual. 

The Guatemalan SEEA database has relevant net output information for timber, as well as for some of their processed by-products down the manufacturing chain in cubic metres for the relevant industries. The information comes from the Environmental and Economic Accounts of Guatemala. 

Following the SEEA AFF recommendation and taking into account the available information scope, we have grouped output in the pilot implementation of [table 4.05](http://renatovargas.github.io/seea-aff/data/table0405.html) into:

* Agricultural Industries
* Manufacturing and other Industries
* Imports'Agricultural Industries
* Manufacturing and other Industries

Conversely, product use has been divided by the following industry aggregations:

* Agricultural Industries
* Manufacturing and other Industries
* Household final consumption
* Capital formation
* Stock variation
* Exports

As a limitation, the Guatemalan SEEA database does not contain physical asset information on forests and timber products, which are the subject of tables 4.06 and 4.07, respectively, so we have not included them in this exercise.

However, the System of Environmental Accounts has produced partial information on these topics and can be systematized in future iterations.

## Fisheries products and related environmental assets

Yearly 

## Water resources	

## Energy

## Greenhouse Gas GHG emissions

## Fertilizers, nutrient flows and pesticides

## Land

## Soil resources    

## Other economic data

# Results

* Base tables.

# Discussion

* Discuss relevant findings.
* Present policy recommendations
* Future steps to improve the compilation of the SEEA AFF.

<!-- Google Analytics -->
<script>  
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-67331632-1', 'auto');
  ga('send', 'pageview');

</script>
