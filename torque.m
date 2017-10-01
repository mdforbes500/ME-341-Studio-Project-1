function [torque, Tx] = torque(X, R0, FA, FB, RC)
%TORQUE Summary of this function goes here
%   Detailed explanation goes here

%Computation of torque
for index = 1:size(X,2)
    if X(index) <= 0
        Tx(index) = 0;
    elseif X(index) > 0 && X(index) <= 0.4
        Tx(index) = 0;
    elseif X(index) > 0.4 && X(index) < 0.75
        Tx(index) = FA(3)*0.3;
    elseif X(index) > 0.75 && X(index) < 1.05
        Tx(index) = FA(3)*0.3 + FB(3)*0.15;
    else
        Tx(index) = 0;
    end
end
%Visualization of torque
torque = figure(4);
title('Torsional Torque Diagram')
xlabel('x [m]')
ylabel('T [N-m]')
axis([0 1.05 -4.5*10^3 0.1*10^3])
grid on
hold on
plot(X,Tx,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

end

