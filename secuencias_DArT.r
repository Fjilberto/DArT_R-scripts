library(stringr)

seq<-read.csv("Archivo csv que contiene las secuencias")
seq<-seq[-(1:5),1:5] # Seleccionar solo lo que interesa del excel

#### Selección de secuencias a partir de secuencias de interés

# Adaptar los ID del archivo de secuencias a los ID se genotipado

colnames(seq) <- seq[1,]
seq<-seq[-1,]
seq$AlleleID<-str_sub(seq$AlleleID, end = -7)
seq$AlleleID<-sub("-$", "", seq$AlleleID)
seq$AlleleID<-gsub("\\|F\\|0", "",seq$AlleleID)
seq$AlleleID<-gsub(":",".",seq$AlleleID)
seq$AlleleID<-gsub(">",".",seq$AlleleID)
seq$AlleleID<-gsub("-",".",seq$AlleleID)

# Selección de secuencias

seqfilter<-subset(seq,AlleleID %in% seleccion$snp)
seqfilterfasta<-subset(seqfilter,select=c(AlleleID,AlleleSequenceSnp))
seqfilterfasta$AlleleID<-paste0(">", seqfilterfasta$AlleleID)
seqfilterfasta$AlleleSequenceSnp<-gsub("^.{0,6}", "", seqfilterfasta$AlleleSequenceSnp)
seqfilterfasta<-do.call(rbind, lapply(seq(nrow(seqfilterfasta)), function(i) t(seqfilterfasta[i, ])))
write.table(seqfilterfasta,file = "Archivo txt con las secuencias utiles", row.names = FALSE, col.names = FALSE, quote = FALSE)
