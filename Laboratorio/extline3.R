
MINID <- 1
MAXID <- 12

NTOTAL<-MAXID-MINID+1

### defino uma variável nd, numero de 
### pontos analisados
nd <- 10  # variogram for up separation of 10
### Criando 2 matrices vazias de NTOTAL linhas e nd colunas.
### NA : Not Available
xd1 <- matrix(NA,NTOTAL,nd) 
xd2 <- matrix(NA,NTOTAL,nd) 

for (K in MINID:MAXID) 
{
	K
	### Carregar imagenes
	library(bmp)

	path_img1 <-sprintf("Compactado/bmp/compact%d.bmp", K)
	path_img2 <-sprintf("NaoCompactado/bmp/notcomp%d.bmp", K)

	img1 <- read.bmp(path_img1)
	img2 <- read.bmp(path_img2)

	### Mostrar imagenes carregadas
	image(img1) # to display the image1
	image(img2) # to display the image2

	### ncol numero de colunas da imagem img1
	### nrow numero de linhas da imagem img1
	ncol <- dim(img1)[2]
	nrow <- dim(img1)[1]

	### Define uma funcao que so' faz a media de  X de 
	### todos os valores menores a 0.2
	meddk <- function(x) {return(median(which(x>0.2))) }

	### Aplica a funcao meddk sobre img1 e img2
	### e carrega em x1 e x2 respetivamente.
	x1 <- apply(img1,2,meddk)
	x2 <- apply(img2,2,meddk)
	

	### Indicar onde vai salvar o PLOT
	#win.metafile("fig1.wmf")
	jpeg(sprintf("%s.out.jpeg", path_img1))
		### Faz um plot de x1 (media das linhas de x1)
		#plot(1:ncol,x1,pch=16,cex=0.4,col="red",xlim=c(1,ncol),ylim=c(nrow,1))
		plot(0:(ncol-1), type='n', main="", xlab="x", ylab="y",xlim=c(0,ncol-1),ylim=c(nrow-1,0))
		rasterImage(img1/255.0, 0, nrow-1, ncol-1, 0)
		grid()

		### Faz um plot de x1 (media das linhas de x1)
		lines(0:(ncol-1),x1, type="b",cex=0.9, lwd=1.5, col="red")
	dev.off()
	jpeg(sprintf("%s.out.jpeg", path_img2))
		### Faz um plot de x2 (media das linhas de x2)
		#plot(1:ncol,x2,pch=16,cex=0.4,col="green",xlim=c(1,ncol),ylim=c(nrow,1))
		plot(0:(ncol-1), type='n', main="", xlab="x", ylab="y",xlim=c(0,ncol-1),ylim=c(nrow-1,0))
		rasterImage(img2/255.0, 0, nrow-1, ncol-1, 0)
		grid()

		### Faz um plot de x1 (media das linhas de x1)
		lines(0:(ncol-1),x2, type="b",cex=0.9, lwd=1.5, col="red")
	dev.off()


	### Equacao do variograma de x1
	for (i in 1:nd) 
	{
		diff_x1d <- diff(x1,i)
		xd1[K,i] <- mean(diff_x1d*diff_x1d,na.rm=T)
	}

	### Equacao do variograma de x2
	for (i in 1:nd) 
	{
		diff_x2d <- diff(x2,i)
		xd2[K,i] <- mean(diff_x2d*diff_x2d,na.rm=T)
	}
}
dir.create("out_extline", showWarnings = FALSE, recursive = TRUE)
jpeg('out_extline/Resultado do variograma.jpg')
for (K in MINID:MAXID)
{ 
	### Plot do variograma de x1 (desenhado cor vermelho com linhas)
	### e um Plot do variograma de x2 (desenhado com cor verde e pontos ) 
	#win.metafile("fig2.wmf")
	if(K==1)
	{
		plot(1:nd,xd1[K,],col="red",main="Variogram",xlim=c(0,10))
	}
	else
	{
		points(1:nd,xd1[K,],col="red",pch=16,xlim=c(0,10))
	}
	points(1:nd,xd2[K,],col="green",pch=16)
}

meanxd1<-colMeans(xd1, na.rm = FALSE, dims = 1)
write.table(meanxd1, file =paste("out_extline/meanxd1.txt",sep="") , sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")

meanxd2<-colMeans(xd2, na.rm = FALSE, dims = 1)
write.table(meanxd2, file =paste("out_extline/meanxd2.txt",sep="") , sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")

stdxd1 <- apply(xd1, 2, sd)
write.table(stdxd1, file =paste("out_extline/stdxd1.txt",sep="") , sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")

stdxd2 <- apply(xd2, 2, sd)
write.table(stdxd2, file =paste("out_extline/stdxd2.txt",sep="") , sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")


dev.off()
for (K in 1:nd)
{ 
write.table(xd1[,K], file =paste("out_extline/xd1-red",toString(K),".txt",sep="") , sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")

write.table(xd2[,K], file =paste("out_extline/xd2-green",toString(K),".txt",sep=""), sep = "\t", row.names = FALSE, col.names = FALSE, qmethod = "double")
}
#print(summary(aov(xd1)))
