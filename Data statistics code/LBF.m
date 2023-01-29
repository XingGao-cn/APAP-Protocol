clear,clc
addpath 'C:\Users\MATE BOOK D15\Desktop\文章\完整实验\PR';
addpath 'C:\Users\MATE BOOK D15\Desktop\文章\完整实验\GRDR';
addpath 'C:\Users\MATE BOOK D15\Desktop\文章\完整实验\分布式的实验';

LBF_plot1
LBF_plot2
LBF_plot3
x=1:8;
figure
plot(x,LBF1,'-^',x,LBF2,'-d',x,LBF3,'-o')
xlabel("The serial number of ring")
ylabel("LBF(Load Balance Factor)")
legend('The APAP scheme of this paper','The GRDR scheme','The PR scheme')
