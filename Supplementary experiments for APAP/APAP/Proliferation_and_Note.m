%此函数根据当前节点距离、单跳可靠性根据公式确定M与TTL 
function [M,TTL,All] = Proliferation_and_Note(node,id,realiability,r,All)
%PR M==2
%PR  M==3
%PR M==4
%global All;
%hotspotNum=3;

TTL=inf;
[y1,y2] = PRs_successful_ratio(10,realiability);

if node(id).ring==1
    TTL=1;
    M=1;
else
    k=node(id).dis/r;
    %TTL=ceil(k);
    TTL=floor(k)
     
    
    M=y2(TTL);
    %compute the diff of the sequence 
y12=diff(y1);
y13=diff(y12);
y12=[0,y12];
y13=[0,0,y13];
S=ceil(y12+0.5);

%  y1 = floor(y1+0.5)
%  y2 = ceil(y2)

index=find(S<=1);
if ~isempty(index)
    ind=index(1);
end

tmp=M;
if tmp <= ceil(y2(ind))
    M = tmp;
else
    M = ceil(y2(ind)+exp(max(1,S(TTL))));
end
    All=All+M;

%added
 TTL=floor(y1(tmp));
    %************The adaptive packet regeneration**********************

%compute the diff of the sequence 
% y12=diff(y1);
% y13=diff(y12);
% y12=[0,y12];
% y13=[0,0,y13];
% S=floor(y12+0.5);
% 
%  y1 = floor(y1+0.5)
%  y2 = ceil(y2)
% 
% index=find(S==1);
% if ~isempty(index)
%     ind=index(1);
% end
% 
% tmp=M;
% if tmp <= ceil(y2(ind))
%     M = tmp;
% else
%     M = tmp+log(max(1,S(TTL)));
% end
% 
% end
%     All=All+M;

end
%***********************************


% se=unique(node(901).receive)
% rings=[]
%     rings = [rings,node(se).ring];
% q=[]
% for i=1:8
%     q=[q,length(find(rings==i))]
% end







