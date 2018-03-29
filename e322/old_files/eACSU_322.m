function [acc,pathmem,tr_hist]=eACSU_322(stage,k,L,hd,acc,pathmem,tr_hist)
%==========================================================================================
%	function [acc,pathmem,tr_hist]=eACSU_322(stage,k,hd,acc,pathmem,tr_hist)
%           
%	Add-Compare-Select Unit for entire (3,2,2)trellis stage 
%  of efficient backward label decoder
%
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 16th August 1999
%
%==========================================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

% Define Trellis State names
st0=0;st1=1;st2=2;st3=3;st4=4;st5=5;st6=6;st7=7;

% Generate copy of Acc for processing
acc_copy = acc;
%======================
%   State 0 ACS
%======================
[sel_out0, metric_out0]=eACS_322(stage,L,hd(1,1),hd(1,5),hd(1,17),hd(1,21),acc_copy(1,(st0+1)),acc_copy(1,(st1+1)),acc_copy(1,(st4+1)),acc_copy(1,(st5+1)));

% Update State(000) Metrics and trellis history
acc(1,st0+1) = metric_out0;
if stage+L-1 >= L,
   pathmem(st0+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out0-1),k);
end;
switch(sel_out0),
   case 1, tr_hist(st0+1,stage+L) = st0;
   case 2, tr_hist(st0+1,stage+L) = st1;
   case 3, tr_hist(st0+1,stage+L) = st4;
   case 4, tr_hist(st0+1,stage+L) = st5;
end;

%======================
%   State 1 ACS
%======================
[sel_out1, metric_out1]=eACS_322(stage,L,hd(1,2),hd(1,6),hd(1,18),hd(1,22),acc_copy(1,(st0+1)),acc_copy(1,(st1+1)),acc_copy(1,(st4+1)),acc_copy(1,(st5+1)));

% Update State(001) Metrics and trellis history
acc(1,st1+1)= metric_out1;
if stage+L-1 >= L,
   pathmem(st1+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out1-1),k);
end;
switch(sel_out1),
   case 1, tr_hist(st1+1,stage+L) = st0;
   case 2, tr_hist(st1+1,stage+L) = st1;
   case 3, tr_hist(st1+1,stage+L) = st4;
   case 4, tr_hist(st1+1,stage+L) = st5;
end;

%======================
%   State 2 ACS
%======================
[sel_out2, metric_out2]=eACS_322(stage,L,hd(1,3),hd(1,7),hd(1,19),hd(1,23),acc_copy(1,(st0+1)),acc_copy(1,(st1+1)),acc_copy(1,(st4+1)),acc_copy(1,(st5+1)));

% Update State(010) Metrics
acc(1,st2+1)= metric_out2;
if stage+L-1 >= L,
   pathmem(st2+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out2-1),k);
end;
switch(sel_out2),
   case 1, tr_hist(st2+1,stage+L) = st0;
   case 2, tr_hist(st2+1,stage+L) = st1;
   case 3, tr_hist(st2+1,stage+L) = st4;
   case 4, tr_hist(st2+1,stage+L) = st5;
end;

%======================
%   State 3 ACS
%======================
[sel_out3, metric_out3]=eACS_322(stage,L,hd(1,4),hd(1,8),hd(1,20),hd(1,24),acc_copy(1,(st0+1)),acc_copy(1,(st1+1)),acc_copy(1,(st4+1)),acc_copy(1,(st5+1)));

% Update State(011) Accumulated Metrics
acc(1,st3+1)= metric_out3;
if stage+L-1 >= L,
   pathmem(st3+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out3-1),k);
end;
switch(sel_out3),
   case 1, tr_hist(st3+1,stage+L) = st0;
   case 2, tr_hist(st3+1,stage+L) = st1;
   case 3, tr_hist(st3+1,stage+L) = st4;
   case 4, tr_hist(st3+1,stage+L) = st5;
end;

%======================
%   State 4 ACS
%======================
[sel_out4, metric_out4]=eACS_322(stage,L,hd(1,9),hd(1,13),hd(1,25),hd(1,29),acc_copy(1,(st2+1)),acc_copy(1,(st3+1)),acc_copy(1,(st6+1)),acc_copy(1,(st7+1)));

% Update State (100) Metrics
acc(1,st4+1)= metric_out4;
if stage+L-1 >= L,
   pathmem(st4+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out4-1),k);
end;
switch(sel_out4),
   case 1, tr_hist(st4+1,stage+L) = st2;
   case 2, tr_hist(st4+1,stage+L) = st3;
   case 3, tr_hist(st4+1,stage+L) = st6;
   case 4, tr_hist(st4+1,stage+L) = st7;
end;

%======================
%   State 5 ACS
%======================
[sel_out5, metric_out5]=eACS_322(stage,L,hd(1,10),hd(1,14),hd(1,26),hd(1,30),acc_copy(1,(st2+1)),acc_copy(1,(st3+1)),acc_copy(1,(st6+1)),acc_copy(1,(st7+1)));

% Update State(101) Metrics
acc(1,st5+1) = metric_out5;
if stage+L-1 >= L,
   pathmem(st5+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out5-1),k);
end;
switch(sel_out5),
   case 1, tr_hist(st5+1,stage+L) = st2;
   case 2, tr_hist(st5+1,stage+L) = st3;
   case 3, tr_hist(st5+1,stage+L) = st6;
   case 4, tr_hist(st5+1,stage+L) = st7;
end;

%======================
%   State 6 ACS
%======================
[sel_out6, metric_out6]=eACS_322(stage,L,hd(1,11),hd(1,15),hd(1,27),hd(1,31),acc_copy(1,(st2+1)),acc_copy(1,(st3+1)),acc_copy(1,(st6+1)),acc_copy(1,(st7+1)));

% Update State(110) Metrics
acc(1,st6+1) = metric_out6;
if stage+L-1 >= L,
   pathmem(st6+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out6-1),k);
end;
switch(sel_out6),
   case 1, tr_hist(st6+1,stage+L) = st2;
   case 2, tr_hist(st6+1,stage+L) = st3;
   case 3, tr_hist(st6+1,stage+L) = st6;
   case 4, tr_hist(st6+1,stage+L) = st7;
end;


%======================
%   State 7 ACS
%======================
[sel_out7, metric_out7]=eACS_322(stage,L,hd(1,12),hd(1,16),hd(1,28),hd(1,32),acc_copy(1,(st2+1)),acc_copy(1,(st3+1)),acc_copy(1,(st6+1)),acc_copy(1,(st7+1)));

% Update State(111) Metrics
acc(1,st7+1) = metric_out7;
if stage+L-1 >= L,
   pathmem(st7+1,(k*(stage-1)+k)+1:(k*stage)+k) = D2B((sel_out7-1),k);
end;
switch(sel_out7),
   case 1, tr_hist(st7+1,stage+L) = st2;
   case 2, tr_hist(st7+1,stage+L) = st3;
   case 3, tr_hist(st7+1,stage+L) = st6;
   case 4, tr_hist(st7+1,stage+L) = st7;
end;
