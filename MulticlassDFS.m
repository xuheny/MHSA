function[kerdfsvalue]=MulticlassDFS(data,fselect,clnum,clnva)%data为训练数据集，fselect所选特征,clnum是data数据集中种类数，clnva是训练集中每类数据的组数
%xnum=length(data(:,1));%数据集的总样本数
fnum=length(data(1,:));%原数据集的特征维度数
leidata=cell(clnum,1);
n=1;
for i=1:fnum %traindata是只包含特征子集中特征的数据集
    if(fselect(i)==1)
        traindata(:,n)=data(:,i);
        n=n+1;
    end
end
fnumnow=n-1;%按照fselect来说特征维数；
leimedian=zeros(clnum,fnumnow);
totalmedian=mean(traindata);%所有数据的均值向量（m）
kerDFSup=0; 
kerDFSdown=0;
%theta=5;
%leifirst=0;
subkerDFSdown=zeros(1,clnum);
parfor i=1:clnum
    a=clnva(i);
    if(i==1)
        leifirst=0;
    else
        leifirst=sum(clnva(1:i-1));
    end
    for j=1:a
        leidata{i}(j,:)=traindata(leifirst+j,:);
    end
    leimedian(i,:)=mean(leidata{i});% 每一类数据的均值向量(m(j))
    for s=1:a
        subkerDFSdown(i)=subkerDFSdown(i)+sum((leidata{i}(s,:)-leimedian(i,:)).^2);
    end
    subkerDFSdown(i)=subkerDFSdown(i)/(a-1);
end
for i=1:clnum
    kerDFSup=kerDFSup+sum((leimedian(i,:)-totalmedian).^2);
    kerDFSdown=kerDFSdown+subkerDFSdown(i);
end
kerdfsvalue=kerDFSup/kerDFSdown;

