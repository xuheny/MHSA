function[Jd]=kerneldistance3(data,fselect)
%�ڱ������У��˲������ɺ���kerneldistance2�õ���(��Ϊ��������)�����Ѿ�ȷ����
%���������Ӽ��ĺ˿ռ���룬��ʼ����������һ������
%iris���ݼ�segmaȡ2
%statlog���ݼ�segmaȡ22
%wine���ݼ�segmaȡ5
%nolineardata���ݼ�segmaȡ25
T=length(data(:,1));
n=1;
fnum=length(fselect);
for i=1:fnum
    if(fselect(i)==1)
        x1(:,n)=data(1:T/2,i);
        x2(:,n)=data(T/2+1:T,i);
        n=n+1;
    end
end
n1=length(x1(:,1));
n2=length(x2(:,1));
double Jd;
segma=5;
Jd=0;
for i=1:n1
    for j=1:n2
        ecudis=sum(abs(x1(i,:)-x2(j,:)));
        ksegma=exp(-ecudis/(2*segma^2));
        Jd=Jd+sqrt(2-2*ksegma);
    end
end
Jd=Jd/(n1*n2);