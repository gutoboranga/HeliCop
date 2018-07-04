data <- read.csv("results/pre.csv")

# ===== gráfico das idades =====
jpeg('images/ages.jpg', width=800)

ages <- as.data.frame(table(data$Idade))

pct <- round(ages$Freq/sum(ages$Freq)*100)

labels <- ages$Var1
labels <- paste(labels, " : ")
labels <- paste(labels, pct)
labels <- paste(labels,"%",sep=" ")

pie(ages$Freq, labels)

# ===== gráfico de gênero =====