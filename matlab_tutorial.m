%% Scriting and Variables
%%% "%" symbol is for comments
%%% "%%" at the start of a line indicates a "cell" or chunk of code

%%% To run an individual cell, use "ctrl+enter"

%%% To run an individual line or highlighted code, highlight and hit "F9"

%%%Starting commands to clean up your matlab
clc %Clear command window
clear all %Clear workspace
close all %Close any stray figures

%%% Declaring variables - start with letter, but can include numbers after
%%% 1st character

%%% Note that you can overwrite existing functions as a variable, which
%%% will cut your access to the function unless you "clear all"
%%%
%%% For example, sum() adds array elements. If you however call a variable
%%% "sum = ...", the sum() function will not work

%%%Double array
a1 = 1

%%% "class()" function will tell you what a variable is
class(a1)

%%%Character array
a1 = 'abc'
class(a1)

%%%String array
a1 = "abc"
class(a1)

%%% Resetting workspace
clear all, clc
%%% Surpress outputs with ";"
a1 = 1;

%% Matrixies
%%% Empty out a1
a1 = [];
%%% conveitonal matirx notation: RxC --> R = row numbers, C = Column
%%% numbers. If hand coding a matrix, use ";" to indicate new row;

a1 = [1 2;3 4]

%%% OR just use a new line for each new row
a1 = [3 4
    1 2]

%%% Examine matrix components by using matrix location
a1(2,2)

%%%Other ways to build matricies - Vectors
a1 = 1:4 %%%Row vector
a1 = [1:4]' %%%Column vector using the transpose

%%% what if you want non-integer entries
a1 = 1:0.2:4

%%% Preallocaiton and other matrix functions
%%% zeros(m,n) / ones(m,n) make matricies of m rows, n columns full of
%%% zeors/ones
a1 = zeros(3,2)

a1 = -ones(3,2)

%%%If you need to dynamically find matrix dimmensions, use
%%%"size(var,dimension)" where var is the variable and dimension is if you
%%%want row #, of column # (1 = row, 2 = column). 

%%%DONT ENTER A DIMENSION IF YOU WANT BOTH
size(a1)
size(a1,1)
size(a1,2)

%%% The (1 = row, 2 = column) notation applies to other functions like min,
%%% max, std, etc.

%% Matrix Operations (adding, subtracting, multiplying, and dividing things)
clear all
a1 = 4;
a2 = 2;

%%% use different operators here (+,-,*,/)
a3 = a1 / a2

a1 = [1 2]
a2 = [3 4]

%%% Now retry these operators
clc
a3 = a1 / a2

%%% * & / give "unexpected" results because they are matrix operations
%%% * gives an error due to row/column disagreement (1x2)*(1x2)
a3 = a1 * a2'
%%% / gives the "right division"

%%% Now try .* and ./
a3 = a1 ./ a2

%% Logiacl operators
clear all
%%% you will likely come across cases where you need to check if certian
%%% conditions are met. Here you can use "logical operators"
%%% == : is equal?
%%% ~= : is not equal?
%%% >=, <=, greater than or equal, less than or equal?
%%% >, <, greater than, less than?

a1 = [1 2
    3 4
    5 6]

a1 == 3

a1 ~= 3

a1 >= 3

a1 > 3

%%% You can use these logical outputs as indicies
a1(a1 ~= 3)

%% Date functions
clear all
%%% Renewable energy models tend to depend on time resolved data sources.
%%% Special funcitons exist to handle time data types.
%%% Note different date data types: serial time stamp vs, time dector, vs
%%% string

%%% "datevec" converts a serial time stamp into a date vector
%%% [year, month, day, hour, minute, second]
a1 = datevec(700.378)

%%% "datenum" converts a date vector into a serial time stamp.
a2 = datenum(a1)


%%%Both functions work with time vectors or matrixies
a1 = datevec(7000:8000);
a2 = datenum(a1);

%% Loops
%%%in many instances, you will need to repeat the same or similar
%%%calculaitons numerous times.

%%% Each loop will need an initiator command (e.x. "for ...) and a
%%% terminating "end"

%%% for loops - execute commands at each defined instance
%%%For this example, lets evaluate a function y = ax + b
a = 54;
b = 65;

for i = 1:10
    y_if(i) = a*i + b;
end


%%% While loops - execute commands as long as a certian condition is met
%%% While loops are an easy way to get stuck in an infinate loop
i = 1;

while i <= 10
    y_while(i) = a*i + b;
    i = i + 1;
end

%% Nested loops
%%%Maybe you want to do multiple calculations across multiple axis - just
%%%be careful when recording outputs
for i = 1:10
    b = 65+i;
    for ii = 1:10
        y_nested(i,ii) = a*ii + b;
    end
end

%% Logic in loops
%%% Maybe you want to do certian calculations in a loop depending on
%%% paramaters
%%% USe if/elseif/else statements
for i = 1:10
    i
    if i == 2
        a1 = 2
    elseif i == 3
        a2 = 3
    elseif i == 4
        a3 = 4
    else
    end
    pause
end

%% General Plotting
%%%Generate some data to plot
x = [0:0.01:10];
y1 = sin(x); %%%Sin and cos are taking radian inputs and converting to trig. outputs. Use sind and cosd for degreee inputs
y2 = cos(x);

%%% there are numerous useful plotting tools in MAtlab. The first, most
%%% important one is simply "plot". These are the general commands I follow
%%% to build a plot

%%%First close all figures (if you want)
close all

%%%Open a new figure
figure
%%%Initiate a hold to plot multiple things
hold on
%%%Call plotting function
plot(x,y1,'LineWidth',2) %%% you can specify plotting parameters, line line width
plot(x,y2,'LineWidth',2)
grid on %%%Turn on grid inside the figure
box on %%% turn on box outline
set(gca,'FontSize',14) %%%Two things - 1st, "get current axis", or gca, to specify parameters,
%%% 2nd, once specified, set a property, like font size
ylabel('Funciton Output','FontSize',16) %%%Specify ylabel
xlabel('Funciton Input','FontSize',16) %%%Specify xlabel
legend('sin(x)','cos(x)') %%%Specify legend

%%%If the x data is a serial time input, use the following funciton to
%%%convert serial data to readible date info
datetick('x','ddd','keepticks')

%%%Terminate figure hold 
hold off

%% Functions
clc
%%%In many instances, you will need to evaluate complex functions - like
%%%Planks equation.


%%% first lets make a function with a variable x and parameter p
fun = @(x,p) p*(exp(-exp(-(x))) - x.*(1+x.^2));

x0 = 1;
%%%Find where this equation is zero
%%% fsolve(function,initial gues x0)
fsolve(@(x) fun(x,3),x0)

%%% numerically integrate the function
%%% integral(function,lower limit, upper limit)
integral(@(x) fun(x,3),0,10)


fun(1:10,3)

%%% Numerical differentiation / gradiant
%%%Finds the gradiant across an array
gradient(fun(1:10,3))
%% More Complex Funcitons
clc
%%%In other instances, you may have a system of equations that you want to
%%%solve
fun = @(x,p) [p*exp(-exp(-(x(1)+x(2)))) - x(2)*(1+x(1)^2)
    p*x(1)*cos(x(2)) + x(2)*sin(x(1)) - 0.5]
fun([10 10],1)

x0 = [1 2];
%%%Find where this equation is zero
%%% fsolve(function,initial gues x0)
[x,fval,exitflag,output,jacobian] = fsolve(@(x) fun(x,3),x0)