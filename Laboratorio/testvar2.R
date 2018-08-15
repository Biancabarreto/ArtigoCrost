testvar2<-function(path_img1) 
{
	img1 <- read.bmp(path_img1)
	nd   <- 50
	xd1  <- matrix(NA,nd,1) 

	### Mostrar imagenes carregadas
	#image(img1) # to display the image1

	### ncol numero de colunas da imagem img1
	### nrow numero de linhas da imagem img1
	ncol <- dim(img1)[2]
	nrow <- dim(img1)[1]

	### Define uma funcao que so' faz a media de  X de 
	### todos os valores menores a 0.2
	meddk <- function(x) {return(median(which(x<0.2))) }

	### Aplica a funcao meddk sobre img1 e img2
	### e carrega em x1 e x2 respetivamente.
	x1 <- apply(img1,2,meddk)

	### Indicar onde vai salvar o PLOT
	#jpeg('function.jpg')
	#	### Faz um plot de x1 (media das linhas de x1)
	#	plot(1:ncol,x1,pch=16,cex=0.4,col="red",ylim=c(50,301))
	#dev.off()


	### Equacao do variograma de x1
	for (i in 1:nd) 
	{
		diff_x1d <- diff(x1,i)
		xd1[i] <- mean(diff_x1d*diff_x1d,na.rm=T)
	}


	plot(1:nd,xd1,col="red",main="Variogram",xlim=c(1,50),ylim=c(1,250))
	jpeg('testvar2.jpg')
		### Plot do variograma de x1 (desenhado cor vermelho com linhas)
		#win.metafile("fig2.wmf")
		plot(1:nd,xd1,col="red",main"Results",xlim=c(1,50),ylim=c(1,250))
	dev.off()

	return(0)
}


