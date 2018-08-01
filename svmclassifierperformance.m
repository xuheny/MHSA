function[clp]=svmclassifierperformance(train_data,test_data)
C=1;
ker='linear';
global p1 p2;
p1=3;
p2=1;
lenY=length(train_data(:,1));
lenY2=length(test_data(:,1));
N=lenY/2;
N2=lenY2;
y1=ones(1,N);
y2=-ones(1,N);
y=[y1,y2];
Y=y';
[nsv alpha bias]=svc(train_data,Y,ker,C);
tstY=svcoutput(train_data,Y,test_data,ker,alpha,bias);
rightnum=0;
for i=1:N2/2
    if(tstY(i)==1)
        rightnum=rightnum+1;
    end
end
for i=N2/2+1:N2
    if(tstY(i)==-1)
        rightnum=rightnum+1;
    end
end
%disp(tstY);
clp=rightnum/N2;