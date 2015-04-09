
global vec_T GAM poly polyp polypp ld lg
global ZMPx R_Force  qr vfoot2_toe vfoot2_heel
global R_Force_y no_slipping

% S=solve('d+L1*sin(q1)+L2*sin(q2)-L4*sin(q4)-L5*sin(q5)=0','xh+L2*sin(q2)+L1*sin(q1)=0',' yh-L2*cos(q2)-L1*cos(q1)-hp=0',' yh-L4*cos(q4)-L5*cos(q5)-hp=0','q1,q2,q4,q5')

% S=solve('d+L1*sin(q1)+L2*sin(q2)-L4*sin(q4)-L5*sin(q5)=0','xh+L2*sin(q2)+L1*sin(q1)=0',' xh+L4*sin(q4)+L5*sin(q5)-d=0',' yh-L4*cos(q4)-L5*cos(q5)-hp=0','q1,q2,q4,q5')

% S=solve('d+L1*sin(q1)+L2*sin(q2)-L4*sin(q4)-L5*sin(q5)=0','xh+L2*sin(q2)+L1*sin(q1)=0',' yh-L2*cos(q2)-L1*cos(q1)-hp=0',' xh+L4*sin(q4)+L5*sin(q5)-d=0','q1,q2,q4,q5')

% xh+L4*sin(q4)+L5*sin(q5)-d
% pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Joint Torques
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
hold on; grid on
xlabel('Time (sec)')
ylabel('Torque (N.m)')
plot(vec_T,GAM)
% plot(vec_T,GAM,'LineWidth',1.5)
% legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Arm 1 ','forearm 1','Arm 2 ','forearm 2','Swing Ankle')
% title('Torques','FontSize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Absolute Joint Positions in Degrees
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
hold on; grid on
xlabel('Time (sec)')
ylabel('Joint absolute angle (degree)')
plot(vec_T,poly*180/pi)
% legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Arm 1 ','forearm 1','Arm 2 ','forearm 2','Swing Ankle')
% title('Absolute Joint Positions','FontSize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Relative Joint Positions in Degrees
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(3)
% hold on; grid on
% xlabel('Time (sec)')
% ylabel('Joint relative angle (degree)')
% qr=Convert_to_qr(poly);
% plot(vec_T,qr*180/pi)
% % legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
% legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Arm 1 ','forearm 1','Arm 2 ','forearm 2','Swing Ankle')
% % title('Relative Joint Positions','FontSize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Joint Velocities in rad/sec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
qrr=Convert_to_qr(polyp);

figure(4)
hold on; grid on
xlabel('Time (sec)')
ylabel('Relative Joint Velocity (rad/sec)')
plot(vec_T,qrr*180/pi)
% legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Arm 1 ','forearm 1','Arm 2 ','forearm 2','Swing Ankle')
% title('Joint Velocities','FontSize',14)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Joint Accelerations in rad/sec.sec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(5)
% hold on; grid on
% xlabel('Time (sec)')
% ylabel('Joint Acceleration (rad/sec.sec)')
% plot(vec_T,polypp)
% % legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
% legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Arm 1 ','forearm 1','Arm 2 ','forearm 2','Swing Ankle')
% % title(' Joint Accelerations','FontSize',14)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Vertical Reaction Force Ry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R_Force_y=R_Force(2,:);
Ry=R_Force(2,:);
Rx=R_Force(1,:);

figure(6)
hold on; grid on
xlabel('Time (sec)')
ylabel('Vertical Reaction Force (N)')
% title('No Take-Off Constraint','FontSize',14)
plot(vec_T,R_Force_y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot no-slipping constraint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=0.8;
% no_slipping = mu*R_Force(2,:)'- abs(R_Force(1,:)');
figure(7)
hold on; grid on
xlabel('Time (sec)')
ylabel('mu*Ry - abs(Rx) (N)')
% title('No-Slipping Constraint','FontSize',14)
plot(vec_T,no_slipping)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot ZMPx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb_ZMPx=[vec_T(1),vec_T(end)];
lb_ZMPy=[-lg,-lg]*100;
ub_ZMPx=lb_ZMPx;
ub_ZMPy=[ld,ld]*100;
figure(8)
hold on; grid on
xlabel('Time (sec)')
ylabel('ZMPx (cm)')
% title('ZMPx','FontSize',14)
plot(ub_ZMPx,ub_ZMPy,'--r','LineWidth',1.5)
plot(lb_ZMPx,lb_ZMPy,'--r','LineWidth',1.5)
plot(vec_T,ZMPx*100)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plot Toe and Heel Vertical Velocity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(9)
Toe_y = vfoot2_toe(2,:);
Heel_y = vfoot2_heel(2,:);
hold on; grid on
xlabel('Time (sec)')
ylabel('Vertical Component of Velocity (m/sec)')
% title('ZMPx','FontSize',14)

plot(vec_T,[Toe_y;Heel_y])
legend('Toe Velocity','Heel Velocity')

figure(13)
hold on; grid on
xlabel('Time (sec)')
ylabel('A_b_b*ddq_b')
plot(vec_T,Abb_ddqb)
% plot(vec_T,GAM,'LineWidth',1.5)
% legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Swing Ankle')


figure(14)
hold on; grid on
xlabel('Time (sec)')
ylabel('A_b_h*ddq_h')
plot(vec_T,Abh_ddqh)
% plot(vec_T,GAM,'LineWidth',1.5)
% legend('Swing Ankle','Swing Knee','Swing Hip','Support Hip','Support Knee','Support Ankle')
legend('Support Ankle','Support Knee','Support Hip ','Swing Hip','Swing Knee','Swing Ankle')
