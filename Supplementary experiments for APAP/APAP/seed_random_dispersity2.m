%Random dispersity2此文件为随机分离算法2  记住，w还未讨论
function [directions,w]=seed_random_dispersity2(node,ID,M,~)
%ID为中继节点号，M为种子分离份数,a是两极化后的旋转角度取值(0~pi/2)
%r = a + (b-a).*rand(N,1) 生成区间 (a,b) 内的 N 个随机数。
   % r=(2*pi).*rand(M,1);
   % r=r./pi
   %r=2*rand(1,M);
%***********极化法*************   
r1_id=0;
r2_id=0;
   %暂定w=1
   w=1;
  % times=ceil(M/2);
   directions=[];%用以记录n份数据包的下一跳方向，即邻居节点ID
   A=[];%ri的随机邻居集合
   B=[];%r2的随机邻居集合
    for i=1:length(node(ID).neighbors)
       Id=node(ID).neighbors(i).id;
       if node(Id).dis<node(ID).dis
           directions=[directions,Id];
           if length(directions)>=M
               break;
           end
       end
   end
   if length(directions)<M
      for i=1:M
          directions=[directions,directions];
      end
   end
   %***************************************
% %   randi([1,LA],1,1)
%    rad=node(ID).rad;
%    
%    if 0<=rad&&rad<=pi/2%第一象限
%       %d=1
%        for i=1:length(node(ID).neighbors)
%            Rad=node(ID).neighbors(i).rad;
%           if  (-pi<=Rad && Rad<=-1/4*pi) || (3/4*pi<=Rad && Rad<=pi)
%                A=[A,node(ID).neighbors(i).id];
%           end
%        end
%    elseif pi/2<=rad&&rad<=pi %第二象限
%       % d=2
%        for i=1:length(node(ID).neighbors)
%            Rad=node(ID).neighbors(i).rad;
%           if  (0<=Rad && Rad<=1/4*pi) || (-3/4*pi<=Rad && Rad<=0)
%                A=[A,node(ID).neighbors(i).id];
%           end
%        end
%    elseif -pi<=rad&&rad<=-1/2*pi %第三象限
%        %d=3
%        for i=1:length(node(ID).neighbors)
%            Rad=node(ID).neighbors(i).rad;
%           if  (0<=Rad && Rad<=3/4*pi) || (-1/4*pi<=Rad && Rad<=0)
%                A=[A,node(ID).neighbors(i).id];
%           end
%        end
%    else %第四象限
%        %d=4
%        for i=1:length(node(ID).neighbors)
%            Rad=node(ID).neighbors(i).rad;
%          if  (1/4*pi<=Rad && Rad<=pi) || (-pi<=Rad && Rad<=-3/4*pi)
%                A=[A,node(ID).neighbors(i).id];
%          end
%        end
%    end 
%    directions=A;
%     if length(directions)<M
%       for i=1:M
%           directions=[directions,directions];
%       end
%     end
%     if isempty(directions) 
%            for i=1:length(node(ID).neighbors)
%        Id=node(ID).neighbors(i).id;
%        if node(Id).dis<node(ID).dis
%            directions=[directions,Id];
%            if length(directions)>=M
%                break;
%            end
%        end
%            end
%          if length(directions)<M
%               for i=1:M
%                     directions=[directions,directions];
%               end
%         end 
%         
%     end
%    
   
%    for i=1:times
%       r1=pi.*rand(1,1); 
%       %角度区间上下界
%       Hi_r1_1=0;Hi_r2_1=0;Low_r1_1=0;Low_r2_1=0;
%       Hi_r1_2=0;Hi_r2_2=0;Low_r1_2=0;Low_r2_2=0;
%       if r1>0 %通过r1得出r2
%           r2=r1-a;
%       else
%           r2=r1+a;
%       end
%             if r1<0  %根据r1的值，找出顺时针+a的两个区间内的邻居节点.
%                  if r1-a >=-pi
%                      Low_r1_1=ri-a;
%                      Hi_r1_1=ri;
%                      %***********
%                      Low_r2_1=r2-a;
%                      Hi_r2_1=r2;
%                  elseif  ri-a<-pi
%                      Low_r1_1=-pi;
%                      Hi_r1_1=ri;
%                      Low_r1_2=pi+r1+a;
%                      Hi_r1_2=pi;
%                      %**********
%                      Low_r2_1=0;
%                      Hi_r2_1=r2;
%                      Low_r2_2=r2-a;
%                      Hi_r2_2=0;
%                  end
%             elseif r1>0
%                  if r1-a>=0
%                     Low_r1_1=r1-a;
%                     Hi_r1_1=r1;
%                     %***********
%                     Low_r2_1=r2-a;
%                     Hi_r2_1=r2; 
%                  elseif  r1-a<0
%                     Low_r1_1=0;
%                     Hi_r1_1=r1;
%                     Low_r1_2=r1-a;
%                     Hi_r1_2=0;
%                     %**********
%                     Low_r2_1=pi+r2+a;
%                     Hi_r2_1=pi;
%                     Low_r2_2=-pi;
%                     Hi_r2_2=r2;
%                  end
%             elseif r1==0
%                     Low_r1_1=-a;
%                     Hi_r1_1=0;
%                     %***********
%                     Low_r2_1=pi-a;
%                     Hi_r2_1=pi;
%             end
%                    for j=1:length(node(ID).neighbors)
%                        if (Low_r1_1<node(ID).neighbors(j).rad&&node(ID).neighbors(j).rad<Hi_r1_1)||(Low_r1_2<node(ID).neighbors(j).rad&&node(ID).neighbors(j).rad<Hi_r1_2)
%                            A=[A,node(ID).neighbors(j).id];
%                        end
%                        if (Low_r2_1<node(ID).neighbors(j).rad&&node(ID).neighbors(j).rad<Hi_r2_1)||(Low_r2_2<node(ID).neighbors(j).rad&&node(ID).neighbors(j).rad<Hi_r2_2)
%                            B=[B,node(ID).neighbors(j).id];
%                        end
%                    end
%                    LA=length(A);
%                    LB=length(B);
%                    
%                    if LA==0
%                        r1_id=0;
%                    else
%                        r1_id=A(randi([1,LA],1,1));                     
%                    end
%                                       
%                    if LB==0
%                        r2_id=0;
%                    else
%                        r2_id=B(randi([1,LB],1,1));
%                    end
% 
%                    directions=[directions,r1_id,r2_id];
%                    A=[];%清空A、B集合
%                    B=[];
%    end
end



