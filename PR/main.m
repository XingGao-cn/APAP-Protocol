%main
clear,clc;
%topology;%运行此行代码将重置网络拓扑结构
plot_node;
plot_ring;
complete_node_struct;
container=randperm(N);
 All=0;%统计数据包总数
%清除变量
% clear alpha;
% clear h;
% clear i;
% clear id;
% clear j;
% clear k;
% clear n;
% clear ps;
% clear TH;
% clear num;
% clear str1;
% clear str2;
% clear x;
% clear y;
testflag=2;%1为一轮，2为周期
queue=[];
L=100;
M=4;
realiability=0.85;
turn=0;%运行轮数
alive1=1;%网络存活标志
initial_value=0.5;
%下面在第1、2、3环每环区域内维持通信记录表 ，函数原型：[node]=construct_table(node,circle_n,r,L)
intercepts=[];%PR中为空
die=0;
   while die~=1
    Time=3;%初始化网路时间
for i=1:N/L
    queue=container(:,L*(i-1)+1:L*i);
    for j=1:length(queue)
       [node,alive1,die_node,All]=PRUncertain_stage(node,queue(j),queue(j),Time,M,realiability,All,alive1);  
       alive1
    end    
        for  m=1:(length(node)-1)       
               [node,alive1,die_node,intercepts,All] = per_hop(node,m,Time,intercepts,All,alive1) ;
               alive1
        end
        Time=Time+1;
end

%将感知结束后的数据包全部发出
for i=1:55
    for j=1:(length(node)-1)
    [node,alive1,die_node,intercepts,All] = per_hop(node,j,Time,intercepts,All,alive1) ;
    end
    Time=Time+1;
end

for i=1:3500
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
     break;
 else
    turn=turn+1
 end
 e2e(50)=0;
if turn~=0
[Sum,E2E,redundancy]=statistics_net_realibility(node,N);
e2e(turn)=E2E;
end
node(N+1).receive=[];
  end%end while
%turn =turn +1;

%最后绘制sink，将不被遮挡
plot(0,0,'rp','LineWidth', 3);
text(0.2,0.2,'sink');

[delay_Arry,avg_Delay]=statistics_Avg_delay(node,N);
[loads,ring_avgloads,X,Y,Z]=statistics_net_data_loads(node);
[Sum,E2E,redundancy]=statistics_net_realibility(node,N);
max_energy_consume
Energy_Utilization
[a,b,part,part2,Bytes] = dlGraph(node,R,N,packet_size,1);


%********保存数据*****************
if M==2
    if testflag==1
        save('oneRound_PR,M=2');
    else
        save('period_PR,M=2');
    end
elseif M==3
    if  testflag==1
        save('oneRound_PR,M=3');
    else
         save('period_PR,M=3');
    end
else
    if testflag==1
        save('oneRound_PR,M=4');
    else
        save('period_PR,M=4');
    end
end
%*********************************



% for k=1:900
%     k
%    disp(':') ;
%    node(k).receive
% end