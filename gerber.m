function [ GerberFig, n ] = gerber( sigmaA, sigmaM, Se, Sut )
%GERBER Summary of this function goes here
%   Detailed explanation goes here

%Calculation of Factor of Safety
n = 0.5*(Sut/sigmaM)^2*sigmaA/Se*(-1+sqrt(1+(2*sigmaM*Se/(Sut*sigmaA))^2));

%Visualization of the fatigue diagram
sigmaM = linspace(0, 3.5*10^8, 100);
Sm = linspace(0,4.4*10^8, 100);
Sa = Se-Se*Sm.^2/Sut.^2;
sigmaA = n*sigmaM;
GerberFig = figure(16);
title('Gerber Theory Fatigue Diagram')
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

