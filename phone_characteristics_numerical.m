% This file uses polynomial trajectory matrix for generating the position,
% velocity and acceleration characterstics of the handheld device. Every
% thing is represented in the absolute world frame i.e. (0,0)

global poly vec_T impactindex
global vec_T1 vec_T2

m = size(poly);
xstart = 0;
for j=1:1:impactindex
    [xj,zj]=draw10(poly(:,j)', xstart); 
    xphone(j) = xj(9,2);
    zphone(j) = zj(9,2);
    yheel(j) = zj(15,2);
    ytoe(j) = zj(15,1);
end

xstep1 = xj(4,2);

for j=impactindex+1:1:m(2)
    [xj,zj]=draw10(poly(:,j)', xstep1); 
    xphone(j) = xj(9,2);
    zphone(j) = zj(9,2);
    yheel(j) = zj(15,2);
    ytoe(j) = zj(15,1);
end

xstep2 = xj(4,2);

figure;
hold on
plot(vec_T, xphone, 'r');
plot(vec_T, zphone);
xlabel('Time(s)');
ylabel('Coordinates(X,Z) of phone in space(metres)');
title('Position of phone vs time');
legend('X','Z');

figure;
hold on
% h = vec_T(2)-vec_T(1);
% dxphone = diff(xphone)/h;
% dzphone = diff(zphone)/h;
h1 = diff(vec_T1);
h2 = diff(vec_T2);
dxphone1 = diff(xphone(1:impactindex))./h1;
dxphone2 = diff(xphone(impactindex+1:end))./h2;
dxphone = [dxphone1 dxphone2];
dzphone1 = diff(zphone(1:impactindex))./h1;
dzphone2 = diff(zphone(impactindex+1:end))./h2;
dzphone = [dzphone1 dzphone2];
vel = sqrt(dxphone.^2 + dzphone.^2);
plot(vec_T(1:length(dxphone)), dxphone, 'r');
plot(vec_T(1:length(dzphone)), dzphone);
plot(vec_T(1:length(dzphone)), vel, 'g');
xlabel('Time(s)');
ylabel('Velocity(X,Z) of phone in space(m/s)');
title('Velocity of phone vs time');
legend('vx','vz','v');

figure;
hold on
% ddxphone = diff(dxphone)/h;
% ddzphone = diff(dzphone)/h;
ddxphone1 = diff(dxphone1)./h1(1:end-1);
ddxphone2 = diff(dxphone2)./h2(1:end-1);
ddxphone = [ddxphone1 ddxphone2];
ddzphone1 = diff(dzphone1)./h1(1:end-1);
ddzphone2 = diff(dzphone2)./h2(1:end-1);
ddzphone = [ddzphone1 ddzphone2];
accn = sqrt(ddxphone.^2 + ddzphone.^2);
plot(vec_T(1:length(ddxphone)), ddxphone, 'r');
plot(vec_T(1:length(ddzphone)), ddzphone);
plot(vec_T(1:length(ddzphone)), accn, 'g');
xlabel('Time(s)');
ylabel('Acceleration(X,Z) of phone in space(m/s^2)');
title('Acceleration of phone vs time');
legend('ax','az', 'a');

% figure;
% pwelch(accn);

figure;
hold on
plot(vec_T,ytoe);
plot(vec_T,yheel,'r');