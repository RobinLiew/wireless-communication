function [ partvec,partn,err,erryindex] = part_self( S,tol,k )
%  Inupts:
%         S        : 样本矩阵
%         tol      : 终止标准（一个很小的数）
%         k        : 最小步数（多少行），最小单位是1米对应118行

%  Outputs:
%         partvec: 分割节点向量（分割处行号所组成的向量）
%         partn  : 分割所得的场景数（分割成了几个场景）partn=Length(partvec)
%         err    : 相对误差向量
%         erryindex: 分割处相对误差的下标
 
partvec=1;
count=k;

Sp=S([1:count],:);
feavec=feature_self(Sp);
count=count+k;
[row,col]=size(S);
n=floor(row/k)-2;
erryindex=[];

for i=1:n
    feavec_old=feavec;
    Sp=S([partvec(end):count],:);    % 加上新一段
    feavec=feature_self(Sp);
    err(i,1)=sum(abs(feavec-feavec_old)./abs(feavec_old));
    if (err(i,1)>tol)                  
        partvec=[partvec;count-k+1];       %误差大就添加新的分割点
        Sp=S([partvec(end):count],:);
        feavec=feature_self(Sp);
        erryindex=[erryindex;i];
    end
    count=count+k;
end
partn=length(partvec);    

