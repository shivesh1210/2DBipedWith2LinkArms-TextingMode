function [ddx, ddy] = DDM_phone( qj, qdj, qddj)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global L1 L2 L8 L9 sb

q1 = qj(1);
q2 = qj(2);
q3 = qj(3);
q9 = qj(8);
q10 = qj(9);

dq1 = qdj(1);
dq2 = qdj(2);
dq3 = qdj(3);
dq9 = qdj(8);
dq10 = qdj(9);

ddq1 = qddj(1);
ddq2 = qddj(2);
ddq3 = qddj(3);
ddq9 = qddj(8);
ddq10 = qddj(9);

ddx = L1*sin(q1)*dq1^2 - L9*sin(q10)*dq10^2 + L2*sin(q2)*dq2^2 + sb*sin(q3)*dq3^2 - L8*sin(q9)*dq9^2 - ddq3*sb*cos(q3) - L1*ddq1*cos(q1) - L2*ddq2*cos(q2) + L9*ddq10*cos(q10) + L8*ddq9*cos(q9);
 
ddy = - L1*cos(q1)*dq1^2 + L9*cos(q10)*dq10^2 - L2*cos(q2)*dq2^2 - sb*cos(q3)*dq3^2 + L8*cos(q9)*dq9^2 - ddq3*sb*sin(q3) - L1*ddq1*sin(q1) - L2*ddq2*sin(q2) + L9*ddq10*sin(q10) + L8*ddq9*sin(q9);

end

