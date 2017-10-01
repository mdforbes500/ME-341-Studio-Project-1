function [bending, My, Mz] = bending(X, R0, FA, FB, RC)
%BENDING Summary of this function goes here
%   Detailed explanation goes here

%Computation of bending moment
for index = 1:size(X,2)
    if X(index) <= 0
        My(index) = 0;
        Mz(index) = 0;
    elseif X(index) > 0 && X(index) <= 0.4
        My(index) = R0(2)*X(index);
        Mz(index) = -R0(3)*X(index);
    elseif X(index) > 0.4 && X(index) < 0.75
        My(index) = R0(2)*X(index) + FA(2)*(X(index)-0.4);
        Mz(index) = -R0(3)*X(index) - FA(3)*(X(index)-0.4);
    elseif X(index) > 0.75 && X(index) < 1.05
        My(index) = R0(2)*X(index) + FA(2)*(X(index)-0.4) + FB(2)*(X(index)-0.75);
        Mz(index) = -R0(3)*X(index) - FA(3)*(X(index)-0.4) - FB(3)*(X(index)-0.75);
    else
        My(index) = R0(2)*X(index) + FA(2)*(X(index)-0.4) + FB(2)*(X(index)-0.75) + RC(2)*(X(index)-1.05);
        Mz(index) = -R0(3)*X(index) - FA(3)*(X(index)-0.4) - FB(3)*(X(index)-0.75) + RC(3)*(X(index)-1.05);
    end
end

%Visualization of Bending Moment
bending = figure(3);
subplot(1,2,1)
title('Bending Moment component in x-y plane')
xlabel('x [m]')
ylabel('M_y [N-m]')
axis([0 1.05 -200 3.5*10^3])
grid on
hold on
plot(X,My,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Bending Moment component in x-z plane')
xlabel('x [m]')
ylabel('M_z [N-m]')
axis([0 1.05 -200 3.5*10^3])
grid on
hold on
plot(X,Mz,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off
end

