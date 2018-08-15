%
FONTSIZE=18;
L=50;
N=1:L;
P=zeros(1,L);
T=zeros(1,L);
Nel=zeros(1,L);
for II=1:L
	file1=['out_extline' filesep() 'xd1-red' num2str(II) '.txt'];
	file2=['out_extline' filesep() 'xd2-green' num2str(II) '.txt'];
	DATA=function_teste_t(file1,file2);
	P(II)=DATA.Pvalor;
  T(II)=DATA.tvalue;
  Nel(II)=DATA.Nel;
end

mkdir('out_testando');

figure(1)
plot(N,P,'-o');
%title('P value')
hy=ylabel('P value (%)');
hx=xlabel('Columns');
set (hx, "fontsize", FONTSIZE) 
set (hy, "fontsize", FONTSIZE) 
set (gca,"fontsize", FONTSIZE)
ylim([0 1.0])
print(gcf,['out_testando' filesep() 'Pvalue.jpeg'])

figure(2)
plot(N,T,'-o');
title('T value')
print(gcf,['out_testando' filesep() 'Tvalue.jpeg'])

figure(3)
plot(N,Nel,'-o');
title('Nel value')
print(gcf,['out_testando' filesep() 'Nelvalue.jpeg'])

	file1=['out_extline' filesep() 'meanxd1.txt'];
	file2=['out_extline' filesep() 'meanxd2.txt'];
	meanxd1=load(file1)';
	meanxd2=load(file2)';
 
    file1=['out_extline' filesep() 'stdxd1.txt'];
	file2=['out_extline' filesep() 'stdxd2.txt'];
	err1=load(file1)';
	err2=load(file2)';
    figure(4)
    plot(N,meanxd1,'.-',N,meanxd2,'-');
    ylim([0 350])
    hy=ylabel('Mean');
    hx=xlabel('Columns');
    set (hx, "fontsize", FONTSIZE)
    set (hy, "fontsize", FONTSIZE)
    set (gca,"fontsize", FONTSIZE)
    print(gcf,['out_testando' filesep() 'Mediavalue.jpeg'])
  
