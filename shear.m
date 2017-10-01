function [shear, Vy, Vz] = shear(X, R0, FA, FB, RC)
%SHEAR Creates shear function diagrams
%   Computes and visualizes shear components in the xy and xz planes.

%Computation of shear
for index = 1:size(X,2)
    if X(index) <= 0
        Vy(index) = 0;
        Vz(index) = 0;
    elseif X(index) > 0 && X(index) <= 0.4
        Vy(index) = R0(2);
        Vz(index) = -R0(3);
    elseif X(index) > 0.4 && X(index) < 0.75
        Vy(index) = R0(2) + FA(2);
        Vz(index) = -R0(3) - FA(3);
    elseif X(index) > 0.75 && X(index) < 1.05
        Vy(index) = R0(2) + FA(2) + FB(2);
        Vz(index) = -R0(3) - FA(3) - FB(3);
    else
        Vy(index) = R0(2) + FA(2) + FB(2) + RC(2);
        Vz(index) = -R0(3) - FA(3) - FB(3) + RC(3);
    end
end

%Visualization of shear
shear = figure(2);
subplot(1,2,1)
title('Shear component in x-y plane')
xlabel('x [m]')
ylabel('V_y [N]')
axis([0 1.05 -11*10^3 11*10^3])
grid on
hold on
plot(X,Vy,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Shear component in x-z plane')
xlabel('x [m]')
ylabel('V_z [N]')
axis([0 1.05 -11*10^3 11*10^3])
grid on
hold on
plot(X,Vz,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off
end

