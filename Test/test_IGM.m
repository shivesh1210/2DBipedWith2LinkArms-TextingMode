% This program can be used to test the IGM of the locomotor system of the
% robot.
% clear all
close all
clc

% Go back to previous directory
cd ..
% Load an already optimised set of parameters for simulation
% load('Optimisation Parameters Results\Optim_Parameters11_V10.mat');

Hydroid_initialisation_2D

Walk_Speed = 1.4;


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

%% When the first impact occurs(Foot 2 strikes the ground)
Tint = Ratio_Tint_to_T*T;   % Time of first impact(1st step)
Step_Length_1 = Step_Length/2;  % Length of first step
FootX_int = Step_Length_1;      % FootX value at first impact

%% When the second impact occurs(Foot 1 strikes the ground)
Hip_fin_config(1) = Hip_int_config(1) + Step_Length_1;
Hip_fin_config(2) = HipY_fin;
Hip_fin_config(3) = HipQ_fin;

% y = MGI_Arnaud(Hip_fin_config(1), Hip_fin_config(2), FootX_fin)
% q_fin = [y(1:2);Hip_fin_config(3);y(3:4);q_bras_fin;0];
% [x] = animation2(q_fin, 0);

% Hip_fin_config(1) = 0.5;
% Hip_fin_config(2) = 0.8;
% FootX_fin = 0.8;
% [y, flag] = MGI_Arnaud(Hip_fin_config(1), Hip_fin_config(2), FootX_fin)
% q_fin = [y(1:2);Hip_fin_config(3);y(3:4);q_bras_fin;0];
% [x] = animation2(q_fin, 0);
j = 1;
d = 0.4774;
q_fin = [];
% Condition for Texting
 q_bras_fin(3) = -0.27; 
 q_bras_fin(4) = pi/2;
for x = 0.25
    for y = 0.743
        [p, flag] = MGI_Arnaud(x, y, d);
        if(flag==0)
            q_fin(:,j) = [p(1:2);Hip_fin_config(3);p(3:4);q_bras_fin;0];
            j = j+1;
        end
    end
end
q_fin

% Come back to Test directory for using animation2 file
cd('Test');

for i = 1:size(q_fin')
[x] = animation2(q_fin(:,i), 0);
end