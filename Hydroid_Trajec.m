 function criteria = Hydroid_Trajec(Optim_Parameters)

global Hip_fin_config FootX_fin q_bras_fin Mo_Cin_CdM_z MC MC_pied inverse_MC_pied MC_Inverse
global poly polyp polypp T vec_T Tint
global GAM GAM2 Step_Length Step_Length_1 g L1 L2 L3 L4 L5 hp
global ZMPx R_Force
global Walk_Speed mc dom_tra impactindex q_ini Fy_swing R_Force_impact_foot2 ZMPx_impact dela_impact d_impact
global vfoot2_toe vfoot2_heel Energie_criteria MC_CdM_criteria inverse_pied Mc_pied
global flag1 flag2
global vec_T1 vec_T2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Assign Variables to respective optimization variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Hip_int_config = Optim_Parameters(1:3);
Ratio_Tint_to_T = Optim_Parameters(4);
HipY_fin = Optim_Parameters(5);
HipQ_fin = Optim_Parameters(6);
FootX_fin = Optim_Parameters(7);
q_bras_fin = Optim_Parameters(8:9);
q_bras_int = Optim_Parameters(10:11);
qp_int_minus = Optim_Parameters(12:19);
qp_fin = Optim_Parameters(20:27);

Step_Length=abs(FootX_fin);
T = Step_Length/Walk_Speed;

% Condition on arm position for Texting mode
q_bras_fin = [q_bras_fin; -0.27; pi/2]; 
q_bras_int = [q_bras_int; -0.27; pi/2]; 

% Condition on arm velocity for Texting mode
qp_int_minus = [qp_int_minus(1:7); 0; 0; qp_int_minus(8)]; 
qp_fin = [qp_fin(1:7); 0; 0; qp_fin(8)];

%% When the first impact occurs(Foot 2 strikes the ground)
Tint = Ratio_Tint_to_T*T;   % Time of first impact(1st step)
Step_Length_1 = Step_Length/2;  % Length of first step
FootX_int = Step_Length_1;      % FootX value at first impact

% Solving the IGM at first impact
[x_int, flag1] = MGI_Arnaud(Hip_int_config(1), Hip_int_config(2), FootX_int);
q_int = [x_int(1:2);Hip_int_config(3);x_int(3:4);q_bras_int;0];

% Impact Model(Foot 2 strikes the ground)
dq_int_minus = qp_int_minus; %the velocity just before impact to be optimised
q_dq_int = [q_int;dq_int_minus];
% [dq_int_plus, ZMPx_impact_int, R_Force_impact_foot2] = model_Impact_xy(q_dq_int);
[dq_int_plus, ZMPx_impact, R_Force_impact_foot2] = model_Impact_SS1(q_dq_int);

%% Support foot changes(from 1 to 2) i.e. Relabelling
q_int_plus = [flipud(q_int(1:5)); q_int(6:7); q_int(8:9); q_int(10)]; %Initial config for next step after change of role of feet
qp_int_plus = [flipud(dq_int_plus(1:5)); dq_int_plus(6:7); dq_int_plus(8:9); dq_int_plus(10)];%dq_plus(6) is the velocity of foot1 which becomes vfoot2 after change of role

%% When the second impact occurs(Foot 1 strikes the ground)
Hip_fin_config(1) = Hip_int_config(1);  % is done to shift the base frame at foot 2 support(ideally Step Length 1 should be added)
Hip_fin_config(2) = HipY_fin;
Hip_fin_config(3) = HipQ_fin;
FootX_fin = FootX_fin - Step_Length_1;  % is done to shift the base frame at foot 2 support
% Solving the IGM at first impact
% NOTE: IGM is solved in the frame of support foot now. Hence its origin is
% at (Steplength1, 0).
[y, flag2] = MGI_Arnaud(Hip_fin_config(1), Hip_fin_config(2), FootX_fin);
q_fin = [y(1:2);Hip_fin_config(3);y(3:4);q_bras_fin;0];

% Impact Model(Foot 1 strikes the ground)
dq_minus = qp_fin; % the velocity just before impact to be optimised
q_dq = [q_fin; dq_minus];
% [dq_plus, ZMPx_impact, R_Force_impact_foot1] = model_Impact_xy(q_dq);
[dq_plus, ZMPx_impact, R_Force_impact_foot2] = model_Impact_SS2(q_dq);

%% Support foot changes(from 2 to 1) i.e. Relabelling
q_ini = [flipud(q_fin(1:5)); q_fin(6:7); q_fin(8:9);q_fin(10)]; %Initial config for next step after change of feet role
qp_ini = [flipud(dq_plus(1:5)); dq_plus(6:7); dq_plus(8:9);dq_plus(10)];%dq_plus(6) is the velocity of foot1 which becomes vfoot2 after change of role

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculating Spline Function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Single Support Phase 1: Foot 1 is in contact and Foot 2 is in air(Step 1)
traj1 = polynomial(q_ini, q_int, qp_ini, qp_int_minus, Tint);
poly1=traj1.q;
polyp1=traj1.qp;
polypp1=traj1.qpp;
vec_T1=traj1.temps;
impactindex = length(vec_T1);
% Single Support Phase 2: Foot 2 is in contact and Foot 1 is in air(Step 2)
traj2 = polynomial(q_int_plus, q_fin, qp_int_plus, qp_fin, T-Tint);
poly2=traj2.q;
polyp2=traj2.qp;
polypp2=traj2.qpp;
vec_T2=traj2.temps;
% Building the walking gait cycle including both steps
poly = [poly1 poly2];
polyp = [polyp1 polyp2];
polypp = [polypp1 polypp2];
vec_T2 = vec_T1(end)+vec_T2;
vec_T = [vec_T1 vec_T2];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculating Dynamic Model to find Joint Torques and Reaction Forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[mp,np]=size(poly);
GAM=zeros(mp,np);
GAM2=zeros(mp,np);
ZMPx=zeros(np,1);
for j=1:np;
    q=poly(:,j);
    dq=polyp(:,j);
    ddq=polypp(:,j);
    [gamma,ZMP,Reaction,vfoot2_toe_temp,vfoot2_heel_temp,ddCG_Biped]=dyn_model_5corps(q, dq, ddq);        
    GAM(:,j)=gamma;
    GAM2(:,j)=gamma.*dq;
    ZMPx(j,:)=ZMP;
    R_Force(:,j) = Reaction;
    vfoot2_toe(:,j)=vfoot2_toe_temp;
    vfoot2_heel(:,j)=vfoot2_heel_temp;
end

Torque = GAM'*GAM;
Energie_criteria=trapz(vec_T,diag(Torque)')/Step_Length;
criteria=Energie_criteria;

return







