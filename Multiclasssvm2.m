function[clp]=Multiclasssvm2(data1,data2,clnum,clntrainva,clntestva)%多类数据集分类器,数据集是已经弄好了的特征子集数据集
%采用DAG方法进行多类分类，即对每组数据，从1-N分类开始，不断进行，直至最后两类分类。
%data1为训练数据集，data2是测试数据集,clnum为数据集类数，clntrainva为训练集各类数据组数，clntestva为测试集各类数据组数
C=1;
ker='linear';
global p1 p2;
p1=3;
p2=1;
leidatatrain=cell(clnum,1);
datanum=length(data1(:,1));
testdatanum=length(data2(:,1));
Nclsvc=clnum*(clnum-1);
clnsv=zeros(Nclsvc,1);
clalpha=cell(Nclsvc,1);
clbias=zeros(Nclsvc,1);
for i=1:clnum
    if(i==1)
        for j=1:clntrainva(1)
            leidatatrain{i}(j,:)=data1(j,:);
        end
    else
        n=1;
        for j=(sum(clntrainva(1:i-1))+1):(sum(clntrainva(1:i)))
            leidatatrain{i}(n,:)=data1(j,:);
            n=n+1;
        end
    end
end
for i=1:(clnum-1)
    for j=(i+1):clnum
        svctraindata=[leidatatrain{i};leidatatrain{j}];
        Y=[ones(clntrainva(i),1);-ones(clntrainva(j),1)];
        [clnsv(i*j) clalpha{i*j} clbias(i*j)]=svc(svctraindata,Y,ker,C);
    end
end
% disp(clnsv);
% disp(clalpha);
% disp(clbias);
% ky=svcoutput([leidatatrain{1};leidatatrain{3}],[ones(clntrainva(1),1);-ones(clntrainva(3),1)],data2,ker,clalpha{2},clbias(2));
% disp(ky);
flresult=zeros(testdatanum,1);
for i=1:testdatanum
    s=1;
    t=clnum;
    while((t-s)>=1)
        ky=svcoutput([leidatatrain{s};leidatatrain{t}],[ones(clntrainva(s),1);-ones(clntrainva(t),1)],data2(i,:),ker,clalpha{s*t},clbias(s*t));
        if(ky==1)
            flresult(i)=s;
            t=t-1;
        else
            flresult(i)=t;
            s=s+1;
        end
    end
end
rightnum=0;
for i=1:clnum
    if(i==1)
        for j=1:clntestva(i)
            if(flresult(j)==i)
                rightnum=rightnum+1;
            end
        end
    else
        for j=sum(clntestva(1:i-1))+1:sum(clntestva(1:i))
            if(flresult(j)==i)
                rightnum=rightnum+1;
            end
        end
    end
end
clp=rightnum/testdatanum;
% disp(flresult);
%disp(rightnum);