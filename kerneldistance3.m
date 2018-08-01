function[Jd]=kerneldistance3(data,fselect)
%在本函数中，核参数是由函数kerneldistance2得到的(人为看出来的)，是已经确定的
%计算特征子集的核空间距离，初始输入数据是一个矩阵
%iris数据集segma取2
%statlog数据集segma取22
%wine数据集segma取5
%nolineardata数据集segma取25
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