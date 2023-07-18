A=load ('..\Matlab-based simulation code\The simulation result of PR\三维图数据集.txt');


 
 %A=load ('C:\MATLAB7\work\reulst.txt');  
 x=A(:,1);   %让x等于矩阵A的第一列
 y=A(:,2);
 z=A(:,3);
 
 [xx,yy]=meshgrid(min(x):1:max(x),min(y):1:max(y));
%zz=griddata(x,y,z,xx,yy,'linear' );
zz=griddata(x,y,z,xx,yy,'cubic' );
%zz=griddata(x,y,z,xx,yy,'nearest' );
%zz=griddata(x,y,z,xx,yy,'v4' );
meshz(xx,yy,zz);
zlabel('Energy Consumption(J)')
%hold on;

% print(gcf, '-dtiffnocompression',  'C:\Users\MATE BOOK D15\Desktop\文章\完整实验\实验统计代码\outpufilename.tif',  '-r300'); %把图片直接打印输出.tif格式

%exportfig(gcf,  'C:\Users\MATE BOOK D15\Desktop\文章\完整实验\实验统计代码\outputFileName.eps','color', 'cmyk', 'FontMode', 'fixed', 'FontSize', 12, 'LineMode', 'fixed', 'LineWidth',1);%把图片直接打印输出.eps格式，调用exportfig.m文件