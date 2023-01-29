function [node,messages]=inform_table_member(node,id,Data_id,messages)
%此函数用以将信息告知表成员,id为本地id，Data_id为所需要传递的消息id
%此函数用在pass中发送数据增加时
member_id=0;
flag=0;
L=20;%表的长度
for i=1:length(node(id).table_member)
    if i==0
        break;
    end
    
    member_id=node(id).table_member(i);
               is_full=1;%0代表表未满，1代表表中记录已满
               insert_pos1=0;%用来记录历史记录的位置
               insert_pos2=0;%用来记录表中可插入的位置
               
       for Len=1:L
           if node(member_id).pass(Len).id==Data_id  %表中存在历史记录
               insert_pos1=Len;
               break;
           end
           if node(member_id).pass(Len).id==0 %表未满
               insert_pos2=Len;
               is_full=0;
           end           
       end
       
       if insert_pos1~=0 %直接更新历史记录即可
           node(member_id).pass(insert_pos1).copies=node(member_id).pass(insert_pos1).copies+1;
           node(member_id).pass(insert_pos1).gap_time=-1;
           
       elseif is_full==0 %在insert_pos2处插入记录
           node(member_id).pass(insert_pos2).id=Data_id;
           node(member_id).pass(insert_pos2).copies=1;
           node(member_id).pass(insert_pos2).gap_time=-1;
       end    
       
       %计算消息通知的能量消耗
       x1=node(id).x;                                %发送端节点的x坐标
       x2=node(member_id).x;                         %接收端节点的x坐标
       
       y1=node(id).y;                                %发送端节点的y坐标
       y2=node(member_id).y;                         %接收端节点的y坐标
       
       distance=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
       [node,messages]=inform_energy_consume(node,id,member_id,distance,messages);      
end

               