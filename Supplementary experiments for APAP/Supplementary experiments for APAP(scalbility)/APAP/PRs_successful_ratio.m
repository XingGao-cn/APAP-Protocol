    %此函数根据旧公式计算复制包份数（PR算法中只在源节点处计算一次）
function [y1,y2] = PRs_successful_ratio(M,reliability)
%给定复制份数与可靠性，求得TTL跳后数据包仍然存在的可能性
y=[];
syms x;
x=1:30;
y=1-(1-reliability.^x).^M;

%给网络可靠性与单跳结点可靠性，数据包复制M与数据包跳数TTL之间的关系
% y1=[];
% for i=1:0.1:M
%     y1=[y1,floor(log(1-(1-reliability)^(1/i))/log(reliability)+0.5)];
% end

y1=[];
for i=1:M
y1 = [y1,log(1-(1-reliability)^(1/i))/log(reliability)];
end


%给定单跳可靠性与TTL，求数据包复制份数
y2=[];
for TTL=1:30 
    y2=[y2,ceil(log(1-reliability)/log(1-reliability^TTL))];
end

% y2=[];
% for TTL=1:10 
% y2=[y2,log(1-reliability)/log(1-reliability^TTL)];
% end
end







