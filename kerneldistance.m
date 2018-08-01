function[Jd]=kerneldistance(data_c1,data_c2,fselect)
n=1;
fnum=length(fselect);
for i=1:fnum
    if(fselect(i)==1)
        x1(:,n)=data_c1(:,i);
        x2(:,n)=data_c2(:,i);
        n=n+1;
    end
end
n1=length(x1(:,1));
n2=length(x2(:,1));
Jd=zeros(1,20);
segma=0.5;
for s=1:20
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
plot(Jd)