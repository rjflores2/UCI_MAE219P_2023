%%
clc, clear all, close all

%% Constants

%%%Betz limit
betz_limit = 16/27;

%%% Density of air
density = 1.225; %(kg/m^3)

%%%Design Power
design_power = 10e6; %(Watts)

%%% Design tip speed
tip_speed = 8; %Use 8

%%% blade number
blade_number = 3;

%%% design efficiency
design_efficiency = .9;

%%%Cutin /cut out speed
cutin = 0.05; %(Fraction of design speed)
cutout = 1.5;  %(Fraction of design speed)

%% Test matrix
%%%[ Design wind speed (m/s) 
%%% Angle of attak (degrees)]
test_matrix = [10 10];

%% Design
%%%number of discritizations
disc = 50; 

for ii = 1:size(test_matrix,1)
    %%%Extract test data
    v_design = test_matrix(ii,1); %%%(m/s)
    aoa = test_matrix(ii,2); %%%(degrees)

    %%%Design power density (W/m^2)
    p_density_design = (1/2)*density*betz_limit*design_efficiency*v_design^3;

    %%%Swept area(m^2)
    swept_area = design_power/p_density_design;

    %%% Blade length (m)
    blade_length = (swept_area/pi)^(1/2);

    %%%rotational speed (radians/second)
    rotate_speed = tip_speed*v_design/blade_length;

    %%%Coefficients of lift/drag
    CL = 0.6 + 0.066*aoa - 0.001*aoa^2 - 3.8e-5*aoa^3;
    CD = .12 - .11*cosd(aoa);

    %% Discretize and evalute the blade
    for jj = 1:disc
        %%% find the average distance from the hub for r_i
        r_i = blade_length/disc*(jj-1) +blade_length/disc/2;

        %%% find the apparent wind speed
        w_i = ((r_i*rotate_speed)^2 + (v_design*2/3)^2)^(1/2);

        %%% Find local betz limit
        betz(jj) = betz_limit*(1/2)*density*v_design^3*r_i*(blade_length/disc)*2*pi;

        %%% Building lift/drag torque to power equation
        alpha(jj) = blade_number*rotate_speed*(1/2)*density*w_i^2*r_i*(blade_length/disc)*(CL*2/3*v_design - CD*r_i*rotate_speed);
        %%%Chord length
        k(jj) = betz(jj)/alpha(jj);
    
    
    end
end

figure
plot(k)