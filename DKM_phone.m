function [dx, dy] = DKM_phone( qj, qdj)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global L1 L2 L8 L9 sb

q1 = qj(1);
q2 = qj(2);
q3 = qj(3);
q9 = qj(8);
q10 = qj(9);

qd1 = qdj(1);
qd2 = qdj(2);
qd3 = qdj(3);
qd9 = qdj(8);
qd10 = qdj(9);

dx = - L1*cos(q1)*qd1 - L2*cos(q2)*qd2 - sb*cos(q3)*qd3 + L8*cos(q9)*qd9 + L9*cos(q10)*qd10;
dy = - L1*sin(q1)*qd1 - L2*sin(q2)*qd2 - sb*sin(q3)*qd3 + L8*sin(q9)*qd9 + L9*sin(q10)*qd10;

end

