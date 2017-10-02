function [Sodfig, n] = soderberg(sigmaA, sigmaM, Se, Sy)
%SODERBERG Summary of this function goes here
%   Detailed explanation goes here

%Calculation of Factor of Safety
n = 1/(sigmaA/Se + sigmaM/Sy);

%Visulaization of load line and fatigue diagram
sigmaM = linspace(0, 3.5*10^8, 100);
sigmaA = n*sigmaM;
Sodfig = figure(14);
title('Soderberg Theory Fatigue Diagram')
xlabel('\sigma_M [Pa]')
ylabel('\sigma_A [Pa]')
%axis([0 1.7*10^8 0 370*10^6])
grid on
hold on
plot(sigmaM, sigmaA, 'k-')
plot([Sy;0],[0;Se], 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off

end

