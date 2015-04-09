function [qr]=Convert_to_qr(q) %here qr are the relative and q are the absolute angles
[m,n]=size(q);
qr=zeros(m,n);
qr(1,:) = q(1,:);
qr(2,:) = q(2,:)-q(1,:); %as q2=qr1+qr2
qr(3,:) = q(3,:)-q(2,:);
qr(4,:) = q(4,:)-q(3,:);
qr(5,:) = q(5,:)-q(4,:);
qr(6,:) = q(6,:)-q(3,:);
qr(7,:) = q(7,:)-q(6,:);
qr(8,:) = q(8,:)-q(3,:);
qr(9,:) = q(9,:)-q(8,:);
qr(10,:) = q(10,:)-q(5,:);