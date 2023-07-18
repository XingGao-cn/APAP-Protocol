function [] = plot_circle(x,y,r)
theta=0:0.1:2*pi;
Circle1=x+r*cos(theta);
Circle2=y+r*sin(theta);
%c=[123,14,52];
c=[0.4660 0.6740 0.1880];
plot(Circle1,Circle2,'Color',c,'LineStyle','--','linewidth',1);
axis equal
end