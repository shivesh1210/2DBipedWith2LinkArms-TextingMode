function [C, Ceq] = Hydroid_constraints(Optim_Parameters)
global poly polyp mu impactindex
global nb_articulations
global GAM degree Swing_Height_int
global L1 L2 L4 L5 ld lp hp lg ZMPx R_Force R_Force_impact_foot2
global vfoot2_toe vfoot2_heel ZMPx_impact R_Force_y no_slipping
global Hip_fin_config FootX_fin
global violation_percent flag1 flag2

Rel_matrix = zeros(nb_articulations, nb_articulations);
Rel_matrix(1,5) = 1;
Rel_matrix(2,4) = 1;
Rel_matrix(3,3) = 1;
Rel_matrix(4,2) = 1;
Rel_matrix(5,1) = 1;
Rel_matrix(6,6) = 1;
Rel_matrix(7,7) = 1;
Rel_matrix(8,8) = 1;
Rel_matrix(9,9) = 1;
Rel_matrix(10,10) = 1;
    
%% Define Torque and velocity constraints

Torque_max_bi=[157;108;150;150;108;50;50;50;50;157];
bounds_qp_bi = [246.4; 401; 154.7; 154.7; 401; 2000;2000;2000;2000;246.4].*degree;
lb_q_bi = -[30;90;12;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing
ub_q_bi =  [30;90;12;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing

Torque_max_ai = Rel_matrix*Torque_max_bi;
bounds_qp_ai = Rel_matrix*bounds_qp_bi;
lb_q_ai = Rel_matrix*lb_q_bi;
ub_q_ai = Rel_matrix*ub_q_bi;

% Torque_max=[157;108;150;150;108;50;50;50;50;157];
% bounds_qp = [246.4; 401; 154.7; 154.7; 401; 2000;2000;2000;2000;246.4].*degree;
% lb_q = -[30;90;90;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing
% ub_q =  [30;90;90;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing

R_Knee_Bending= poly(1,:)' - poly(2,:)';  %the knee must not bend in the backward direction
L_Knee_Bending= poly(5,:)' - poly(4,:)';
R_Arm_Bending= poly(6,:)' - poly(7,:)';  %the knee must not bend in the backward direction
% L_Arm_Bending= poly(8,:)' - poly(9,:)';

% The arm bending must not be greater than 70 degrees while walking.
theta=70*degree;
% C_tita=[abs(R_Arm_Bending)-theta;abs(L_Arm_Bending)-theta];
C_tita=abs(R_Arm_Bending)-theta;

%% Conditions on ZMPx during the two SSP and impacts
lb_ZMPx_impact= ZMPx_impact - 0.9*ld;
ub_ZMPx_impact= -0.9*lg - ZMPx_impact;

lb_ZMPx= ZMPx - 0.9*ld;
ub_ZMPx= -0.9*lg - ZMPx;

%% Define Reaction Force and no slipping constraints
% mu=0.75;
R_Force_y= R_Force(2,:)'; %Vertical Reaction force must be positive
c_R_Force_y=-R_Force_y;
no_slipping = mu*R_Force(2,:)'-abs(R_Force(1,:)');  %Rx<=mu*Ry
c_no_slipping=-no_slipping;

%% Swing foot heel and toe must not touch the ground during the two SSP

% NOTE: Knowing that the change of support foot during second step changes
% the local coordinate system in which the DGM equations of hip and
% subsequently swing toe and swing heel were written, we should consider
% different equations for the two steps. However, the local coordinate
% system changes only for abcissa part, y remains zero on the ground. Since
% we deal with height, there is no need to use another set of equations
% here. The results will not change because of relabeling present in the
% poly vector. It will only assist the calculation of swing toe and heel y
% coordinates. 

q1=poly(1,:)';
q2=poly(2,:)';
q4=poly(4,:)';
q5=poly(5,:)';
qp2=poly(10,:)';

% Ankle_Rotation=max(abs(qp2-q5))-30*degree;  %swing ankle can rotate 30 degrees max

xh = 0-L1*sin(q1)-L2*sin(q2);
yh = hp+L1*cos(q1)+L2*cos(q2);

swing_toe_y = -(yh - L4*cos(q4) - L5*cos(q5) - hp*cos(qp2) + ld*sin(qp2));
swing_heel_y = -(yh - L4*cos(q4) - L5*cos(q5) - hp*cos(qp2) - lg*sin(qp2));
%  figure;
%  hold on
%  plot(-swing_toe_y);
%  plot(-swing_heel_y,'r');

diff=1; %to eliminate the first and last point of swing trajectory
swing_toe_y=swing_toe_y(1+diff:end-diff)+0.001;
swing_heel_y=swing_heel_y(1+diff:end-diff)+0.001;

% Hip_Height=yh-0.877;
foot2 = [xh  + L4*sin(q4)+ L5*sin(q5) + hp*sin(qp2), yh - L4*cos(q4) - L5*cos(q5)- hp*cos(qp2)];
foot2_y_ini=abs(foot2(1,2))-1e-5;
% foot2_y_fin=-foot2(end,2)-1e-5;

%% Calculating Impact phase constraints
R_Force_impact_y=-R_Force_impact_foot2(2,:)'; %Vertical Reaction force must be positive
no_slipping_impact = abs(R_Force_impact_foot2(1,:)')-mu*R_Force_impact_foot2(2,:)';  %Rx<=mu*Ry the foot touching ground must not slip
vfoot2=-[vfoot2_toe(2,1);vfoot2_heel(2,1)];  %The vertical velocity of swing foot just after impact must be possitive

%% Calculating SSP constraints
n=nb_articulations;
[mp,np]=size(poly);

mid_point1 = round(impactindex/2);
mid_point2 = impactindex + round(impactindex/2);
poly_swing1=poly(:,mid_point1-1:mid_point1+1);
poly_swing2=poly(:,mid_point2-1:mid_point2+1);
max_height=0.010; %swing height at mid point
Swing_Height_int1=(hp + L1*cos(poly_swing1(1,:)) + L2*cos(poly_swing1(2,:)) - L4*cos(poly_swing1(4,:)) - L5*cos(poly_swing1(5,:)) - hp*cos(poly_swing1(10,:)));
Swing_Height_int2=(hp + L1*cos(poly_swing2(1,:)) + L2*cos(poly_swing2(2,:)) - L4*cos(poly_swing2(4,:)) - L5*cos(poly_swing2(5,:)) - hp*cos(poly_swing2(10,:)));
lb_Swing_Height_int1=max_height-Swing_Height_int1';
lb_Swing_Height_int2=max_height-Swing_Height_int2';
lb_Swing_Height_int = [lb_Swing_Height_int1; lb_Swing_Height_int2];

rel_poly=Convert_to_qr(poly);
rel_polyp=Convert_to_qr(polyp);

c_tor=zeros(n*np,1);
c_qp=c_tor;
c_lq=c_tor;
c_uq=c_tor;

for k=1:impactindex
    c_tor((k*n-9):k*n)=abs(GAM(:,k))-Torque_max_bi;
    c_qp((k*n-9):k*n)=abs(rel_polyp(:,k))-bounds_qp_bi;
    c_lq((k*n-9):k*n)=lb_q_bi-rel_poly(:,k);
    c_uq((k*n-9):k*n)=rel_poly(:,k)-ub_q_bi;
end
for k=impactindex:np
    c_tor((k*n-9):k*n)=abs(GAM(:,k))-Torque_max_ai;
    c_qp((k*n-9):k*n)=abs(rel_polyp(:,k))-bounds_qp_ai;
    c_lq((k*n-9):k*n)=lb_q_ai-rel_poly(:,k);
    c_uq((k*n-9):k*n)=rel_poly(:,k)-ub_q_ai;
end
% 
% for k=1:np
%     c_tor((k*n-9):k*n)=abs(GAM(:,k))-Torque_max;
%     c_qp((k*n-9):k*n)=abs(rel_polyp(:,k))-bounds_qp;
%     c_lq((k*n-9):k*n)=lb_q-rel_poly(:,k);
%     c_uq((k*n-9):k*n)=rel_poly(:,k)-ub_q;
% end

% C=[c_tor; c_qp; c_lq; c_uq; swing_toe_y; foot2_y_ini; swing_heel_y;...
%      lb_ZMPx; ub_ZMPx; lb_ZMPx_impact; ub_ZMPx_impact; c_R_Force_y;...
%      R_Force_impact_y; no_slipping_impact; c_no_slipping; vfoot2;...
%      R_Knee_Bending; L_Knee_Bending;R_Arm_Bending;L_Arm_Bending;lb_Swing_Height_int;C_tita];
% C= [];
 C=[c_tor; c_qp; c_lq; c_uq;R_Knee_Bending; L_Knee_Bending;R_Arm_Bending;C_tita; ...     % Technological and Bending constraints 
     lb_ZMPx; ub_ZMPx; lb_ZMPx_impact; ub_ZMPx_impact; ...      % ZMP constraints(normal and during impact)
     foot2_y_ini;swing_heel_y;swing_toe_y;lb_Swing_Height_int;...
     c_R_Force_y;c_no_slipping; R_Force_impact_y; no_slipping_impact;...   % Condition on reaction force and no slipping
     vfoot2];     
 violate = find(C>0);
 violation_percent = length(violate)*100/length(C);
 Ceq=[];
return