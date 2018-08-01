function[]=kerneldistance2(data,fselect)
%计算单维特征的核空间距离，根据得出的核空间距离随着核参数的变化图
%选择最合适的核参数
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
Jd=zeros(1,100);
segma=0.5;
for s=1:100
    if(segma~=0)
        for i=1:n1
            for j=1:n2
                ecudis=sum(abs(x1(i,:)-x2(j,:)));
                ksegma=exp(-ecudis/(2*segma^2));
                Jd(s)=Jd(s)+sqrt(2-2*ksegma);
            end
        end
    end 
    Jd(s)=Jd(s)/(n1*n2);
    segma=segma+0.5;
end
plot(Jd);