function [x, z, aviobj] = animation(poly, xstart, zstart, aviobj)

global hp
%% Animation
figure(20);
 
Ds=2;%Ds is the scale
xmin=-1*Ds; xmax=1*Ds;	%intervals along abscissa 
ymin=-0.1*Ds; ymax=1.9*Ds; 				% and ordinate axes
x0=[-Ds,Ds];yy0=[0,0];              % ground on which biped walks
   
h1=plot(x0,yy0,'k','LineWidth',1);hold on
[xj,zj]=draw10(poly(:,1),xstart,zstart);

h=plot(xj(1,:),zj(1,:),'-r',xj(2,:),zj(2,:),'-r',xj(3,:),zj(3,:),'-b',xj(4,:),zj(4,:),'-b',xj(5,:),zj(5,:),'-k',xj(6,:),zj(6,:),'-b',...
           xj(7,:),zj(7,:),'-b',xj(8,:),zj(8,:),'-r',xj(9,:),zj(9,:),'-r',xj(10,:),zj(10,:),'-r',xj(11,:),zj(11,:),'-r',xj(12,:),zj(12,:),'-r',...
           xj(13,:),zj(13,:),'-b',xj(14,:),zj(14,:),'-b',xj(15,:),zj(15,:),'-b', xj(9,2), zj(9,2), 'or');

hold on
axis([xmin,xmax,ymin,ymax]);
axis on;
m = size(poly);
set(h,'LineWidth',1);

for j=1:1:m(2)
    [xj,zj]=draw10(poly(:,j)', xstart, zstart); 

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
    if(nargin == 4)
    F = getframe(20);
    aviobj = addframe(aviobj,F);
    end
end
x = xj(4,2);
z = zj(4,2)-hp;

end
