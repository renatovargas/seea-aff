---
title: SEEA-AFF Guatemala 
css: stylesheets/main.css
---

<!-- 
Compilar con Pandoc:
pandoc -f markdown -t html5 -s index.md --toc -N -o index.html 
-->

_Repositorio preparado y mantenido por [Renato Vargas](https://gt.linkedin.com/in/revargas) para el proceso de contabilidad ambiental y económica de Guatemala, con el apoyo de la iniciativa [WAVES](http://www.wavespartnership.org)._

## Descargas

||
|:---:|
| Puede ver y descargar los archivos  del proyecto, incluyendo esta página, en [GitHub](https://github.com/renatovargas/seea-aff).|    

**Archivos de procesamiento (R, PostgreSQL, etc.)**

| Archivo | Descripcion|
|---|---|
| [**seea-aff-00.R**](https://github.com/renatovargas/seea-aff/blob/master/scripts/seea-aff-00.R) | Conectar a base de datos PostgreSQL y cargar tablas SCAE GT. |

**Datos (Excel, SPSS, CSV, etc.)**

**Documentos (HTMl, docx, pptx, pdf)**

## Introducción

El **Sistema de Contabilidad Ambiental y Económica de Guatemala (SCAE)** presenta una adición a su familia de marcos analíticos. Con el apoyo metodológico de FAO, se ha creado un manual llamado [SEEA-AFF](http://unstats.un.org/unsd/envaccounting/aff/chapterList.asp) para el análisis de la relación entre la agricultura, la silvicultura y la pesca con el ambiente natural. Guatemala es uno de los países piloto para la implementación de este manual.

El repositorio [**seea-aff**](https://github.com/renatovargas/seea-aff) contiene los archivos necesarios para la generación de una compilación piloto del SEEA-AFF para Guatemala. Se fundamenta en la información de cuentas ambientales en la base de datos **naturacc_cuentas**[^1] y se complementa con otras fuentes. También se incluye la documentación y elementos didácticos de presentación.

[^1]: Preparada por José Miguel Barrios.

## Objetivo

El SEEA-AFF tiene el objetivo general de examinar la conexión entre el ambiente y las actividades económicas relacionadas con la agricultura, la silvicultura y las actividades de pesca[^2]. Busca facilitar la comprensión y el análisis de las interrelaciones entre estas actividades que deben considerarse en la planificación nacional y local. 

[^2]: Definidas por la [Clasificación Internacional Industrial Uniforme (CIIU)](http://unstats.un.org/unsd/cr/registry/default.asp?Lg=3), sección [A](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=A), divisiones [01](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=01), [02](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=02) y [03](http://unstats.un.org/unsd/cr/registry/regcs.asp?Cl=27&Lg=1&Co=03).

## Alcance

1. **Productos agrícolas y activos ambientales relacionados**
    * Cuenta de flujos físicos para cultivos. 
    * Cuenta de flujos físicos de productos pecuarios. 
    * Cuenta de activos de ganadería. 
    * Cuenta de activos para cultivos plantados.  
2. **Productos forestales y activos ambientales relacionados**   
    * Cuenta de flujos físicos para madera y productos no-maderables del bosque. 
    * Cuenta de activos del bosque.   Cuenta de activos para recursos maderables.
3. **Productos de la pesca y activos ambientales relacionados**   
    * Cuenta de activos físicos para la pesca y los productos acuáticos.   
    * Cuenta de activos piscícolas y otros recursos acuáticos.  
4. **Recursos hídricos**
    * Cuenta de activos para recursos hídricos.  
    * Cuenta de flujos físicos para abstracción de agua.  
    * Cuenta de flujos físicos para distribución y uso de agua.  
5. **Energía**   
    * Cuenta de flujos físicos para uso energético.
6. **Emisiones de gases efecto invernadero (GEI)** 
    * Cuenta de flujos físicos para emisiones de GEI.
7. **Fertilizantes, flujo de nutrientes y pesticidas**
    * Cuenta de flujos físicos para fertilizantes.  
    * Inventario de Nitrógeno y Fósforo. 
    * Cuenta de flujos físicos de pesticidas. 
8. **Tierra**   
    * Cuenta de activos de tierra.
    * Cuenta de activos de cobertura.  
9. **Suelo**   
    * Cuenta de activos para recursos del suelo.
10. **Otros datos económicos**   
    * Cuadro de oferta y utilización para productos agrícolas, silvícolas y de acuicultura. 
    * Cuenta de producción extendida y cuenta de ingresos para actividades agrícolas, silvícolas y piscícolas. 

## Ruta de implementación

El ejercicio piloto del SEEA-AFF de Guatemala ha sido preparado durante el mes de agosto de 2015, bajo los principios siguientes:

1. La compilación del SEEA-AFF es replicable.
2. Las decisiones metodológicas de compilación del SEEA-AFF están documentadas.
3. Las fuentes de datos están disponibles.
4. Se reduce el error humano en la compilación a través de métodos automatizados.
5. Se fomenta activamente el acceso a la información a través del uso de formatos abiertos y propietarios de amplia difusión para la puesta a disposición de datos y documentos en línea.

|Fechas (2015)|Actividades|
|---|---|
| **(24/07 - 31/07)** | Adaptación de las recomendaciones de compilación al contexto nacional.|
| **(03/08 - 07/08)** | Documentación de fuentes de información (disponibilidad de datos y brechas de información). |
| **(10/08 - 21/08)** | Compilación y documentación del SEEA-AFF Guatemala. |
|**(24/08 - 28/08)**| Desarrollo de reporte de recomendaciones para la implementación regular del SEEA-AFF (incluye cuadros, hallazgos relevantes y usos potenciales de política pública). |
| **(27/08 - 01/09)** | Coordinación con entidades públicas (Instituto Nacional de Estadística, Ministerio de Agricultura). |
| **(02/09 - 03/09)** | Presentación en _FAO Regional Statistical Commision for latin America and the Caribbean Meeting_ celebrada 2 y 3 de septiembre en Panamá. |
| **(04/09 - 18/09)** | Incorporación de observaciones a las presentaciones. |

