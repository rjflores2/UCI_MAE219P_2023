%%%The following script examines and integrates Plank's law to determine
%%%radiation intensity vs. wavelength and total solar intensity

%%%Cleaning current workspace
clc, clear all, close all
%% Defining constants 
%%%Planck's constant h
h = 6.67259e-34; %%J*s

%%%Boltzmann Constant k
k = 1.380658e-23; %J/K

%%%Speed of Light c
c = 2.99792458e8; %m/s

%%%Wavelength - wavelength vector stops arbitrarily at 20 thousand nm.
%%%Radiation is negligible at these wavelengths for temperatures of
%%%interest
wvlgth = [0.1 1:1:20000]/10^9; %m

%% Integrating Planck's law

%%%Specifying temperature of body
T = 5778; %K

%%%Defining material emissivity
em = 1; %%% 1 = black body
%%%Defining planck's law as a function where w is the input variable in
%%%meters
fun = @(w) em*8.*pi.*c^2./(w.^5).*(1./(exp(h.*c./(k.*T.*w))-1));

%%%Integrating Planck's law from 0 to infinity
q_total = integral(fun,0,inf);

q_xray =  integral(fun,0,.1e-7);

%%%%Integrating Planck's law in visible spectrum
q_vis = integral(fun,3.8e-7,7.5e-7);

%%%%Integrating Planck's law in UV spectrum
q_uv = integral(fun,.1e-7,3.8e-7);

%% Solutions

%%%Percentage in visible
q_vis/q_total.*100

%%%Percentage in UV
q_uv/q_total.*100

q_xray/q_total.*100