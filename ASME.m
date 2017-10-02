function [ ASMEFig, n ] = ASME( sigmaA, sigmaM, Se, Sy )
%ASME Summary of this function goes here
%   Detailed explanation goes here

%Calculuation of factor of safety
n = sqrt(1/((sigmaA/Se)^2 +(sigmaM/Sy)^2));

%Visualization of fatigue diagram
sigmaM = linspace(0, 3.5*10^8, 100);
Sm = linspace(0,4.4*10^8, 100);
Sa = Se*sqrt(1-Sm.^2/Sy.^2);
sigmaA = n*sigmaM;
ASMEFig = figure(17);
title('ASME-Elliptic Theory Fatigue Diagram')
xlabel('\sigma_M [Pa]')
ylabel('\sigma_A [Pa]')
%axis([0 1.7*10^8 0 370*10^6])
grid on
hold on
plot(sigmaM, sigmaA, 'k-')
plot(Sm, Sa, 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off

end

