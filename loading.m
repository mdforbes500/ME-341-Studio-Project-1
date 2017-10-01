function fig = loading(R0, FA, FB, RC)
%LOADING Creates loading diagrams for given loading configuration
%   Loads the figure

%Visualization of results
fig = figure(1);
subplot (1,2,1)
title('Loading components in x-y plane')
xlabel('x [m]')
ylabel('q_y [N]')
axis([0 1.05 -3*10^4 3*10^4])
grid on
hold on
plot([0 0.4 0.75 1.05; 0 0.4 0.75 1.05],[0 0 0 0;R0(2) FA(2) FB(2) RC(2)], '.k-')
ax = gca;
ax.XAxisLocation = 'origin';
hold off

subplot (1,2,2)
title('Loading components in x-z plane')
xlabel('x [m]')
ylabel('q_z [N]')
axis([0 1.05 -3*10^4 3*10^4])
grid on
hold on
plot([0 0.4 0.75 1.05; 0 0.4 0.75 1.05],[0 0 0 0;R0(3) FA(3) FB(3) RC(3)], '.k-')
ax = gca;
ax.XAxisLocation = 'origin';
hold off
end

