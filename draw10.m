function [Yj,Xj]=draw10(qj,x0,z0)

global L1 L2 L3 L4 L5 L6 L7 L8 L9 s7 s9 sb s8 s6 st hp lp ld lg spx spy

qp0=0;q0=0;
Dnb = max(size(qj));
q1 = qj(1);
q2 = qj(2);
q3 = qj(3);
q4 = qj(4);
q5 = qj(5);
q6 = qj(10);
q7 = qj(6);
q8 = qj(7);
q9 = qj(8);
q10 = qj(9);

% Perpendicular line from ankle to foot sole(Stance foot)
y1=[0,x0];
x1=[0,z0+hp];
% Shin of Stance foot
y2=[y1(2),y1(2)-L1*sin(q1)];
x2=[x1(2),x1(2)+L1*cos(q1)];
% Thigh of Stance foot
y3=[y2(2),y2(2)-L2*sin(q2)];
x3=[x2(2),x2(2)+L2*cos(q2)];
% Thigh of Swing foot
y4=[y3(2),y3(2)+L4*sin(q4)];
x4=[x3(2),x3(2)-L4*cos(q4)]; 
% Shin of Swing foot
y5=[y4(2),y4(2)+L5*sin(q5)];
x5=[x4(2),x4(2)-L5*cos(q5)];
% Trunk Segment(Torso to head)
y7=[y3(2),y3(2)-L3*sin(q3)];
x7=[x3(2),x3(2)+L3*cos(q3)];
% Upper arm 1
y8=[y3(2)-sb*sin(q3),y3(2)-sb*sin(q3)+L6*sin(q7)];% bras gauche
x8=[x3(2)+sb*cos(q3),x3(2)+sb*cos(q3)-L6*cos(q7)];   
% Fore arm 1
y9=[y8(2),y8(2)+L7*sin(q8)];
x9=[x8(2),x8(2)-L7*cos(q8)];
% Upper arm 2
y10=[y3(2)-sb*sin(q3),y3(2)-sb*sin(q3)+L8*sin(q9)];%bras droit
x10=[x3(2)+sb*cos(q3),x3(2)+sb*cos(q3)-L8*cos(q9)];   
% Fore arm 2
% NOTE: Phone is held by the end of this arm [i.e. x11(2), y11(2)].
y11=[y10(2),y10(2)+L9*sin(q10)];
x11=[x10(2),x10(2)-L9*cos(q10)];

yp_toe0 = [y1(2),y1(2)+hp*sin(q0)+ld*cos(q0)];xp_toe0 = [x1(2),x1(2)- hp*cos(q0)+ld*sin(q0)];
yp_heel0 = [y1(2),y1(2)+hp*sin(q0)-lg*cos(q0)];xp_heel0 = [x1(2),x1(2)- hp*cos(q0)-lg*sin(q0)];
yp_toe_heel0 =[yp_toe0(2),yp_heel0(2)];xp_toe_heel0 =[xp_toe0(2),xp_heel0(2)];

yp_toe6 = [y5(2),y5(2)+ hp*sin(q6)+ld*cos(q6)];xp_toe6 = [x5(2),x5(2)- hp*cos(q6)+ld*sin(q6)];
yp_heeL6 = [y5(2),y5(2)+ hp*sin(q6)-lg*cos(q6)];xp_heeL6 = [x5(2),x5(2)- hp*cos(q6)-lg*sin(q6)];
yp_toe_heeL6 =[yp_toe6(2),yp_heeL6(2)];xp_toe_heeL6 =[xp_toe6(2),xp_heeL6(2)];

Yj=[y2;y3;y4;y5;y7;y8;y9;y10;y11;yp_toe0;yp_heel0;yp_toe_heel0;yp_toe6;yp_heeL6;yp_toe_heeL6];
Xj=[x2;x3;x4;x5;x7;x8;x9;x10;x11;xp_toe0;xp_heel0;xp_toe_heel0;xp_toe6;xp_heeL6;xp_toe_heeL6];

return