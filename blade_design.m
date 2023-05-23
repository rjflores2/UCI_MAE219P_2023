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
tip_speed = 15; %Use 8

%%% blade number
blade_number = 4;

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

%% 

end