function DATA=function_teste_t(file1,file2)

	xd1=load(file1);
	xd2=load(file2);

	mean_xd1=mean(xd1);
	mean_xd2=mean(xd2);
	std1=std([xd1;xd2]);

	N=max(size(xd1));

	TVALUE=(mean_xd1-mean_xd2)/(std1/sqrt(N));

	TVALUE=abs(TVALUE);

	Pvalor=2*(1-tcdf(TVALUE,N-1))*100;


	DATA.Pvalor=Pvalor;
	DATA.tvalue=TVALUE;
	DATA.std1=std1;
  DATA.Nel=N;
	DATA.mean_xd1=mean_xd1;
	DATA.mean_xd2=mean_xd2;

	%%save('testando_estatistica_campo.txt','DATA')
end
