function [x, y] = DGM_phone( qj, x0, z0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global L1 L2 L8 L9 sb hp

q1 = qj(1);
q2 = qj(2);
q3 = qj(3);
q9 = qj(8);
q10 = qj(9);

x = x0 - L1*sin(q1) - L2*sin(q2) - sb*sin(q3) + L8*sin(q9) + L9*sin(q10);
y = z0 + hp + L1*cos(q1) + L2*cos(q2) + sb*cos(q3) - L8*cos(q9) - L9*cos(q10);
 
end

