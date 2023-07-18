%此文件为不确定阶段的过程，整个路由过程由不确定阶段与确定阶段构成
function [node,alive1,die_node,All,messages]=PRUncertain_stage(node,id,data_id,Time,~,realiability,All,alive1,messages)
%其中id是复制数据包的源节点、中继节点id，data_id是所需复制的数据包的id.当首次感知数据时id==data_id
R = 200;             %网络半径
r=60;                %节点的发射半径
N = 225;            %节点个数
%global All;
packet_size = 1024 ;%假设每个数据包的比特数为1024

%能量消耗有关参数
d0 = 87; %临界距离
elec = 50*10^(-9);%10-9 发射电路损耗能量
fs = 10*10^(-12); %10-12  发射功率放大所需能量功率
amp = 0.0013*10^(-12);%10-12  接收功率放大所需能量功率
inward_delay=1;     %一跳延迟为1ms
PR_dalay=2;         %一次PR延迟为2ms
Length=10;%表的长度
inform0=3;%通知阈值

%alive1=1;
die_node=0;
[M,TTL,All] = Proliferation_and_Note(node,id,realiability,r,All);

[directions,w]=seed_random_dispersity2(node,id,M,60);%下一跳集合与w
        k=find(directions~=0);
        l=length(k);
        
        if l>M
            l=M;
        end
        
       if id==data_id 
           if node(id).ring==1
               node(id).receive=[node(id).receive,id];
           else
           for i=1:l
           node(id).receive=[node(id).receive,id];
           end
           end
       end
       
       L=[];%用以记录本地Data空位
       for k=1:length(node(id).Data)
           if node(id).Data(k).ID==0
               L=[L,k];
               if length(L)==M
                   break;
               end
           end
       end
       
       if id==data_id %源节点感知数据
           for i=1:M     
            node(id).Data(L(i)).ID=data_id;
            node(id).Data(L(i)).start_time=Time;%注意源节点与再生节点区别
            node(id).Data(L(i)).num=i;
            node(id).Data(L(i)).PRs=M;
            node(id).Data(L(i)).delay=node(id).Data(L(i)).delay+PR_dalay;
            node(id).Data(L(i)).TTL=TTL;
            node(id).Data(L(i)).w=w;
          end
       else
           pos=0;%记录此数据包在Data中的位置
           for i=1:length(node(id).Data)
                if node(id).Data(i).ID==data_id && node(id).Data(i).TTL==0
                    pos=i;
                    break;
                end
           end
           %*********将复制产生的数据包存放在本地**********
                   for i=1:M
                       id
                       i
                        node(id).Data(L(i)).ID=data_id;
                        node(id).Data(L(i)).start_time=Time;%有更改，
                        node(id).Data(L(i)).num=i;
                        node(id).Data(L(i)).PRs=M;
                        node(id).Data(L(i)).delay=node(id).Data(pos).delay+PR_dalay;
                        node(id).Data(L(i)).TTL=TTL;
                        node(id).Data(L(i)).w=w;
                   end
      
       end %if id==data_id
       
%现在开始发送(将刚刚生成的数据包扩散出去)
    j=0;
for i=1:M
    if node(id).Data(L(i)).start_time>Time
        continue;
    end
    [rand_num]=reliability_rand;
   % rand_num=1;
    if node(id).ring~=1
        if isempty(directions)
            break;
        end
        if i>length(directions)
            length(directions)
            receive_id=directions(length(directions));
        else
            receive_id=directions(i);
        end
    else
        receive_id=N+1;
    end
    if receive_id==0 %此时在此范围没有邻居节点
        %清空本地记录
                node(id).Data(L(i)).ID=0;
                node(id).Data(L(i)).start_time=0;
                node(id).Data(L(i)).num=0;
                node(id).Data(L(i)).PRs=0;
                node(id).Data(L(i)).delay=0;
                node(id).Data(L(i)).TTL=0;
                node(id).Data(L(i)).w=1;
        a=find(node(id).receive==data_id);   
        if ~isempty(a)
           node(id).receive(a(1))=[]; 
        end
        continue;
    end
   if rand_num==1 && node(id).re_energy>0 && node(receive_id).re_energy>0%满足可靠性且收发节点两端能量足够，则发送成功
       %*********1、更新成功发送的数据包信息，2、将其存入接收节点************
       [node,alive1,die_node] = calculate_energy(node,id,receive_id,alive1,die_node);%计算收发两端能量
       node(id).Data(L(i)).delay=node(id).Data(L(i)).delay+inward_delay;%更新延迟
       node(id).Data(L(i)).start_time=Time+inward_delay;
       node(id).Data(L(i)).TTL=node(id).Data(L(i)).TTL-1;%更新TTL
       node(id).Data(L(i)).w=node(id).Data(L(i)).w-1;%更新w
    %*********在接收节点的数据包储存数组中找空位，避免覆盖其他数据包*********
       for k=1:length(node(receive_id).Data)
        if node(receive_id).Data(k).ID==0
             j=k;
             break;
        end
       end
    %*********************************************************************
      % node(receive_id).Data(j)= node(id).Data(L(i));
       node(receive_id).Data(j)=node(id).Data(L(i));  %将本地数据赋值给接收节点
       node(receive_id).receive=[node(receive_id).receive,data_id];%receive中记录一下
       %******向hotspots区域节点的表中添加数据***********
       if receive_id~=N+1
       if ((node(receive_id).ring==1)||(node(receive_id).ring==2)||(node(receive_id).ring==3))
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
       if insert_pos1~=0 %表中存在相同ID的记录，直接更新历史记录即可
           node(receive_id).pass(insert_pos1).copies=node(receive_id).pass(insert_pos1).copies+1;
           node(receive_id).pass(insert_pos1).gap_time=-1;
       elseif is_full==0 %表中不存在相同ID的记录，在insert_pos2处插入记录
           node(receive_id).pass(insert_pos2).id=data_id;
           node(receive_id).pass(insert_pos2).copies=1;
           node(receive_id).pass(insert_pos2).gap_time=-1;
       end
       %在此处添加函数通知表内邻居
       if insert_pos1~=0
           node(receive_id).pass(insert_pos1).copies    %此句的作用是为了看变量值
       if node(receive_id).pass(insert_pos1).copies >inform0   
         [node,messages]=inform_table_member(node,receive_id,data_id,messages);
       end
       end
       end
       end
            %清空发送节点本地记录
                node(id).Data(L(i)).ID=0;
                node(id).Data(L(i)).start_time=0;
                node(id).Data(L(i)).num=0;
                node(id).Data(L(i)).PRs=0;
                node(id).Data(L(i)).delay=0;
                node(id).Data(L(i)).TTL=0;
                node(id).Data(L(i)).w=1;
       %***********************
   else %发送失败
       [node,alive1,die_node] = compute_energy(node,id,receive_id,alive1,die_node);%计算发送端能量
       %清空发送节点本地记录
                node(id).Data(L(i)).ID=0;
                node(id).Data(L(i)).start_time=0;
                node(id).Data(L(i)).num=0;
                node(id).Data(L(i)).PRs=0;
                node(id).Data(L(i)).delay=0;
                node(id).Data(L(i)).TTL=0;
                node(id).Data(L(i)).w=1;
   end
      
end    

end