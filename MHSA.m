function[]=MHSA()
%参数设置；
epclon=0.8;
lemta1=0.05;
lemta2=0.05;
lemta3=0.9;
lemta4=0.8;
c=zeros(10,10);%所有人工蚊子的权重；
r=zeros(10,10);%所有人工蚊子的灰度值；
x=zeros(10,10);
C=[0.518 0.249;0.558 0.384;0.430 0.452;0.289 0.441;0.082 0.922;0.366 0.825;0.910 0.538;0.852 0.284;0.720 0.082;0.591 0.097];
disp(C);
for i=1:10
    for j=1:10;
        if(i==j)
            d(i,j)=10;
        else
            d(i,j)=sqrt((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2);
        end
    end
end
disp(d);
maxd=max(max(d));
for i=1:10
    for j=1:10
        c(i,j)=maxd-d(i,j);
        r(i,j)=0.2;
        x(i,j)=1;
    end
end
for i=1:10
    c(i,:)=2*c(i,:)./(sum(c(i,:)));
end
for i=1:10
    c(:,i)=2*c(:,i)./(sum(c(:,i)));
end

Z=0;
for i=1:10
    for j=1:10
        Z=Z+d(i,j)*r(i,j);
    end
end
t=1;
while(t<200)
    expuepclon=0;
    sumrx=0; 
    rx=r.*x;
    for i=1:10
        sumrx=sumrx+(sum(rx(i,:))-2);
    end
    for i=1:10 
        for j=1:10
            u(i,j)=1-exp(-c(i,j)*r(i,j)*x(i,j));
            expuepclon=expuepclon+exp(-((u(i,j)*u(i,j))/(2*epclon*epclon)));
            dur(i,j)=-c(i,j)*x(i,j)*exp(-c(i,j)*r(i,j)*x(i,j));
            duc(i,j)=-r(i,j)*x(i,j)*exp(-c(i,j)*r(i,j)*x(i,j));
            dJr(i,j)=-c(i,j)*x(i,j)*exp(-c(i,j)*r(i,j)*x(i,j));
            dJc(i,j)=-r(i,j)*x(i,j)*exp(-c(i,j)*r(i,j)*x(i,j));
            dQr(i,j)=2*sum(x(i,:))*sumrx+((1/(1+exp(-10*u(i,j))))-0.5)*dur(i,j);
            dQc(i,j)=((1/(1+exp(-10*u(i,j))))-0.5)*duc(i,j);
        end 
    end 
    for i=1:10
        for j=1:10
            dPr(i,j)=u(i,j)*(exp(-(u(i,j)*u(i,j))/(2*epclon*epclon))/expuepclon)*dur(i,j);
            dPc(i,j)=u(i,j)*(exp(-(u(i,j)*u(i,j))/(2*epclon*epclon))/expuepclon)*duc(i,j);
        end
    end
    for i=1:10
        for j=1:10
            detr(i,j)=-lemta1*dur(i,j)-lemta2*dJr(i,j)-lemta3*dPr(i,j)-lemta4*dQr(i,j);
            detc(i,j)=-lemta1*duc(i,j)-lemta2*dJc(i,j)-lemta3*dPc(i,j)-lemta4*dQc(i,j);
        end
    end
    r=r+detr;
    c=c+detc;
    minr=min(min(r)); 
    minc=min(min(c)); 
    for i=1:10
        for j=1:10 
            r(i,j)=r(i,j)-minr;
            c(i,j)=c(i,j)-minc;
        end
    end
    for i=1:10
        r(i,:)=2*r(i,:)./(sum(r(i,:)));
        c(i,:)=2*c(i,:)./(sum(c(i,:)));
    end
    for i=1:10
        r(:,i)=2*r(:,i)./(sum(r(:,i)));
        c(:,i)=2*c(:,i)./(sum(c(:,i)));
    end
    t=t+1;
end
    disp(' ');
    disp(' ');
    disp(r); 
    disp(' ');
disp(' ');
disp(c);
Z=0;
for i=1:10
    for j=1:10
        Z=Z+d(i,j)*r(i,j);
    end
end

    disp(' ');
disp(' ');
disp(Z);