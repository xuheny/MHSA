function[cpl1,cpl2]=MultiConolyFairAlgotest1(N,data1,data2,clnum,clnva1,clnva2)
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
    Ncpl=zeros(N,1);
    for j=1:N
        [NS(j,:),Nresult(j,1)]=fairnessfeseldataset(data1,data2,i,clnum,clnva1,clnva2);
        Ncpl(j,1)=Multiclasssvm(data1,data2,NS(j,:),clnum,clnva1,clnva2);
        if(Ncpl(j,1)>maxNresult)
            maxNresult=Ncpl(j,1);
            bestNS=NS(j,:);
        end
    end
    MFselect(i,:)=bestNS;
    Mresult(i,1)=maxNresult;
    cpl1(1,i)=Multiclasssvm(data1,data1,MFselect(i,:),clnum,clnva1,clnva1);
    cpl2(1,i)=Mresult(i,1);
end
% for i=1:fnum
%     disp(i);
%     disp(MFselect(i,:));
%     disp(Mresult(i,1));
%     disp(cpl2(1,i));
% end
%     