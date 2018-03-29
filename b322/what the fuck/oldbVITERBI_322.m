%============================================================================
%  bVITERBI_322.m 
%  (3,2,2)Backward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions. 
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 26th July 1999.
%===========================================================================
clear;
n=3;k=2;m=2;		
g=[1,1,0; 0,1,0; 0,1,0; 1,0,1; 1,0,0; 1,0,1];

% Generate Message (Ux) 
Msg=[0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0;0,1,1,0,1,1,0,0,1,0,1,0,0,0,1,1,0,0,1,0];
N=length(Msg);
for i=1:N,
  Ux((i-1)*k+1:(i-1)*k+k) = flipud(Msg(:,i));
end;   


[M,L]=findmem(n,k,m,g);


d=input('Enter Traceback Depth, default=5 :-');
if isempty(d),
   d=5;
end;

%Define States
st0=0;st1=1;st2=2;st3=3;st4=4;st5=5;st6=6;st7=7;

T=(d*L);    
pathmem        = zeros(2^M,k*(d*L)+k);
tr_hist        = zeros(2^M,N+L);
hd             = zeros(1,n*(2^M));
acs_metric     = zeros(1,2^k);
Ux_            = zeros(1,1);
MLDpath        = zeros(1,1);

acc  = zeros(1,n*(2^k));
acc0 = zeros(1,1); acc1 = zeros(1,1); acc2 = zeros(1,1); acc3 = zeros(1,1);
acc4 = zeros(1,1); acc5 = zeros(1,1); acc6 = zeros(1,1); acc7 = zeros(1,1);

% Generate the Convolutional Encoded for transmission (Vx) 
Vx = VIT_ENC(Msg,n,k,g,N);

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

%==================================================
%   (1)Update partial path accumulated metrics
%   (2)Update path memory
%      - for the first (L-1) levels 
%==================================================
for t=1:L-1,
   %Determine current received n-bit from Received Message Rx
   Rx_n = Rx(n*(t-1)+1:n*t);
   %Determine Branch Metrics for current received stage bits Rx_n
   [hd]=bBMU_322(Rx_n);
   
   if t==1,
      add0(1,1)=acc0(1,1)+hd(1,1); tr_hist(st0+1,t+1)=0;
      add1(1,1)=acc0(1,1)+hd(1,2); tr_hist(st1+1,t+1)=0;
      add2(1,1)=acc0(1,1)+hd(1,3); tr_hist(st2+1,t+1)=0;
      add3(1,1)=acc0(1,1)+hd(1,4); tr_hist(st3+1,t+1)=0;
      
      acc0(1,1)=add0(1,1); pathmem(st0+1,(k*(t-1)+k)+1:(k*t)+k)=D2B(0,m);
      acc1(1,1)=add1(1,1); pathmem(st1+1,(k*(t-1)+k)+1:(k*t)+k)=D2B(0,m);
      acc2(1,1)=add2(1,1); pathmem(st2+1,(k*(t-1)+k)+1:(k*t)+k)=D2B(0,m);
      acc3(1,1)=add3(1,1); pathmem(st3+1,(k*(t-1)+k)+1:(k*t)+k)=D2B(0,m);
      acc=[acc0 acc1 acc2 acc3 acc4 acc5 acc6 acc7];
   elseif t==2,
      [acc,pathmem,tr_hist]=bACSU_322(t,k,L,hd,acc,pathmem,tr_hist);
   end;
end;
%============= Processing for central trellis levels =================
t = t+1;
stage = t;

while t <= N+m,
   stage=t;
   if t < (T+1),
      %Determine current received bits n-bit from Received Message Rx
      Rx_n=Rx(n*(t-1)+1:n*t);
      %Determine Branch Metrics for current received n-bits
      [hd]=bBMU_322(Rx_n);
      %Perform ACS Calculations and update metrics & path memory units
      [acc,pathmem,tr_hist]=bACSU_322(stage,k,L,hd,acc,pathmem,tr_hist);
   else
      % Perform traceback read & output one decoded stage
      [Ux_, MLDpath]= bTRACEBACK_322(pathmem,acc,Ux_,MLDpath,k,m,M,N,T,stage);
      
      % Shift window one stage left for next set of path descisions 
      pathmem(:,1:k*T+k) = [pathmem(:,k+1:k*T+k) pathmem(:,k*T+k-1:k*T+k)];

      %Determine current received n-bits from Received Message Rx
      Rx_n=Rx(n*(t-1)+1:n*t);
      %Determine Branch Metrics for current received stage bits, Rx
      [hd]=bBMU_322(Rx_n);
      %Perform ACS Calculations and update metrics & path memory units
      [acc,pathmem,tr_hist]=bACSU_322(T,k,L,hd,acc,pathmem,tr_hist);
   end;
   t=t+1;
end;

%Decode Remaining Bits
stage=t;
[Ux_, MLDpath]= bTRACEBACK_322(pathmem,acc,Ux_,MLDpath,k,m,M,N,T,stage);
  
%Determine bit error rate
str = sprintf( 'The number of bit errors over the channel is :- ');   
disp(str); disp(num_bit_errors);
bit_error_rate=sum(abs(Ux(1,1:N)-Ux_(1,1:N)))/N;
str = sprintf( 'The receiver bit error rate (BER) is :-');
disp(str); disp(bit_error_rate);

%Plot trellis and decoded bit stream
if plottrellis==1,
   bTRELLIS_322(decMessage,MLDpath,tr_hist,n,k,M,N);
end;





