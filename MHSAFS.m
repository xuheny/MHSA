function[]=MHSAFS()
%参数设置；
epclon=0.8;
lemta1=0.05;
lemta2=0.05;
lemta3=0.9;
lemta4=0.8;
M=3;
c=zeros(1,10);%所有人工蚊子的权重；
r=zeros(1,10);%所有人工蚊子的灰度值；
d=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
maxd=max(d);
for i=1:10
    c(i)=maxd-d(i);
    r(i)=M/10;
end
c=M*c./sum(c);
disp(c);
Z=zeros(1,500);
for i=1:10
    Z(1,1)=Z(1,1)+d(i)*r(i);
end
t=1;
while(t<500)
    expuepclon=0;
    sumr=0; 
    sumr=sum(r);
    for i=1:10 
            u(i)=1-exp(-c(i)*r(i));
            expuepclon=expuepclon+exp(-((u(i)*u(i))/(2*epclon*epclon)));
            dur(i)=-c(i)*exp(-c(i)*r(i));
            duc(i)=-r(i)*exp(-c(i)*r(i));
            dJr(i)=-c(i)*exp(-c(i)*r(i));
            dJc(i)=-r(i)*exp(-c(i)*r(i));
            dQr(i)=2*(sumr-M)+((1/(1+exp(-10*u(i))))-0.5)*dur(i);
            dQc(i)=((1/(1+exp(-10*u(i))))-0.5)*duc(i);
    end 
    for i=1:10
            dPr(i)=-u(i)*(exp(-(u(i)*u(i))/(2*epclon*epclon))/expuepclon)*dur(i);
            dPc(i)=-u(i)*(exp(-(u(i)*u(i))/(2*epclon*epclon))/expuepclon)*duc(i);
    end
    for i=1:10
            detr(i)=-lemta1*dur(i)-lemta2*dJr(i)-lemta3*dPr(i)-lemta4*dQr(i);
            detc(i)=-lemta1*duc(i)-lemta2*dJc(i)-lemta3*dPc(i)-lemta4*dQc(i);
    end
    r=r+detr;
    c=c+detc;
    minr=min(r); 
    minc=min(c); 
    if(minr<0)
        for i=1:10
            r(i)=r(i)-minr;
        end
    end
    if(minc<0)
        for i=1:10
            c(i)=c(i)-minc;
        end
    end
    r=M*r./(sum(r));
    c=M*c./(sum(c));
    t=t+1;
    for i=1:10
        Z(1,t)=Z(1,t)+d(i)*r(i);
    end
    disp('R');
    disp(t);
     disp(' ');
    disp(r); 
        disp('C');
    disp(t);
    disp(' ');
disp(c);
    disp(' ');
end
plot(Z);
 