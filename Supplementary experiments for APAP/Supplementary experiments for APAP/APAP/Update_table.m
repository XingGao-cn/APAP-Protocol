function [node]=Update_table(node,circle_n,interval)
%This fuction is used for manage the passed traffic and update the record
%此函数用于更新管理pass,如果出现长时间未更新的数据，即：当pass.gap_time>interval时，删去该记录
%interval=2

for i=1:length(circle_n)
    id=circle_n(i);       
    for j=1:length(node(id).pass) %更新数据存在时间
        node(id).pass(j).gap_time=node(id).pass(j).gap_time+1;
       if node(id).pass(j).gap_time>=interval %数据超过一定时间未更新，删除之
           node(id).pass(j).id=0;
           node(id).pass(j).copies=0;
           node(id).pass(j).gap_time=0;
       end
    end
    
end