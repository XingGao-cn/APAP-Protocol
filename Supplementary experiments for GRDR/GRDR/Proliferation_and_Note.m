%此函数根据当前节点距离、单跳可靠性根据公式确定M与TTL 
function [M,TTL,All] = Proliferation_and_Note(node,id,realiability,r,All)
%r为传输半径。
%在GRDR中，初始数据包份数放在M(1),再生份数放在M(2)
%global All;
R=200;%网路半径
q=2;%公差
Q=[];
Q1=[];
Q1(1)=1;
max=4;
for i=1:20
    Q(i)=q^(i-1);
    if i>1
       Q1(i)=Q(i-1)+Q(i); 
    end
end

M=zeros(2);
TTL=[];
 [~,y2] = PRs_successful_ratio(20,realiability);
% if node(id).ring==1
%     TTL=1;
%     M=1;
% else
%     TTL=ceil(y1(M));
% end
%***********************
% if node(id).ring==1
%     TTL=1;
%     M(1)=1;
%     M(2)=1;
% else
%     k=log(node(id).dis/r)/log(q);
%     ttl=ceil(k);
%     M(1)=y2(ttl);
%    
%      if r<node(id).dis && node(id).dis<r+q*r
%             TTL=(r+q*r)/r;
%             M(2)=y2(TTL);
%         elseif  r+q*r<node(id).dis && node(id).dis<r+q*r+q^2*r
%             TTL=(r+q*r+q^2*r)/r;
%             M(2)=y2(TTL);
%         else
%             TTL=(r+q*r+q^2*r+q^3*r)/r;
%             M(2)=y2(TTL);
%      end
%     
% end
%*******************************
if node(id).ring==1
    TTL(1)=1;%初始化
    TTL(2)=1;%再生
    M(1)=1;
    M(2)=1;
else
    %k=log(node(id).dis/r)/log(q);
    k=node(id).dis/r;
    TTL(1)=ceil(k);
    M(1)=y2(TTL(1));
    All=All+M(1);
    A=[];
    A=find(Q1>=k)
    n=A(1)
    Q(n)
    Q1(n)
    if Q1(n)>max
       TTL(2)=Q(n-1)+1
       M(2)=y2(TTL(2))
    else
        TTL(2)=Q(n)
        M(2)=y2(TTL(2))
    end
    
end
      

%**********************
%     if node(id).ring==1
%         TTL=1;
%         M=1;
%     else
%         TTL=floor(node(id).dis/r);
%         M=ceil(y2(TTL));
%***********************************
%     if node(id).ring==1
%         TTL=1;
%         M=1;
%     else
%         if r<node(id).dis && node(id).dis<r+q*r
%             TTL=node(id).ring;
%             M=3;
%         elseif  r+q*r<node(id).dis && node(id).dis<r+q*r+q^2*r
%             TTL=node(id).ring;
%             M=5;
%         else
%             TTL=node(id).ring;
%             M=6;
%         end
%     end


end






