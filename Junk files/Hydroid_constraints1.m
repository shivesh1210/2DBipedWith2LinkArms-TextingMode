function [C, Ceq] = Hydroid_constraints(Optim_Parameters)
global poly polyp mu impactindex
global nb_articulations
global GAM degree T vec_T
global L1 L2 L4 L5 ld lp hp lg ZMPx R_Force R_Force_impact_foot2 R_Force_impact_foot1
global vfoot2_toe vfoot2_heel ZMPx_impact ZMPx_impact_int R_Force_y no_slipping
global Hip_fin_config FootX_fin
    
%% Define Torque and velocity constraints
Torque_max=[157;108;150;150;108;50;50;50;50;157];
bounds_qp = [246.4; 401; 154.7; 154.7; 401; 2000;2000;2000;2000;246.4].*degree;

lb_q = -[30;90;90;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing
ub_q =  [30;90;90;90;90;30;140;30;140;30].*degree; %position constraints to be followed during swing

lb_ZMPx_impact_int= ZMPx_impact_int - 0.9*ld;
ub_ZMPx_impact_int= -0.9*lg - ZMPx_impact_int;

lb_ZMPx_impact= ZMPx_impact - 0.9*ld;
ub_ZMPx_impact= -0.9*lg - ZMPx_impact;

lb_ZMPx= ZMPx - 0.9*ld;
ub_ZMPx= -0.9*lg - ZMPx;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ששש
%% Define Reaction Force constraints
% mu=0.75;
R_Force_y= R_Force(2,:)'; %Vertical Reaction force must be positive
c_R_Force_y=-R_Force_y;
no_slipping = mu*R_Force(2,:)'-abs(R_Force(1,:)');  %Rx<=mu*Ry
c_no_slipping=-no_slipping;
%% Swing foot heel and toe must not touch the ground during SSP
q1b=poly(1,1:impactindex)';
q2b=poly(2,1:impactindex)';
q4b=poly(4,1:impactindex)';
q5b=poly(5,1:impactindex)';
qp2b=poly(10,1:impactindex)';

xhb = 0-L1*sin(q1b)-L2*sin(q2b);
yhb = hp+L1*cos(q1b)+L2*cos(q2b);

% Swing toe and heel always remain above the ground
swing_toe_yb = -(yhb - L4*cos(q4b) - L5*cos(q5b) - hp*cos(qp2b) + ld*sin(qp2b));
swing_heel_yb = -(yhb - L4*cos(q4b) - L5*cos(q5b) - hp*cos(qp2b) - lg*sin(qp2b));
%to eliminate the first and last point of swing trajectory
diff=1; 
swing_toe_yb=swing_toe_yb(1+diff:end-diff)+0.001;
swing_heel_yb=swing_heel_yb(1+diff:end-diff)+0.001;

foot2 = [xhb  + L4*sin(q4b)+ L5*sin(q5b) + hp*sin(qp2b), yhb - L4*cos(q4b) - L5*cos(q5b)- hp*cos(qp2b)];
foot2_y_ini=abs(foot2(1,2))-1e-5;

% Change of support foot occurs

q1a=poly(1,impactindex:end)';
q2a=poly(2,impactindex:end)';
q4a=poly(4,impactindex:end)';
q5a=poly(5,impactindex:end)';
qp2a=poly(10,impactindex:end)';

xha = xhb(end) - L1*sin(q1a)-L2*sin(q2a);
yha = yhb(end) + L1*cos(q1a)+L2*cos(q2a);

% Swing toe and heel always remain above the ground
swing_toe_ya = -(yha - L4*cos(q4a) - L5*cos(q5a) - hp*cos(qp2a) + ld*sin(qp2a));
swing_heel_ya = -(yha - L4*cos(q4a) - L5*cos(q5a) - hp*cos(qp2a) - lg*sin(qp2a));
%to eliminate the first and last point of swing trajectory
diff=1; 
swing_toe_ya=swing_toe_ya(1+diff:end-diff)+0.001;
swing_heel_ya=swing_heel_ya(1+diff:end-diff)+0.001;

foot1 = [xha  + L4*sin(q4a)+ L5*sin(q5a) + hp*sin(qp2a), yha - L4*cos(q4a) - L5*cos(q5a)- hp*cos(qp2a)];
foot1_y_ini=abs(foot1(1,2))-1e-5;

% Before impact
R_Knee_Bending_bi = poly(1,1:impactindex)' - poly(2,1:impactindex)';  %the knee must not bend in the backward direction
L_Knee_Bending_bi = poly(5,1:impactindex)' - poly(4,1:impactindex)';
R_Arm_Bending_bi = poly(6,1:impactindex)' - poly(7,1:impactindex)';  %the knee must not bend in the backward direction
L_Arm_Bending_bi = poly(8,1:impactindex)' - poly(9,1:impactindex)';
% After impact
R_Knee_Bending_ai = poly(5,impactindex:end)' - poly(4,impactindex:end)';  %the knee must not bend in the backward direction
L_Knee_Bending_ai = poly(1,impactindex:end)' - poly(2,impactindex:end)';
R_Arm_Bending_ai = poly(8,impactindex:end)' - poly(9,impactindex:end)';  %the knee must not bend in the backward direction
L_Arm_Bending_ai = poly(6,impactindex:end)' - poly(7,impactindex:end)';
%%
tita=70*degree;
C_tita_bi=[abs(R_Arm_Bending_bi)-tita;abs(L_Arm_Bending_bi)-tita];
C_tita_ai=[abs(R_Arm_Bending_ai)-tita;abs(L_Arm_Bending_ai)-tita];

% q1=poly(1,:)';
% q2=poly(2,:)';
% q4=poly(4,:)';
% q5=poly(5,:)';
% qp2=poly(10,:)';

% xh = 0-L1*sin(q1)-L2*sin(q2);
% yh = hp+L1*cos(q1)+L2*cos(q2);
% 
% swing_toe_y = -(yh - L4*cos(q4) - L5*cos(q5) - hp*cos(qp2) + ld*sin(qp2));
% swing_heel_y = -(yh - L4*cos(q4) - L5*cos(q5) - hp*cos(qp2) - lg*sin(qp2));
% 
% diff=1; %to eliminate the first and last point of swing trajectory
% swing_toe_y=swing_toe_y(1+diff:end-diff)+0.001;
% swing_heel_y=swing_heel_y(1+diff:end-diff)+0.001;
% 
% 
% % Hip_Height=yh-0.877;
% foot2 = [xh  + L4*sin(q4)+ L5*sin(q5) + hp*sin(qp2), yh - L4*cos(q4) - L5*cos(q5)- hp*cos(qp2)];
% foot2_y_ini=abs(foot2(1,2))-1e-5;
% % foot2_y_fin=-foot2(end,2)-1e-5;

%% Calculating Impact phase constraints
R_Force_impact_y1=-R_Force_impact_foot1(2,:)'; %Vertical Reaction force must be positive
no_slipping_impact1 = abs(R_Force_impact_foot1(1,:)')-mu*R_Force_impact_foot1(2,:)';  %Rx<=mu*Ry the foot touching ground must not slip

R_Force_impact_y=-R_Force_impact_foot2(2,:)'; %Vertical Reaction force must be positive
no_slipping_impact = abs(R_Force_impact_foot2(1,:)')-mu*R_Force_impact_foot2(2,:)';  %Rx<=mu*Ry the foot touching ground must not slip
vfoot2=-[vfoot2_toe(2,1);vfoot2_heel(2,1)];  %The vertical velocity of swing foot just after impact must be possitive

%% Calculating SSP constraints
n=nb_articulations;
[mp,np]=size(poly);

mid_point=round(np/2);
poly_swing=poly(:,mid_point-1:mid_point+1);
max_height=0.020; %swing height at mid point
Swing_Height_int=(hp + L1*cos(poly_swing(1,:)) + L2*cos(poly_swing(2,:)) - L4*cos(poly_swing(4,:)) - L5*cos(poly_swing(5,:)) - hp*cos(poly_swing(10,:)));
lb_Swing_Height_int=max_height-Swing_Height_int';

rel_poly=Convert_to_qr(poly);
rel_polyp=Convert_to_qr(polyp);

c_tor=zeros(n*np,1);
c_qp=c_tor;
c_lq=c_tor;
c_uq=c_tor;

for k=1:np
    c_tor((k*n-9):k*n)=abs(GAM(:,k))-Torque_max;
    c_qp((k*n-9):k*n)=abs(rel_polyp(:,k))-bounds_qp;
    c_lq((k*n-9):k*n)=lb_q-rel_poly(:,k);
    c_uq((k*n-9):k*n)=rel_poly(:,k)-ub_q;
end
  
C=[c_tor; c_qp; c_lq; c_uq; swing_toe_yb; swing_toe_ya; foot2_y_ini; foot1_y_ini; swing_heel_yb; swing_heel_ya;...
     lb_ZMPx; ub_ZMPx; lb_ZMPx_impact; ub_ZMPx_impact; lb_ZMPx_impact_int; ub_ZMPx_impact_int; c_R_Force_y;...
     R_Force_impact_y; no_slipping_impact; R_Force_impact_y1; no_slipping_impact1; c_no_slipping; vfoot2;...
     R_Knee_Bending_bi; L_Knee_Bending_bi;R_Arm_Bending_bi;L_Arm_Bending_bi;R_Knee_Bending_ai; L_Knee_Bending_ai;R_Arm_Bending_ai;L_Arm_Bending_ai;lb_Swing_Height_int;C_tita_bi;C_tita_ai];
 
 Ceq=[];
return