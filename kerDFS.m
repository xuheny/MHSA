function[kerdfsvalue]=kerDFS(data,fselect,clnum,clnva)%dataΪѵ�����ݼ���fselect��ѡ����,clnum��data���ݼ�����������clnva��ѵ������ÿ�����ݵ�����
xnum=length(data(:,1));%���ݼ�����������
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
theta=5;
for i=1:clnum
    a=clnva(i);
    if(i==1)
        leifirst=0;
    else
        leifirst=leifirst+clnva(i-1);
    end
    subkerDFSdown=0;
    for j=1:a
        leidata{i}(j,:)=traindata(leifirst+j,:);
    end
    leimedian(i,:)=mean(leidata{i});% ÿһ�����ݵľ�ֵ����(m(j))
    kerDFSup=kerDFSup+(2-2*exp(-sum((leimedian(i,:)-totalmedian).^2)/(2*theta^2)));
    for s=1:a
        subkerDFSdown=subkerDFSdown+(2-2*exp(-sum((leidata{i}(s,:)-leimedian(i,:)).^2)/(2*theta^2)));
    end
    subkerDFSdown=subkerDFSdown/(a-1);
    kerDFSdown=kerDFSdown+subkerDFSdown;
end
kerdfsvalue=kerDFSup/kerDFSdown;