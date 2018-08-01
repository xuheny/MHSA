function[kerdfsvalue]=MulticlassDFS(data,fselect,clnum,clnva)%dataΪѵ�����ݼ���fselect��ѡ����,clnum��data���ݼ�����������clnva��ѵ������ÿ�����ݵ�����
%xnum=length(data(:,1));%���ݼ�����������
fnum=length(data(1,:));%ԭ���ݼ�������ά����
leidata=cell(clnum,1);
n=1;
for i=1:fnum %traindata��ֻ���������Ӽ������������ݼ�
    if(fselect(i)==1)
        traindata(:,n)=data(:,i);
        n=n+1;
    end
end
fnumnow=n-1;%����fselect��˵����ά����
leimedian=zeros(clnum,fnumnow);
totalmedian=mean(traindata);%�������ݵľ�ֵ������m��
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
    leimedian(i,:)=mean(leidata{i});% ÿһ�����ݵľ�ֵ����(m(j))
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

