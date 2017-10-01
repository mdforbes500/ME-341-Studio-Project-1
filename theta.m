function [theta, thetay, thetaz] = theta(X, R0, FA, FB, RC, E, I, C1)
%THETA Summary of this function goes here
%   Detailed explanation goes here

%Computation of angle of deflection
for index = 1:size(X,2)
    if X(index) <= 0
        thetay(index) = C1(1)/(E*I);
        thetaz(index) = C1(2)/(E*I);
    elseif X(index) > 0 && X(index) <= 0.4
        thetay(index) = (R0(2)/2*(X(index))^2 + C1(1))/(E*I);
        thetaz(index) = (-R0(3)/2*(X(index))^2 + C1(2))/(E*I);
    elseif X(index) > 0.4 && X(index) < 0.75
        thetay(index) = (R0(2)/2*(X(index))^2 + FA(2)/2*(X(index)-0.4)^2 + C1(1))/(E*I);
        thetaz(index) = (-R0(3)/2*(X(index))^2 - FA(3)/2*(X(index)-0.4)^2 + C1(2))/(E*I);
    elseif X(index) > 0.75 && X(index) < 1.05
        thetay(index) = (R0(2)/2*(X(index))^2 + FA(2)/2*(X(index)-0.4)^2 + FB(2)/2*(X(index)-0.75)^2 + C1(1))/(E*I);
        thetaz(index) = (-R0(3)/2*(X(index))^2 - FA(3)/2*(X(index)-0.4)^2 - FB(3)/2*(X(index)-0.75)^2 + C1(2))/(E*I);
    else
        thetay(index) = (R0(2)/2*(X(index))^2 + FA(2)/2*(X(index)-0.4)^2 + FB(2)/2*(X(index)-0.75)^2 + RC(2)/2*(X(index)-1.05)^2 + C1(1))/(E*I);
        thetaz(index) = (-R0(3)/2*(X(index))^2 - FA(3)/2*(X(index)-0.4)^2 - FB(3)/2*(X(index)-0.75)^2 + RC(3)/2*(X(index)-1.05)^2 + C1(2))/(E*I);
    end
end

%Visualization
theta = figure(5);
subplot(1,2,1)
title('Angle of Deflection in y')
xlabel('x [m]')
ylabel('\theta_y [deg]')
%axis([0 1.05 -1*10^-5 1*10^-4])
grid on
hold on
plot(X,thetay,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Angle of Deflection in z')
xlabel('x [m]')
ylabel('\theta_z [deg]')
%axis([0 1.05 -1*10^-5 1*10^-4])
grid on
hold on
plot(X,thetaz,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

end

