function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbN0]=INITIALIZE
%====================================================================================
%	function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbN0]=INITIALIZE
% 
%	Initialize all data structures
%
%  John O'Shea, jfoshea@gmail.com 11th September 1999
%====================================================================================


n=2;k=1;m=3;		
g=[1,0,1,1;1,1,1,1];

% M = Total Encoder memory, M=m for (n,1,m) encoders
M=m; 
bit_errs=0;
D=[];
EbN0=10;
T=(5*m);    
%Initialiaze the Accumulated path metric memory, (A)
A0          = 0;
A1          = 15;
A2          = 15;
A3          = 15;
A4          = 15;
A5          = 15;
A6          = 15;
A7          = 15;

A = [A0 A1 A2 A3 A4 A5 A6 A7];

%Initialiaze the path memory, (P)
P          = zeros(2^M,k*T);
%Initialiaze the Branch Metrics look-up memory, (HD)
HD         = zeros(1,n*(2^M));
%Initialiaze the 2^k partial path metric memory for compare & select, (PPM)
PPM        = zeros(1,2^k);

%N=225;
N=20;
NUM_VECTORS=10;
U_vectors=zeros(NUM_VECTORS,N);
%for v=1:10,
%   U_vectors(v,:) = ceil(rand(1,N)-0.5);
%end;

U_vectors=[0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0;
   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
   0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0;
   0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1;
   0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0;
   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
   0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0;
   0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1;
   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0;
   1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0];

