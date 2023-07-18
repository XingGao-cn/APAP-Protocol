%testing the key parameter L used in active packet-loss for one round
%main
clear,clc;

%topology;%Running this line of code will reset the network topology
plot_node;
plot_ring;
complete_node_struct;
container=randperm(N);
alive1=1;%网络存活标志
 All=0;%统计网络数据量
 
%清除变量
clear alpha;
clear h;
clear i;
clear id;
clear j;
clear k;
clear n;
clear ps;
clear TH;
clear num;
clear str1;
clear str2;
clear x;
clear y;
%******************

testflag=2;%1为一轮，2为周期
Sav=0;%记录节省的能量
Saving=0;
queue=[];
L=50;%每一轮的选中的节点
Time=3; 
turn=0;%统计运行轮数
%下面在第1、2、3环每环区域内维持通信记录表 ，函数原型：[node]=construct_table(node,circle_n,r,L)
Cost=0;%记录三环内因额外通信开销所消耗的能量
messages=zeros(2);%message(1)存储信息发送数量，(2)存储消耗的能量

 %每环拦截数据包的数量
Intercepts(50)=0;
intercepts=[];
intercept1=0; 
intercept2=0;
intercept3=0;
LL=10;%表的长度
[node]=construct_table(node,1,30,LL);
[node]=construct_table(node,2,30,LL);
[node]=construct_table(node,3,30,LL);
die=0;

for i=1:N/L
    queue=container(:,L*(i-1)+1:L*i);
    for j=1:length(queue)
        if node(queue(j)).ring==inf
            continue;
        end
       [node,alive1,die_node,All,messages]=PRUncertain_stage(node,queue(j),queue(j),Time,3,0.85,All,alive1,messages);  
    end    
        for  m=1:(length(node)-1)     
            if node(m).ring==inf
                 continue;
            end
               [node,alive1,die_node,intercepts,All,messages,Saving] = per_hop(node,m,Time,intercepts,All,alive1,messages) ;
      
               Sav=Sav+Saving;
        end
        Time=Time+1;
        %更新表的时间  函数原型：[node]=Update_table(node,circle_n,time),time为更新间隔
        [node]=Update_table(node,circle_1,2);
        [node]=Update_table(node,circle_2,2);
        [node]=Update_table(node,circle_3,2);
end

%将感知结束后的数据包全部发出

for i=1:60  
    for j=1:(length(node)-1)
        if node(j).ring==inf
                 continue;
        end
    [node,alive1,die_node,intercepts,All,messages,Saving] = per_hop(node,j,Time,intercepts,All,alive1,messages) ;
    
    Sav=Sav+Saving;
    end
    Time=Time+1;
    %更新表的时间
    [node]=Update_table(node,circle_1,2);
    [node]=Update_table(node,circle_2,2);
    [node]=Update_table(node,circle_3,2);
end

for i=1:15000
   node(N+1).Data(i).ID=0; 
   node(N+1).Data(i).PRs=0;
   node(N+1).Data(i).start_time=0;
   node(N+1).Data(i).num=0;
   node(N+1).Data(i).TTL=0;
   node(N+1).Data(i).delay=0;
   node(N+1).Data(i).w=1;
end

for i=1:length(node)-1
   if node(i).re_energy<=0
       die=1;
   end
end

 if die==1
 else
    turn=turn+1;
 end
 turn
 
if turn~=0
    Intercepts(turn)=length(intercepts);
end
  e2e(50)=0;
if turn~=0
    [~,E2E,~]=statistics_net_realibility(node,N);
    e2e(turn)=E2E;
end

%node(N+1).receive=[];

%turn = turn +1;
%最后绘制sink，将不被遮挡
plot(0,0,'rp','LineWidth', 3);
text(0.2,0.2,'sink');

[delay_Arry,avg_Delay]=statistics_Avg_delay(node,N)

[loads,ring_avgloads,X,Y,Z]=statistics_net_data_loads(node)

[Sum,E2E,redundancy]=statistics_net_realibility(node,N)

max_energy_consume1

Energy_Utilization

[a,b,part,part2,Bytes] = dlGraph(node,R,N,packet_size,1);
%*******保存数据***********
% if testflag==1
%     save('oneRound_newStrategy--1200');
% elseif testflag==2
%     save('period_newStrategy--1200');
% end
%**************************

% save('full-round_newStrategy');

% for k=1:900
%     k
%    disp(':') ;
%    node(k).receive
% end