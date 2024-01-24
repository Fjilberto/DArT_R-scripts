gl <- gl.read.dart(filename="Report-DGenyp23-8436/Report_DGenyp23-8436_1_moreOrders_SNP_2.csv",
                   ind.metafile = "iddata_sex_negro.txt", probar=F)

#### Caracteristicas del set de datos 
nLoc(gl)        #number of loci
nInd(gl)        #number of individuals
nPop(gl)        #number of populations
levels(pop(gl)) #populations
glPlot(gl)
gl.alf(gl)
names(gl@other$loc.metrics) # nombre de todas las variables
head(gl.alf(gl5),n=7)
head(freq3,n=7)

# Filtros y metricas resumen------------------------------------------------------------------

# Loci no polimorficos NO HACER!!!!!!
gl
gl.report.monomorphs(gl) #no monomorphic loci or NAs #gl.filter.monomorphs( ) no es necesario
gl1<-gl.filter.monomorphs(gl)
gl1

# % Tasa de Genotipado por locus (>0.70)
gl.report.callrate(gl1,method="loc") # reporte (method="ind", "loc")
gl2<-gl.filter.callrate(gl, method="loc", threshold = 0.99) # filtro
gl2

gl2@other$loc.metrics$AvgCountRef #promedio de reads para alelo de referencia
gl2@other$loc.metrics$AvgCountSnp # promedio de reads para alelo alternativo

# Report read depth by locus (m > 3)
gl.read.depth<-gl.report.rdepth(gl2)
gl3<-gl.filter.rdepth(gl2,lower = 3,upper=620,verbose = 3)
gl3

# Filter secondaries SNPs (SNPS en una misma secuencia, deja solo uno)
gl.report.secondaries(gl3) 
gl4<-gl.filter.secondaries(gl3, method = "best")
gl4 

#revisa los SNPs que quedaron fuera de la zona trimeada para sacarlo
#gl.report.overshoot(gl1)
# 1 loci fuera # solo reporte, no filtro. Si hubiesen loci fuera del rango, se deben eliminar.
#67622210-66-A/T

# % Missing data por individuo
gl.report.callrate(gl4,method="ind") # reporte (method="ind", "loc")
gl5<-gl.filter.callrate(gl4, method="ind", threshold = 0.85) # filtro
gl5

datos<-gl2gi(gl5) #### Convertir formato de genind a genlight para manipulación

# Estadisticas basicas

div<-summary(datos)
div #N° Estadisticas varias N° individuos, n por grupo, N° alelos por grupo, % perdidos, He y Ho 
table(datos$loc.fac) #N° alelos
summary(datos$pop) #N° individuos por población
