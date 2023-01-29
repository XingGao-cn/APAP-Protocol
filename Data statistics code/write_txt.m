function write_txt(nodee,N,initial_value)
%绘制三维图
axis_x=[];
axis_y=[];
en=[]; 


for i=1:N
    axis_x=[axis_x,nodee(i).x];
end

a=axis_x;

for i=1:N
    axis_y=[axis_y,nodee(i).y];
end

b=axis_y;

for i=1:N
    en=[en,initial_value-nodee(i).re_energy];%消耗能量
    cost=[re,nodee(i).re_energy];%剩余能量
    datas=[datas,length(nodee(i).receive)];%数据承载量
end
    
c=en;
r=cost;

A=[a',b',c'];
fid=fopen('C:\Users\MATE BOOK D15\Desktop\文章\完整实验\实验统计代码\三维图数据集.txt','wt');%改为你自己文件的位置  %  这个是我的方法

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
fclose(fid);


A=[];
for i=1:N
     A=[A;node(i).x];%把每一个x都放到A里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

B=[];
for i=1:N
     B=[B;node(i).y];%把每一个y都放到B里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

C=[];
for i=1:N
     C=[C;initial_value-node(i).re_energy];%把每一个re_energy都放到C里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

%  x=A(:,1);   %让x等于矩阵A的第一列
%  y=B(:,1);
%  z=C(:,1);
% 
% figure,scatter3(x,y,z)%散点图
figure,[X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');
%插值
% pcolor(X,Y,Z);shading interp%伪彩色图
figure,contourf(X,Y,Z) %等高线图
figure,surf(X,Y,Z);%三维曲面

