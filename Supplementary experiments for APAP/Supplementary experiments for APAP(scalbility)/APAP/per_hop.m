%此函数用于数据包的单跳传输  遍历全网节点 
function [node,alive1,die_node,intercepts,All,messages,Saving] = per_hop(node,id,time,intercepts,All,alive1,messages)
%首先解决初始化问题：根据距离与公式确定initilize、w、TTL
%调用随机函数选择n个节点，进行初始化后运行随即分离算法
%计算收发能量，若发送成功，记录在Data中，然后计算延迟，w--，TTL--，
%全网进行一跳传输，若w！=0，则随机游走一步，若TTL！=0，则最短路前进一步，若TTL=0，则先生成数据包，等待延迟后随机游走
%alive1=1;                 %如节点能量足够，则网络存活

die_node=0;               %如果无节点死亡，则死亡节点为0
r=60;                    %通信距离为60m    
d0 = 87;                 %临界距离  
N=225 ;                  %节点数
packet_size=1024;       %根据论文数据包大小为1024bits/128bits
elec = 50*10^(-9);       %10-9 发射电路损耗能量
fs = 10*10^(-12);        %10-12  发射功率放大所需能量功率
amp = 0.0013*10^(-12) ;  %10-12  接收功率放大所需能量功率
inward_delay=1;     %一跳延迟为1ms
PR_dalay=2;         %一次PR延迟为2ms
%global All;
j=0;
m=0;
flg=0;%标记
Saving=0;
Length=10;%表的长度
inform0=3;%通知阈值


%ID号为id的节点遍历本地数据
for i=1:length(node(id).Data)
    if node(id).ring==inf
        break;
    end
    data_id=node(id).Data(i).ID;
    flg=0;
        if node(id).Data(i).ID==0 %即当前存储位置不存在待发送的数据
             continue;
        end
        %不发送复制未完成中的数据包，即让再生的数据包等待延迟后发送
        if node(id).Data(i).start_time>time 
            continue;
        else
        %************************
%             %在此处读取pass记录以决定是否拦截当前数据包
             if ((node(id).ring==1)||(node(id).ring==2)||(node(id).ring==3))
                 for v=1:length(node(id).pass)
                     if  node(id).pass(v).id==data_id && node(id).pass(v).copies>2   %超出数据包份数阈值2，不发送
                         %清空本地记录
                   
                         node(id).Data(i).ID=0;
                         node(id).Data(i).start_time=0;
                         node(id).Data(i).num=0;
                         node(id).Data(i).PRs=0;
                         node(id).Data(i).delay=0;
                         node(id).Data(i).TTL=0;
                         node(id).Data(i).w=1;
                         intercepts=[intercepts,data_id]; %拦截数据包数量
                          Saving = energySaving(node,id,packet_size);
                         flg=1;
                         break;
                     end
                 end
                 if flg==1
                     continue;
                 end
             end           
        if node(id).Data(i).ID==0 %即当前存储位置不存在待发送的数据
             continue;
        end
            %*************第一环节点特殊处理（直接发送）***********
            if node(id).ring==1 
                receive_id=N+1;
            [rand_num]=reliability_rand;%调用随机函数获取可靠性
            if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%发送成功
            %***********************
                [node,alive1,die_node] = calculate_energy(node,id,receive_id,alive1,die_node);%计算收发两端能量
                node(id).Data(i).delay=node(id).Data(i).delay+inward_delay;%加上单跳传输延迟
                   for k=1:length(node(receive_id).Data)
                       k
                      if node(receive_id).Data(k).ID==0
                         j=k;
                         break;
                      end
                   end
                   d=node(receive_id).Data
                   id
                   receive_id
                   i
                   j
                node(receive_id).Data(j)= node(id).Data(i);%将本地数据赋值给接收节点
                node(receive_id).receive=[node(receive_id).receive,node(id).Data(i).ID];%receive中记录一下
       %******向维持了表的环中添加数据***********
       %设置hotspot区域为1~3环内的节点
       if node(receive_id).ring==1||node(receive_id).ring==2||node(receive_id).ring==3
               is_full=1;%0代表表未满，1代表表中记录已满
               insert_pos1=0;%用来记录历史记录的位置
               insert_pos2=0;%用来记录表中可插入的位置
       for Len=1:Length    %Len为表的容量，即记录的条数
           if node(receive_id).pass(Len).id==data_id %表中存在历史记录
               insert_pos1=Len;
               break;
           end
           if node(receive_id).pass(Len).id==0 %表未满
               insert_pos2=Len;
               is_full=0;
           end           
       end
       if insert_pos1~=0 %表中存在相同ID的记录，直接更新历史记录即可
           node(receive_id).pass(insert_pos1).copies=node(receive_id).pass(insert_pos1).copies+1;
           node(receive_id).pass(insert_pos1).gap_time=-1;
       elseif is_full==0 %在insert_pos2处插入记录
           node(receive_id).pass(insert_pos2).id=data_id;
           node(receive_id).pass(insert_pos2).copies=1;
           node(receive_id).pass(insert_pos2).gap_time=-1;  
       end
       %在此处添加函数通知表内邻居
       if insert_pos1~=0
           node(receive_id).pass(insert_pos1).copies    %此句的作用是为了观察变量值
       if node(receive_id).pass(insert_pos1).copies >inform0   
         [node,messages]=inform_table_member(node,receive_id,data_id,messages);
       end
       end
       end
       %***********************
                %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1;
       %***********************
            else
                [node,alive1,die_node] = compute_energy(node,id,receive_id,alive1,die_node);%计算发送端能量
                 %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1;
            end %if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%发送成功
                continue;
            end  %node(id).ring==1
            
    %*********************非第一环节点**********************

    if node(id).Data(i).w<=0 %意味着：随机游走结束，进行最短路路由，否则继续进行随机游走
        if node(id).Data(i).TTL~=0 %最短路路由
            receive_id=node(id).short_hop;
            [rand_num]=reliability_rand;
            if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%发送成功
            %***********************
                [node,alive1,die_node] = calculate_energy(node,id,receive_id,alive1,die_node);%计算收发两端能量
                node(id).Data(i).delay=node(id).Data(i).delay+inward_delay;
                node(id).Data(i).start_time=time+inward_delay;
                node(id).Data(i).TTL=node(id).Data(i).TTL-1;
                   for k=1:length(node(receive_id).Data)
                      if node(receive_id).Data(k).ID==0
                         j=k;
                         break;
                      end
                   end
                node(receive_id).Data(j)=node(id).Data(i);%将本地数据赋值给接收节点
                node(receive_id).receive=[node(receive_id).receive,node(id).Data(i).ID];%receive中记录一下
        %******向维持了表的环中添加数据***********
       if node(receive_id).ring==1||node(receive_id).ring==2||node(receive_id).ring==3
               is_full=1;%0代表表未满，1代表表中记录已满
               insert_pos1=0;%用来记录历史记录的位置
               insert_pos2=0;%用来记录表中可插入的位置
       for Len=1:Length
           if node(receive_id).pass(Len).id==data_id %表中存在历史记录
               insert_pos1=Len;
               break;
           end
           if node(receive_id).pass(Len).id==0 %表未满
               insert_pos2=Len;
               is_full=0;
           end           
       end
       if insert_pos1~=0 %直接更新历史记录即可
           node(receive_id).pass(insert_pos1).copies=node(receive_id).pass(insert_pos1).copies+1;
           node(receive_id).pass(insert_pos1).gap_time=-1;
       elseif is_full==0 %在insert_pos2处插入记录
           node(receive_id).pass(insert_pos2).id=data_id;
           node(receive_id).pass(insert_pos2).copies=1;
           node(receive_id).pass(insert_pos2).gap_time=-1;
       end
       %在此处添加函数通知表内邻居
       if insert_pos1~=0
           node(receive_id).pass(insert_pos1).copies   %此句的作用只是为了看变量值debug
       if node(receive_id).pass(insert_pos1).copies >inform0   
         [node,messages]=inform_table_member(node,receive_id,data_id,messages);
       end
       end
       end
       %***********************
                 %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1; 
       %***********************
            else
                [node,alive1,die_node] = compute_energy(node,id,receive_id,alive1,die_node);%计算发送端能量
                 %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1; 
            end % if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%发送成功
                            
        else %TTL==0新周期开始,中段恢复后进行随机扩散
            [node,alive1,die_node,All,messages]=PRUncertain_stage(node,id,node(id).Data(i).ID,time,2,0.85,All,alive1,messages);
             %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1;
        end %  if node(id).Data(i).TTL~=0%最短路路由
    else % w~=0 随机游走阶段未结束，继续游走(1step)      
        [directions,~]=seed_random_dispersity2(node,id,1,60);%进行一步随机游走. 选择方向
%         node(id).Data(i).start_time= node(id).Data(i).start_time+inward_delay;
%         node(id).Data(i).TTL=node(id).Data(i).TTL-1;
%         node(id).Data(i).delay=node(id).Data(i).delay+inward_delay;
%         node(id).Data(i).w=node(id).Data(i).w-1;
    if isempty(directions)
       receive_id=0;
    else
        receive_id=directions(1);  %此时只是单份数据包的游走，故只选择一个方向即可
    end
             if receive_id==0 %此时在此范围没有邻居节点 此段代码不知道有没有问题
                 %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1; 
                continue;
             end
             
            if node(id).ring~=1   %随机游走到达的节点
                 receive_id=directions(1);
            else
                 receive_id=N+1;
            end

      [rand_num]=reliability_rand;
     % rand_num=1;
   if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%随机游走成功
       %***********************
       [node,alive1,die_node] = calculate_energy(node,id,receive_id,alive1,die_node);%计算收发两端能量
       node(id).Data(i).start_time= time+inward_delay;
       node(id).Data(i).delay=node(id).Data(i).delay+inward_delay;
       node(id).Data(i).TTL=node(id).Data(i).TTL;
       node(id).Data(i).w=node(id).Data(i).w;
       for k=1:length(node(receive_id).Data)
          if node(receive_id).Data(k).ID==0
              j=k;
          end
       end
       node(receive_id).Data(j)=node(id).Data(i);%将本地数据赋值给接收节点
       node(receive_id).receive=[node(receive_id).receive,node(id).Data(i).ID];%receive中记录一下
      %******向维持了表的环中添加数据***********
       if node(receive_id).ring==1||node(receive_id).ring==2||node(receive_id).ring==3
               is_full=1;%0代表表未满，1代表表中记录已满
               insert_pos1=0;%用来记录历史记录的位置
               insert_pos2=0;%用来记录表中可插入的位置
       for Len=1:Length
           if node(receive_id).pass(Len).id==data_id %表中存在历史记录
               insert_pos1=Len;
               break;
           end
           if node(receive_id).pass(Len).id==0 %表未满
               insert_pos2=Len;
               is_full=0;
           end           
       end
       if insert_pos1~=0 %直接更新历史记录即可
           node(receive_id).pass(insert_pos1).copies=node(receive_id).pass(insert_pos1).copies+1;
           node(receive_id).pass(insert_pos1).gap_time=-1;
       elseif is_full==0 %在insert_pos2处插入记录
           node(receive_id).pass(insert_pos2).id=data_id;
           node(receive_id).pass(insert_pos2).copies=1;
           node(receive_id).pass(insert_pos2).gap_time=-1;
       end
       %在此处添加函数通知表内邻居
       if insert_pos1~=0
           node(receive_id).pass(insert_pos1).copies   %此句的作用是为了查看变量值
       if node(receive_id).pass(insert_pos1).copies >inform0   
         [node,messages]=inform_table_member(node,receive_id,data_id,messages);
       end
       end
       end % if node(receive_id).ring==1||node(receive_id).ring==2||node(receive_id).ring==3
       %***********************
        %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1;
       %***********************
   else % 随机游走失败
       [node,alive1,die_node] = compute_energy(node,id,receive_id,alive1,die_node);%计算发送端能量
       %清空本地记录
                node(id).Data(i).ID=0;
                node(id).Data(i).start_time=0;
                node(id).Data(i).num=0;
                node(id).Data(i).PRs=0;
                node(id).Data(i).delay=0;
                node(id).Data(i).TTL=0;
                node(id).Data(i).w=1;
   end % if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%发送成功
                   
    end % if node(id).Data(i).w==0%随机游走结束才进行最短路路由，否则继续进行随机游走
    
        end %if node(id).Data(i).start_time>time %不发送复制未完成中的数据包

end %for i=1:300,即遍历Data 

end %function




