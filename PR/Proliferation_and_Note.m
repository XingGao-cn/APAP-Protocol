%此函数根据当前节点距离、单跳可靠性根据公式确定M与TTL 
function [M,TTL,All] = Proliferation_and_Note(node,id,realiability,~,All)
%PR M==2
%PR  M==3
%PR M==4
%global All; 
M=4;
TTL=inf;
[y1,~] = PRs_successful_ratio(10,realiability);
if node(id).ring==1
    TTL=1;
    M=1;
else
    TTL=ceil(y1(M));
    All=All+M;
end

end
%***********************************











