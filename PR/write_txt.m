function write_txt(nodee,N,initial_value)
%绘制三维图
axis_x=[];
axis_y=[];
en=[]; 
cost=[];
datas=[];

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
    cost=[cost,nodee(i).re_energy];%剩余能量
    datas=[datas,length(nodee(i).receive)];%数据承载量
end
    
c=en;%数据选项
r=cost;

A=[a',b',c'];
fid=fopen('..\Data statistics code(part)\三维图数据集.txt','wt');%改为你自己文件的位置  %  这个是我的方法

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
     A=[A;nodee(i).x];%把每一个x都放到A里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

B=[];
for i=1:N
     B=[B;nodee(i).y];%把每一个y都放到B里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

C=[];
for i=1:N
     C=[C;initial_value-nodee(i).re_energy];%把每一个re_energy都放到C里，成为一列
   % y=[y,x(i)];%把每一个x都放到Y里，成为一行
end

%  x=A(:,1);   %让x等于矩阵A的第一列
%  y=B(:,1);
%  z=C(:,1);
% 
% figure,scatter3(x,y,z)%散点图
%**************************************
[xx,yy]=meshgrid(min(a):1:max(a),min(b):1:max(b));
%zz=griddata(x,y,z,xx,yy,'linear' );
zz=griddata(a,b,c,xx,yy,'cubic' );
%zz=griddata(a,b,c,xx,yy,'v4' );
index=zz<0;
zz(index)=0;
%zz=griddata(x,y,z,xx,yy,'nearest' );
%zz=griddata(x,y,z,xx,yy,'v4' );
cc=gradient(zz);
figure
meshz(xx,yy,zz,cc);shading interp%伪彩色图
zlabel('Energy Consumption(J)')
hold on;
%**************************
figure
meshc(xx,yy,zz);shading interp%伪彩色图
zlabel('Energy Consumption(J)')

figure
surfc(xx,yy,zz);shading interp%伪彩色图
zlabel('Energy Consumption(J)')

% figure
% surfl(xx,yy,zz);shading interp%伪彩色图
% zlabel('surfl(X,Y,Z)','color','r')


 print(gcf, '-dtiffnocompression',  '..\Data statistics code(part)\outpufilename.tif',  '-r300'); %把图片直接打印输出.tif格式


%*************************************
% %figure,[X,Y,Z]=griddata(a,b,c,linspace(min(a),max(a))',linspace(min(b),max(b)),'v4');
% %插值
% figure
% pcolor(xx,yy,zz);shading interp%伪彩色图
% 
% %figure
% figure,contourf(xx,yy,zz) %等高线图
% %figure
% figure,surf(xx,yy,zz);%三维曲面

