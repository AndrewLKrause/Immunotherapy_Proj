% Geometric Parameters
L = 1; % Length of macroscale domain

% Mesh size parameters - let each solver decide this independently!
%N = 100^2; % Total number of grid points to use


% Time/space scale for simulation
T = 5000; 
tspan = linspace(0,T,1e3); % Interpolate solution on [0,T] with 1e2 points
x = linspace(0,L,N);

% Diffusion parameters
%d1=1; d2=0.0001; d3=1;
d1=0.001; d2=0.000001; d3=0.01;
 
% Kinetic parameters
muu=0.167; pu=0.69167; gu=20;
rv=1;b=1;pv=0.5555556;gv=0.1;
pw=27.778;gw=0.001;muw=55.55556;

%c = 0.05;
%su=0.04+0.1; %can be increased in steps
%sw=79.9499+20; %can be increased in steps
c=0.1; su = 0.015; sw = 100;

% Kinetic functions
f = @(u,v,w)c*v-muu*u+pu*u.*w./(gu+w)+su;
g = @(u,v,w)rv*v.*(1-b*v)-pv*u.*v./(gv+v);
h = @(u,v,w)pw*u.*v./(gw+v)-muw*w+sw;

% Index labels
uN = 1:N; vN = N+1:2*N; wN = 2*N+1:3*N;

% Steady states - TODO NEED TO DISCUSS STEADY STATE ANALYSIS CAREFULLY! FOR
% NOW, PERTURBING AROUND [0.01,1/b,0.01];
uss = 0.01; vss = 1/b; wss = 0.01;


% Create a normally distributed vector of size 3*N, mean 1, stdev 1e-2.
rng(1);
rand_vec = abs(1+1e-1*randn(3*N,1)); 

% Initial conditions for ODE system
uvH_init = [uss*rand_vec(uN);vss*rand_vec(vN); wss*rand_vec(wN)];
%uvH_init = [U(end,uN)'; U(end,vN)'; U(end,wN)'];