% To plot the criterion value vs ratio Tint/T for different walking speeds

close all
clear all
clc

i = 1;

% Go back to previous directory
cd ..

Hydroid_initialisation_2D

for Walk_Speed = 0.4:0.1:1.5
    % Load an already optimised set of parameters for simulation
    if(Walk_Speed<1)
        str = strcat('Optimisation Parameters Results\Optim_Parameters11_V0',num2str(Walk_Speed*10),'.mat');
    else 
        str = strcat('Optimisation Parameters Results\Optim_Parameters11_V',num2str(Walk_Speed*10),'.mat');
    end    
    load(str);

    criteria(i) = Hydroid_Trajec(Optim_Parameters);
    ratio(i) = Optim_Parameters(4);
    i = i+1;
end

Walk_Speed = 0.4:0.1:1.5;
figure;
plot(ratio,criteria);
xlabel('Ratio Tint/T');
ylabel('Criteria');
title('Criteria vs Ratio Tint/T');

figure;
plot(Walk_Speed,criteria);
xlabel('Walk Speed');
ylabel('Criteria');
title('Criteria vs Walk Speed');

figure;
plot(Walk_Speed,ratio);
ylabel('Ratio Tint/T');
xlabel('Walk Speed');
title('Walk Speed vs Ratio Tint/T');
