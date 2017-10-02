function [ ModFig, n ] = ModGoodman( sigmaA, sigmM, Sut, Se )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Calculation of factor of safety
n = 1/(sigmaA/Se +sigmM/Sut);

%Visulaization of load line and fatigue diagram
sigmaM = linspace(0, 3.5*10^8, 100);
sigmaA = n*sigmaM;
ModFig = figure(15);
title('Mod-Goodman Theory Fatigue Diagram')
xlabel('\sigma_M [Pa]')
ylabel('\sigma_A [Pa]')
%axis([0 1.7*10^8 0 370*10^6])
grid on
hold on
plot(sigmaM, sigmaA, 'k-')
plot([Sut;0],[0;Se], 'k-')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
hold off
end

