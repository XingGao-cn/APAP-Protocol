function write_txt(nodee)

axis_x=[];
axis_y=[];
en=[]; 


for i=1:1000
    axis_x=[axis_x,nodee(i).x];
end

a=axis_x;

for i=1:1000
    axis_y=[axis_y,nodee(i).y];
end

b=axis_y;

for i=1:1000
    en=[en,3-nodee(i).re_energy];
end

c=en;

A=[a',b',c'];
fid=fopen('D:\博士阶段论文历程\论文4\20151030\1000个节点\20160108\程序3\me\R=350 N=1000.txt','wt');%改为你自己文件的位置  %  这个是我的方法

[m,n]=size(A);
for i=1:m
    for j=1:n
 if j==n
fprintf(fid,'%10g\n',A(i,j));
 else
fprintf(fid,'%10g\t',A(i,j)); 
 end
    end
end
fclose(fid)


% A=[];
% for i=1:1000
%      A=[A;node(i).x];%把每一个x都放到A里，成为一列
%    % y=[y,x(i)];%把每一个x都放到Y里，成为一行
% end
% 
% B=[];
% for i=1:1000
%      B=[B;node(i).y];%把每一个y都放到B里，成为一列
%    % y=[y,x(i)];%把每一个x都放到Y里，成为一行
% end
% 
% C=[];
% for i=1:1000
%      C=[C;3-node(i).re_energy];%把每一个re_energy都放到C里，成为一列
%    % y=[y,x(i)];%把每一个x都放到Y里，成为一行
% end
% 
% %  x=A(:,1);   %让x等于矩阵A的第一列
% %  y=B(:,1);
% %  z=C(:,1);
% % 
% % figure,scatter3(x,y,z)%散点图
% figure,[X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');
% %插值
% % pcolor(X,Y,Z);shading interp%伪彩色图
% figure,contourf(X,Y,Z) %等高线图
% figure,surf(X,Y,Z);%三维曲面

