A=load('Test11');      
A11=A.ChannelIR;   
A=load('Test12');      
A12=A.ChannelIR;  
A=load('Test13');      
A13=A.ChannelIR;   
A=load('Test14');      
A14=A.ChannelIR;  
A=load('Test15');      
A15=A.ChannelIR;   
A=load('Test21');      
A21=A.ChannelIR;   
A=load('Test22');      
A22=A.ChannelIR;  
A=load('Test23');      
A23=A.ChannelIR;   
A=load('Test24');      
A24=A.ChannelIR;  
A=load('Test25');      
A25=A.ChannelIR;
A=load('Test31');      
A31=A.ChannelIR;   
A=load('Test32');      
A32=A.ChannelIR;  
A=load('Test33');      
A33=A.ChannelIR;   
A=load('Test34');      
A34=A.ChannelIR;  
A=load('Test35');      
A35=A.ChannelIR;
B=load('Test1ForScene');
B1=B.ChannelIR;  
B=load('Test2ForScene');
B2=B.ChannelIR;
Sample=load('Sample');
S=Sample.ChannelIR;

T={A11,A12,A13,A14,A15;A21,A22,A23,A24,A25;A31,A32,A33,A34,A35};  
u=[]; 
U={};
[sn,esen]=size(T);          %sn是场景个数；esen是每个场景实验个数
fn=3;                       %特征个数
for i=1:sn
    for j=1:esen
        u=[u;feature_self(T{i,j})];
    end
    u=reshape(u,fn,esen);
    U{i}=u;
    fea_average(:,i)=sum(U{i},2)/esen;   %%每一列代表一个场景的平均特征向量，几列就有几个场景
    u=[];
end


b1=feature_self(B1);        %待匹配的向量（匹配库就是fea_average）
b2=feature_self(B2);        %待匹配的向量

%%神经网络匹配法
Bpmodeldistinguish( fea_average,b1 );
Bpmodeldistinguish( fea_average,b2 );




%% 相对误差矩阵表示法

for i=1:sn
    V1(:,i)=abs(fea_average(:,i)-b1)./b1;   %第一组待测数据与场景的相对误差矩阵
    V2(:,i)=abs(fea_average(:,i)-b2)./b2;   %第二组待测数据与场景的相对误差矩阵
end

%% 输出总相对误差最小的场景号
vn=sum(V1);                                 %第一组待测数据与各场景总误差的向量
vn1=find(vn==min(vn));                      %与第一组待测数据总误差最小的场景号
vnt=sum(V2);                                %第二组待测数据与各场景总误差的向量
vn2=find(vnt==min(vnt));                    %与第二组待测数据总误差最小的场景号

fprintf('第一组待测数据与各场景总相对误差分别为:%4.2f,%4.2f,%4.2f\n',vn(1),vn(2),vn(3));
fprintf('第一组待测数据最接近的场景为：场景%d\n',vn1);
fprintf('第二组待测数据与各场景总相对误差分别为:%4.2f,%4.2f,%4.2f\n',vnt(1),vnt(2),vnt(3));
fprintf('第二组待测数据最接近的场景为：场景%d\n',vn2);



%%%问题三的程序
tol=1;
k=17700/20;
[ partvec,partn,err] = part_self( S,tol,k );
