# wireless-communication
Recognizing the feature of the wireless channel fingerprint based on two algorithms（an application of pattern recognition）

we modeling the feature of the wireless channel "fingerprint", which including the issues like the establishment of the characteristic parameters of " fingerprint ", matching and recognition and "dividing the region" of continuous characteristic parameters. The model solved by the extraction algorithm about wireless channel parameters, BP neural network algorithm and the infinitesimal heuristics proposed by us

针对无线信道“指纹”特征建模，包括“指纹”特征参数的建立、匹配识别、连续特征参数的“区域划分”等问题，用无线信道参数的提取算法、BP神经元网络算法和我们建立的微元试探法对模型进行分析求解

# 核心代码
    function  Bpmodeldistinguish( X,Y )

    %*****************************************************
    %利用matalb实现基于BP神经网络模式识别实现代码
    %*****************************************************

    % X是三个场景的平均特征向量所组成的矩阵（就是fea_average）
    % Y是待匹配的特征向量（就是b1或b2）
    %**************************************************************************
    %**************** 先对X和Y进行标准化处理 *******************
    %**************************************************************************
    X=[1e9*X(1,:);1e3*X(2,:);X(3,:)/100];
    X=X';
    X0=ones(3,16);
    X0(:,[1:3])=X;
    X=X0;
    Y=[1e9*Y(1);1e3*Y(2);Y(3)/100];
    Y=Y';
    Y0=ones(1,16);
    Y0(1:3)=Y;
    Y=Y0;


    %**************************************************************************
    %*******************主函数main*********************************************
    %*************************START********************************************
    %**************************************************************************
    Y1=[1 0 0];      %输出模式           
    Y2=[0 1 0];
    Y3=[0 0 1];
    Yo=[Y1;Y2;Y3]; %输出的三种模式
    n=16; %输入层神经元个数
    p=8;  %中间层神经元个数
    q=3;  %输出神经元个数
    k=3 ;%训练模式个数
    a1=0.2; b1=0.2; %学习系数，
    %rou=0.5;%动量系数，
    emax=0.01; cntmax=100;%最大误差，训练次数
    [w,v,theta,r,t,mse]=bptrain(n,p,q,X,Yo,k,emax,cntmax,a1,b1);%调用函数bptrain训练网络
    c=bptest(p,q,n,w,v,theta,r,Y);
    c(c>0.5)=1;
    c(c<0.2)=0;
    disp('测试数据的识别结果:')
    c
    if (min(c==Y1)==1)
        fprintf('该数据和场景1匹配\n');
    elseif (min(c==Y2)==1)
            fprintf('该数据和场景2匹配\n');
    else
            fprintf('该数据和场景3匹配\n');
    end

    %**************************************************************************
    %**************************END*********************************************
    %**************************************************************************
