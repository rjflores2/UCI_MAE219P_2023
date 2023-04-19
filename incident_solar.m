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

%% Set up test matrix
%%%Tilt tests
eta_range = [0:30:90];
% eta_range = 60;
%%%Azimuthal tests
zeta_range = [0:90:270];
% zeta_range = 0;

%%%Pre allocating
test_matrix = zeros(length(eta_range)*length(zeta_range),2);

%%%Setting up test matrix
idx = 1;
for i = 1:length(eta_range)
    for ii = 1:length(zeta_range)
        test_matrix(idx,:) =  [eta_range(i) zeta_range(ii)];
        idx = idx + 1;
    end
end
%% Test Loop
for ii = 1:size(test_matrix,1)

    %% Define our system angles

    %%%Tilt
    eta = test_matrix(ii,1);

    %%%panel orientation
    zeta = test_matrix(ii,2);

    %%%Lattitude
    lat = 33.7;

    %% Brute force angles
    p = zeros(length(t),1);
    p_avail = [];
    solar_dec = [];
    for i = 1:length(t)
        %%% Hour angle
        % alpha = (2*pi/86400)*(rem(t(i),1)*86400-43200); %%%[radians]
        alpha = (360/24)*(rem(t(i),1)*24 - 12); % t in hours [Degrees]
        %%% Solar Declination
        solar_dec = 23.44*sind(360*(t(i)-80)/365.25); %%%[ Degrees]

        %%% Zenith angle - %%%DOUBLE CHECK SLIDES%%%
        zen = acosd(sind(solar_dec)*sind(lat) + cosd(solar_dec)*cosd(lat)*cosd(alpha)); %%%[Degrees]

        %%%Azimuthal angle
        az = atand(sind(alpha)./...
            (sind(lat)*cosd(alpha)-cosd(lat)*tand(solar_dec)));



        %%% Adding logic to az angle
        if alpha > 0 && tand(az) >= 0
            az = az + 180;
        elseif alpha > 0 && tand(az) <= 0
            az = az + 360;
        elseif alpha < 0 && tand(az) >= 0
            % az = az;
        else
            az = az + 180;
        end
        az_i(i,1) = az;


        angles(i,:) = [alpha solar_dec zen az tand(az)];

        p_val = (1.353.*0.7^((1/cosd(zen))^0.678)) .*...
            (cosd(eta)*cosd(zen) + sind(eta)*sind(zen)*cosd(az-zeta));

        if isreal(p_val) && p_val > 0
            p(i) = p_val;
        end


    end

    %% Recording values
    p_rec(ii,1) = sum(p);
end
plot(p)