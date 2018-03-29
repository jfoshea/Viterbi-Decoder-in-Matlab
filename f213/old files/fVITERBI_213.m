%============================================================================
%  fVITERBI_213.m 
%  (2,1,3)Forward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions. 
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 26th July 1999.
%===========================================================================
clear;
n=2;k=1;m=3;		
g=[1,0,1,1;1,1,1,1];

% Generate Message (Ux) 
Ux=[0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0];
N=length(Ux);

% Constraint Length L
L=m+1;
% M = Total Encoder memory, M=m for (n,1,m) encoders
M=m; 

d=input('Enter Traceback Depth, default=5 :-');
if isempty(d),
   d=5;
end;

%Define States
st0=0;st1=1;st2=2;st3=3;st4=4;st5=5;st6=6;st7=7;

T=(d*L);    
pathmem    = zeros(2^M,(T+1));
st_hist    = zeros(2^M,(T+1));% State History Table
tr_hist    = zeros(2^M,N+L); % Trellis History Table
hd         = zeros(1,n*(2^M));
acs_metric = zeros(1,2^k);
Ux_        = zeros(1,1);
MLDpath    = zeros(1,1);

acc  = zeros(1,2^M);
acc0 = zeros(1,1); acc1 = zeros(1,1); acc2 = zeros(1,1); acc3 = zeros(1,1);
acc4 = zeros(1,1); acc5 = zeros(1,1); acc6 = zeros(1,1); acc7 = zeros(1,1);

% Generate the Convolutional Encoded for transmission (Vx) 
Vx = VIT_ENC(Ux,n,k,g,N);

%  Generate the received messahe Rx from the channel
[Rx,num_bit_errors]=CHANNEL_ERRORS(Vx,n,N,L);

reply=input('Plot decoded Trellis, default=y :-');
if isempty(reply),
   plottrellis=1;
elseif reply=='n',
   plottrellis=0;
else
   plottrellis=0;
end;

%   Update metrics for the first (L-1) levels 
for t=1:L-1,
   %Determine current received n-bit from Received Message Rx
   Rx_n = Rx(n*(t-1)+1:n*t);
   %Determine Branch Metrics for current received stage bits Rx_n
   [hd]=fBMU_213(Rx_n);
   %Perform Add Select Calculations for L-1 stages
   [acc,pathmem,st_hist,tr_hist]=fACSU_213(t,k,L,hd,acc,pathmem,st_hist,tr_hist);
end;
%============= Processing for central trellis levels =================
t = t+1;
stage = t;

while t <= N+m,
   stage=t;
   if (t < T+1),
      %Determine current received n-bits from Received Message Rx
      Rx_n=Rx(n*(t-1)+1:n*t);
      %Determine Branch Metrics for current received n-bits
      [hd]=fBMU_213(Rx_n);
      %Perform ACS Calculations and update metrics & path memory units
      [acc,pathmem,st_hist,tr_hist]=fACSU_213(stage,k,L,hd,acc,pathmem,st_hist,tr_hist);
   else
      % Perform traceback read & output one decoded stage
      [Ux_, MLDpath]= fTRACEBACK_213(pathmem,acc,st_hist,Ux_,MLDpath,m,N,T,stage);
      
      % Shift window one stage left for next set of path descisions 
      pathmem(:,1:T+1) = [pathmem(:,2:T+1) pathmem(:,T+1)];
      st_hist(:,1:T+1) = [st_hist(:,2:T+1) st_hist(:,T+1)];

      %Determine current received n-bits from Received Message Rx
      Rx_n=Rx(n*(t-1)+1:n*t);
      %Determine Branch Metrics for current received stage bits, Rx
      [hd]=fBMU_213(Rx_n);
      %Perform ACS Calculations and update metrics & path memory units
      [acc,pathmem,st_hist,tr_hist]=fACSU_213(T,k,L,hd,acc,pathmem,st_hist,tr_hist);
   end;
   t=t+1;
end;

%Decode Remaining Bits
stage=t;
[Ux_, MLDpath]= fTRACEBACK_213(pathmem,acc,st_hist,Ux_,MLDpath,m,N,T,stage);
  
%Determine bit error rate
str = sprintf( 'The number of bit errors over the channel is :- ');   
disp(str); disp(num_bit_errors);
bit_error_rate=sum(abs(Ux(1,1:N)-Ux_(1,1:N)))/N;
str = sprintf( 'The receiver bit error rate (BER) is :-');
disp(str); disp(bit_error_rate);

%Plot trellis and decoded bit stream
if plottrellis==1,
   fTRELLIS_213(Ux_,MLDpath,tr_hist,n,k,m,N);
end;





