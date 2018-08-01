function[cpl2,MFselect]=MultiConolyFairAlgo(N,data1,data2,clnum,clnva1,clnva2)
fnum=length(data1(1,:));
traindnum=length(data1(:,1));
testdnum=length(data2(:,1));
MFselect=zeros(fnum,fnum);
Mresult=zeros(fnum,1);
Mscore=zeros(fnum,1);
cpl1=zeros(1,fnum);
cpl2=zeros(1,fnum);
for i=1:fnum
    b=newfs(data1,i,clnum,clnva1);
    maxNresult=0;
    bestNS=zeros(1,fnum);
    Nresult=zeros(N,1);
    NS=zeros(N,fnum);
    for j=1:N
        [NS(j,:),Nresult(j,1)]=fairnessfeseldataset(data1,data2,i,clnum,clnva1,clnva2);
        if(Nresult(j,1)>maxNresult)
            maxNresult=Nresult(j,1);
            bestNS=NS(j,:);
        end
    end
    MFselect(i,:)=bestNS;
    Mresult(i,1)=maxNresult;
    dwn=1;
    train_data=zeros(traindnum,i);
    test_data=zeros(testdnum,i);
    for k=1:fnum
        if(bestNS(k)==1)
            train_data(:,dwn)=data1(:,k);
            test_data(:,dwn)=data2(:,k);
            dwn=dwn+1;
        end
    end
%    cpl1(1,i)=Multiclasssvm2(train_data,train_data,clnum,clnva1,clnva1);
    cpl2(1,i)=Multiclasssvm2(train_data,test_data,clnum,clnva1,clnva2);
end
% for i=1:fnum
%     disp(i);
%     disp(MFselect(i,:));
%     disp(Mresult(i,1));
%     disp(cpl2(1,i));
% end
%     