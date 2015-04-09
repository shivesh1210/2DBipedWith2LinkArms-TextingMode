function [x] = animation2(poly, xstart)

cd ..
%% Animation
figure(20);
 
Ds=1.5;%Ds is the scale
xmin=-1*Ds; xmax=1*Ds;	%intervals along absciss 
ymin=-0.1*Ds; ymax=1.9*Ds; 				%and ordinate axes
x0=[-0.8*Ds,0.8*Ds];yy0=[0,0];              %le sol
   
h1=plot(x0,yy0,'k','LineWidth',1);hold on
[xj,zj]=draw10(poly(:,1),xstart);

h=plot(xj(1,:),zj(1,:),'-b',xj(2,:),zj(2,:),'-b',xj(3,:),zj(3,:),'-r',xj(4,:),zj(4,:),'-r',xj(5,:),zj(5,:),'-k',xj(6,:),zj(6,:),'-r',...
           xj(7,:),zj(7,:),'-b',xj(8,:),zj(8,:),'-b',xj(9,:),zj(9,:),'-b',xj(10,:),zj(10,:),'-b',xj(11,:),zj(11,:),'-b',xj(12,:),zj(12,:),'-b',...
           xj(13,:),zj(13,:),'-r',xj(14,:),zj(14,:),'-r',xj(15,:),zj(15,:),'-r', xj(9,2), zj(9,2), 'ob');

hold on
axis([xmin,xmax,ymin,ymax]);
axis on;

set(h,'LineWidth',1);
for j=1:1:max(size(poly))
    [xj,zj]=draw10(poly(:,1)', xstart); 

    set(h(1),'XData',xj(1,:),'YData',zj(1,:));
    set(h(2),'XData',xj(2,:),'YData',zj(2,:));
    set(h(3),'XData',xj(3,:),'YData',zj(3,:));
    set(h(4),'XData',xj(4,:),'YData',zj(4,:));
    set(h(5),'XData',xj(5,:),'YData',zj(5,:));
    set(h(6),'XData',xj(6,:),'YData',zj(6,:));
    set(h(7),'XData',xj(7,:),'YData',zj(7,:));
    set(h(8),'XData',xj(8,:),'YData',zj(8,:));
    set(h(9),'XData',xj(9,:),'YData',zj(9,:));
    set(h(10),'XData',xj(10,:),'YData',zj(10,:));
    set(h(11),'XData',xj(11,:),'YData',zj(11,:));
    set(h(12),'XData',xj(12,:),'YData',zj(12,:));
    set(h(13),'XData',xj(13,:),'YData',zj(13,:));
    set(h(14),'XData',xj(14,:),'YData',zj(14,:));
    set(h(15),'XData',xj(15,:),'YData',zj(15,:));     
    set(h(16),'XData',xj(9,2),'YData',zj(9,2));
    pause(0.05)
    
    xphone(j) = xj(9,2);
    zphone(j) = zj(9,2);
end
x = xj(4,2);
cd('Test');
end
