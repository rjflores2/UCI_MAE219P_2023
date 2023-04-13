%%%
clc, clear all, close all

%% Declare constants

%%%Time Step
t_step = 1/24;

%%%Time Vector
t = [0:t_step:365]';

%%%Start and end of day - assuming that 12 hours long
d_start = 6/24; %%%Sunrise is at 6am
d_end = 18/24; %%%Sunset is at 6pm

%% Define our system angles

%%%Tilt
eta = 50;

%%%panel orientation
zeta = 0;

%%%Lattitude
lat = 33.7;

%% Brute force angles
p = [];
solar_dec = [];
for i = 1:length(t)
    %%% Hour angle
    alpha = (2*pi/86400)*(rem(t(i),1)*86400-43200); %%%[radians]

    %%% Solar Declination
    solar_dec = 23.44*sind(360*(t(i)-80)/365.25); %%%[ Degrees]

    %%% Zenith angle - %%%DOUBLE CHECK SLIDES%%%
    zen = acosd(sind(solar_dec)*sind(lat) + cosd(solar_dec)*cosd(lat)*cos(alpha)); %%%[Degrees]

    %%%Azimuthal angle
    az = atand(sin(alpha)/(sind(lat)*cos(alpha)-cosd(lat)*tand(solar_dec)));

    %%% Adding logic to az angle
    if alpha >= 0 && tand(az) >= 0
        az = az + 180;
    elseif alpha >= 0 && tand(az) < 0
        az = az + 360;
    elseif alpha < 0 && tand(az) >= 0
        % az = az;
    else
        az = az + 180;
    end

if (cosd(eta)*cosd(zen) + sind(eta)*sind(zen)*cosd(az-zeta)) > 0
p(i,1) = 1*(cosd(eta)*cosd(zen) + sind(eta)*sind(zen)*cosd(az-zeta));

end

end

plot(p)