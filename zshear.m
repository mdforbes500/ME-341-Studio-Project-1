function [Vy, Vz, My, Mz, thetaY, thetaZ, y, z, tau] = zshear(length, R0, FA, FB, RC, E, Iz, Iy, C1, C2)
%ZSHEAR Computes internal forces in the x-z and x-y planes for system A.
%   Uses IF/ELSEIF/ELSE blocks to describe the internal forces 
%   in the x-z and x-y planes at each point in the system A along 
%   the length.

if length <= 0
    Vy = 0;
    Vz = 0;
    My = 0;
    Mz = 0;
    tau = 0;
    thetaY = C1(1)/(E*Iy)*180/pi;
    thetaZ = C1(2)/(E*Iz)*180/pi;
    y = (C1(1)*length + C2(1))/(E*Iy);
    z = (C1(2)*length + C2(2))/(E*Iz);
elseif length > 0 && length <= 0.4
    Vy = R0(2);
    Vz = R0(3);
    My = R0(2)*length;
    Mz = R0(3)*length;
    tau = 0;
    thetaY = 1/(E*Iy)*(R0(2)*length^2/2 + C1(1))*180/pi;
    thetaZ = 1/(E*Iz)*(R0(3)/2*length^2 + C1(2))*180/pi;
    y = 1/(E*Iy)*(R0(2)/6*length^3 + C1(1)*length + C2(1));
    z = 1/(E*Iz)*(R0(3)/6*length^3 + C1(2)*length + C2(2));
elseif length >= 0.4 && length < 0.75
    Vy = R0(2) - FA(2);
    Vz = R0(3) - FA(3);
    My = R0(2)*length -FA(2)*(length-0.4);
    Mz = R0(3)*length-FA(3)*(length-0.4);
    tau = FA(3)*0.3;
    thetaY = 1/(E*Iy)*(R0(2)/2*length^2-FA(2)/2*(length-0.4)^2 + C1(1))*180/pi;
    thetaZ = 1/(E*Iz)*(R0(3)/2*length^2-FA(3)/2*(length-0.4)^2 + C1(2))*180/pi;
    y = 1/(E*Iy)*(R0(2)/6*length^3-FA(2)/6*(length-0.4)^3 + C1(1)*length + C2(1));
    z = 1/(E*Iz)*(R0(3)/6*length^3-FA(3)/6*(length-0.4)^3 + C1(2)*length + C2(2));
elseif length >= 0.75 && length < 1.05
    Vy = R0(2) - FA(2) - FB(2);
    Vz = R0(3) - FA(3) + FB(3);
    My = R0(2)*length -FA(2)*(length-0.4) -FB(2)*(length-0.75);
    Mz = R0(3)*length-FA(3)*(length-0.4)+FB(3)*(length-0.75);
    tau = FA(3)*0.3 + FB(3)*0.15;
    thetaY = 1/(E*Iy)*(R0(2)/2*length^2-FA(2)/2*(length-0.4)^2-FB(2)/2*(length-0.75)^2 + C1(1))*180/pi;
    thetaZ = 1/(E*Iz)*(R0(3)/2*length^2-FA(3)/2*(length-0.4)^2+FB(3)/2*(length-0.75)^2 + C1(2))*180/pi;
    y = 1/(E*Iy)*(R0(2)/6*length^3-FA(2)/6*(length-0.4)^3-FB(2)/6*(length-0.75)^3 + C1(1)*length + C2(1));
    z = 1/(E*Iz)*(R0(3)/6*length^3-FA(3)/6*(length-0.4)^3+FB(3)/6*(length-0.75)^3 + C1(2)*length + C2(2));
else
    Vy = R0(2) - FA(2) - FB(2) + RC(2);
    Vz = R0(3) - FA(3) + FB(3) + RC(3);
    My = R0(2)*length -FA(2)*(length-0.4) -FB(2)*(length-0.75) + RC(2)*(length-1.05);
    Mz = R0(3)*length-FA(3)*(length-0.4)+FB(3)*(length-0.75) + RC(3)*(length-1.05);
    tau = FA(3)*0.3 + FB(3)*0.15;
    thetaY = 1/(E*Iy)*(R0(2)/2*length^2-FA(2)/2*(length-0.4)^2-FB(2)/2*(length-0.75)^2+RC(2)/2*(length-1.05)^2 + C1(1))*180/pi;
    thetaZ = 1/(E*Iz)*(R0(3)/2*length^2-FA(3)/2*(length-0.4)^2+FB(3)/2*(length-0.75)^2+RC(3)/2*(length-1.05)^2 + C1(2))*180/pi;
    y = 1/(E*Iy)*(R0(2)/6*length^3-FA(2)/6*(length-0.4)^3-FB(2)/6*(length-0.75)^3+RC(2)/6*(length-1.05)^3 + C1(1)*length + C2(1));
    z = 1/(E*Iz)*(R0(3)/6*length^3-FA(3)/6*(length-0.4)^3+FB(3)/6*(length-0.75)^3+RC(3)/6*(length-1.05)^3 + C1(2)*length + C2(2));
end

end

