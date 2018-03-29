function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N]=eINITIALIZE_213
%====================================================================================
%	function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N]=eINITIALIZE_213
% 
%	Initialize all data structures
%
%  John O'Shea, jfoshea@gmail.com 11th September 1999
%  Copyright (c) 1999 John O'Shea.
%  Revision: 1.0 Date: 11th September 1999
%====================================================================================


n=2;k=1;m=3;		
g=[1,0,1,1;1,1,1,1];

% M = Total Encoder memory, M=m for (n,1,m) encoders
M=m; 
bit_errs=0;
D=[];

T=(5*m);    
%Initialiaze the Accumulated path metric memory, (A)
A          = zeros(1,2^M);
%Initialiaze the path memory, (P)
P          = zeros(2^M,k*T-m);
%Initialiaze the Branch Metrics look-up memory, (HD)
HD         = zeros(1,n*(2^M));
%Initialiaze the 2^k partial path metric memory for compare & select, (PPM)
PPM        = zeros(1,2^k);

U_vectors = [0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0;
             0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
             1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0;
             0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
             0,0,0,1,1,0,1,1,0,0,0,1,1,0,1,1,0,0,0,1;
             0,0,1,0,0,0,1,1,1,0,1,0,1,1,0,0,0,1,1,0;
             0,0,0,1,0,0,1,0,0,0,1,1,0,1,0,0,0,1,0,1;
             0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0;
             0,1,0,1,0,1,0,0,0,0,1,1,0,0,1,0,0,0,0,1;
             1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
           
[NUM_VECTORS,N]=size(U_vectors);           
