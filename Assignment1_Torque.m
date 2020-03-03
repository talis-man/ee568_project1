
close all
clear all
clc
%Constants
u=4*pi*10^-7                                                                            %Permeability of air
N=250                                                                                     %Number of turns
i=3                                                                                          % Amplitude of current
h=20*10^-3                                                                               %Depth of machine
alpha = fix(asind(7.5/12.5))                                                        % Rotor position angle that provides lowest inductance
beta = fix(acosd(7.5/12.5))                                                         % Rotor position angle that provides highest inductance
L_old=0.044


for xteta=(90 - beta)/2 : 1 : 360+(90 - beta)/2                               %Loop that calculates reluctance, inductance and torque for every single degree 
                                                                                               %(90 - beta)/2 is to shift to align rotor horizontally
    teta = mod(xteta,180)                                                            %Rotor has rotational symmetry of 180º
    
 
if teta < (90 - beta)                                                                      % Lowest  inductance
    r=10*10^-3                                                                              % Diameter of surface for larger air-gap
    g=2.5*10^-3                                                                            % Length of air-gap
    angle = ((2*alpha)*2*pi)/360                                                      % Represents surface angle that flux flows through to rotor, constant
    R=(2*g)/(u*h*(r+0.5*g)*angle)                                                    % Reluctance, constant since all the parameters are constant that reluctance rely on
    L=N^2/R                                                                                 %Inductance
    T= 0                                                                                       %It can also be calculated, but not necessary since inductance is constant
    L_old = L                                                                                %Keeps the old inductance value to calculate derivative of inductance, but needs initial value
    
elseif teta >= (90 - beta) & teta <=  (90 - beta)+(2*alpha)                % Increasing  inductance
    r=12*10^-3                                                                              % Diameter of surface for smaller air-gap
    g=0.5*10^-3                                                                            % Length of air-gap
    angle = ((teta - (90 - beta))*2*pi)/360                                         % Surface angle that flux flows through for smaller air-gap
    R=(2*g)/(u*h*(r+0.5*g)*angle)                                                    % Reluctance for smaller air-gap
    L=N^2/R                                                                                 % Inductance for smaller air-gap
    r=10*10^-3                                                                              % Diameter of surface for larger air-gap
    g=2.5*10^-3                                                                             % Length of air-gap
    angle1 = 1.29-angle                                                                 % Surface angle that flux flows through for larger air-gap (1.29 = angle expression of  rotor width)
    R1=(2*g)/(u*h*(r+0.5*g)*angle1)                                                 % Reluctance for larger air-gap
    L1=N^2/R1                                                                              % Inductance for larger air-gap                  
    L= L + L1                                                                                %Total inductance
    T= 0.5*i^2*(L - L_old)*(360/(2*pi))                                               %Torque calculation, (inductance change at each degree)
    L_old = L                                                                                 % Keeps the last inductance value for next derivation
    
else                                                                                            % Decreasing  inductance
    r=12*10^-3                                                                               % Diameter of surface for smaller air-gap
    g=0.5*10^-3                                                                             % Length of air-gap
    angle = ((180 - teta)*2*pi)/360                                                    % Surface angle that flux flows through for smaller air-gap
    R=(2*g)/(u*h*(r+0.5*g)*angle)                                                     % Reluctance for smaller air-gap
    L=N^2/R                                                                                  % Inductance for smaller air-gap
    r=10*10^-3                                                                               % Diameter of surface for larger air-gap
    g=2.5*10^-3                                                                             % Length of air-gap
    angle1 = 1.29-angle                                                                  % Surface angle that flux flows through for larger air-gap (1.29 = angle expression of  rotor width)
    R1=(2*g)/(u*h*(r+0.5*g)*angle1)                                                 % Reluctance for larger air-gap
    L1=N^2/R1                                                                               % Inductance for larger air-gap     
    L= L + L1                                                                                %Total inductance
    T= 0.5*i^2*(L - L_old)*(360/(2*pi))                                               %Torque calculation, (inductance change at each degree)
    L_old = L                                                                                  % Keeps the last inductance value for next derivation

end

figure(1)                                                                                       %
plot(((xteta-(90 - beta)/2)*2*pi)/360,L,'.')                                           % (90 - beta)/2 is to shift to align rotor horizontally
grid                                                                                             %
hold on

figure(2)                                                                                       %
plot(((xteta-(90 - beta)/2)*2*pi)/360,T,'.')                                           % (90 - beta)/2 is to shift to align rotor horizontally
grid                                                                                             %
hold on
end
