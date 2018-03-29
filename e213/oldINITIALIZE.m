function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbNo]=INITIALIZE
%====================================================================================
%	function [n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbNo]=INITIALIZE
% 
%	Initialize all data structures
%
%  John O'Shea, jfoshea@gmail.com
%====================================================================================

n=2;k=1;m=3;		
g=[1,0,1,1;1,1,1,1];

% M = Total Encoder memory, M=m for (n,1,m) encoders
M=m; 
bit_errs=0;
D=[];
EbNo=10;
T=(5*m)-m;    
%Initialiaze the Accumulated path metric memory, (A)
A          = zeros(1,2^M);
%Initialiaze the path memory, (P)
P          = zeros(2^M,k*T);
%Initialiaze the Branch Metrics look-up memory, (HD)
HD         = zeros(1,n*(2^M));
%Initialiaze the 2^k partial path metric memory for compare & select, (PPM)
PPM        = zeros(1,2^k);

N=225;
%N=20;
NUM_VECTORS=10;
U_vectors=zeros(NUM_VECTORS,N);
for v=1:10,
   p=0.5;
   bits=rand(1,N);
   pos=find(bits<p);
   for i=1:length(pos),
      U_vectors(v,pos(i)) = abs(U_vectors(v,pos(i))-1); %Change the bit in error
   end;
end;

%U_vectors=[0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0;
%   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
%   0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0;
%   0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1;
%   0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0;
%   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1;
%   0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0;
%   0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1;
%   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0;
%   1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0];
