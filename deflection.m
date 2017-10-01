function [deflection, Y, Z] = deflection(X, R0, FA, FB, RC, E, I, C1, C2)
%DEFLECTION Summary of this function goes here
%   Detailed explanation goes here

%Computation of deflection
for index = 1:size(X,2)
    if X(index) <= 0
        Y(index) = (C1(1)*X(index)+C2(1))/(E*I);
        Z(index) = (C1(2)*X(index)+C2(2))/(E*I);
    elseif X(index) > 0 && X(index) <= 0.4
        Y(index) = (R0(2)/6*(X(index))^3 + C1(1)*X(index)+C2(1))/(E*I);
        Z(index) = (-R0(3)/6*(X(index))^3 + C1(2)*X(index)+C2(2))/(E*I);
    elseif X(index) > 0.4 && X(index) < 0.75
        Y(index) = (R0(2)/6*(X(index))^3 + FA(2)/6*(X(index)-0.4)^3 + C1(1)*X(index)+C2(1))/(E*I);
        Z(index) = (-R0(3)/6*(X(index))^3 - FA(3)/6*(X(index)-0.4)^3 + C1(2)*X(index)+C2(2))/(E*I);
    elseif X(index) > 0.75 && X(index) < 1.05
        Y(index) = (R0(2)/6*(X(index))^3 + FA(2)/6*(X(index)-0.4)^3 + FB(2)/6*(X(index)-0.75)^3 + C1(1)*X(index)+C2(1))/(E*I);
        Z(index) = (-R0(3)/6*(X(index))^3 - FA(3)/6*(X(index)-0.4)^3 - FB(3)/6*(X(index)-0.75)^3 + C1(2)*X(index)+C2(2))/(E*I);
    else
        Y(index) = (R0(2)/6*(X(index))^3 + FA(2)/6*(X(index)-0.4)^3 + FB(2)/6*(X(index)-0.75)^3 + RC(2)/6*(X(index)-1.05)^3 + C1(1)*X(index)+C2(1))/(E*I);
        Z(index) = (-R0(3)/6*(X(index))^3 - FA(3)/6*(X(index)-0.4)^3 - FB(3)/6*(X(index)-0.75)^3 + RC(3)/6*(X(index)-1.05)^3 + C1(2)*X(index)+C2(2))/(E*I);
    end
end

%Visualization
deflection = figure(6);
subplot(1,2,1)
title('Deflection in y')
xlabel('x [m]')
ylabel('y [m]')
%axis([0 1.05 -4*10^-5 4*10^-5])
grid on
hold on
plot(X,Y,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Deflection in z')
xlabel('x [m]')
ylabel('z [m]')
%axis([0 1.05 -4*10^-5 4*10^-5])
grid on
hold on
plot(X,Z,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

end

