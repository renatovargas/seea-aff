---
title: Notes on SEEA AFF compilation
---


## Database issues

* Supply and Use do not balance out, in cases by decimals in others by a few tons, thousand quetzales, etc. I suspect that scae.datofisico, scn.datofisico, and scn.datocou might be stored in a fields with "real" type and accuracy might be getting lost, whereas perhaps a "float" field type could be more suitable.
* NA's for naeg and npg have code "0". This consistently makes ordering difficult as NA's usually refer to transactions which should be ordered after economic activities. Hence, perhaps it would be better to use "9999" as a code for NA's in npg and naeg (in both scae and scn tables).

## Specific table issues

### Forestry supply table

* Forestry supply includes animal species and the unit recorded is "cubic meters (m<sup>3</sup>)". This might be a mistake.  Especially because, whereas other forest products have amounts with decimal places (i.e. continuous quantities), animal products have integers (i.e. discreet quantities), suggesting "number of individuals".

