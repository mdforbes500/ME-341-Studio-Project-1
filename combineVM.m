function [ VMgraph, V, M ] = combineVM(X, Vy, Vz, My, Mz)
%COMBINEVM Summary of this function goes here
%   Detailed explanation goes here

%Computation of V and M
for index = 1:size(X,2)
    V(index) = sqrt((Vy(index))^2 + (Vz(index))^2);
    M(index) = sqrt((My(index))^2 + (Mz(index))^2);
end

%Visualization of V and M
VMgraph = figure(7);
subplot(1,2,1)
title('Combined Shear')
xlabel('x [m]')
ylabel('V [N]')
%axis([0 1.05 -11*10^3 11*10^3])
grid on
hold on
plot(X,V,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot(1,2,2)
title('Combined Moment')
xlabel('x [m]')
ylabel('M [N-m]')
%axis([0 1.05 -11*10^3 11*10^3])
grid on
hold on
plot(X,M,'k')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

end

