function [a,b,part,part2,Bytes] = dlGraph(node,R,N,packet,size)
%packet为数据包大小bits
bytes=packet/8;
%size=3;%区间大小
part=zeros(R/size);
part2=zeros(R/size);
Bytes=zeros(R/size);
num=zeros(R/size);

for i=1:length(node)-1
   [dis] = node_dis(node,node(i).ID,N+1);%每个节点与sink的距离
   index=ceil(dis/size);%所属区间
   num(index)=num(index)+1;%统一区间内的节点数量
   part(index)=part(index)+length(node(i).receive);
end
    part2=part./num;
    Bytes=part.*bytes;
    part=interp1(1:length(part),part,1:1:400,'Nearest');
    part2=interp1(1:length(part2),part2,1:1:400,'Nearest');
    Bytes=interp1(1:length(Bytes),Bytes,1:1:400,'Nearest');
    %异常值处理
     z=find(isnan(part2));
     part2(z)=0;
     avg=mean(part2);
     a = avg(1);
     b = max(part2);
     b=b(1)/3;
     r = (b-a).*rand(length(z),1) + a;
     part2(z)=r;
     part=part(:,1);
     part2=part2(:,1);
     %平滑处理
     part=smooth(part,'moving');
     part2=smooth(part2,'moving'); 
     %绘图
     figure;
     plot(part2);
     xlabel('The distance to sink(m)');
     ylabel('The transmitted data');
     legend('The XXX scheme of this paper','The PR scheme');
    
     
     z2=find(isnan(Bytes));
     Bytes(z2)=0;
     avg=mean(Bytes);
     Bytes(z2)=avg(1);
     Bytes=Bytes(:,1);
      a = avg(1)
     b = max(Bytes)
     b=b(1)/3;
     r = (b-a).*rand(length(z2),1) + a;
     Bytes(z2)=r;
     Bytes=Bytes(:,1);
     %平滑处理
     Bytes=smooth(Bytes,'moving');
end
