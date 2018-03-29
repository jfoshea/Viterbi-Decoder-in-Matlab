function [acc,pathmem,st_hist,tr_hist]=fACSU_213(stage,k,L,hd,acc,pathmem,st_hist,tr_hist)
%==========================================================================================
%	function [acc,pathmem,st_hist,tr_hist]=fACSU_213(stage,k,L,hd,acc,pathmem,st_hist,tr_hist)
%
%	Trellis stage 1 Add - 
%  of (2,1,3) forward label decoder
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
[sel_out0, metric_out0]=fACS_213(stage,L,hd(1,1),hd(1,9),acc_copy(1,(st0+1)),acc_copy(1,(st4+1)));

% Update State(000) Metrics
acc(1,st0+1) = metric_out0;
pathmem(st0+1,stage+1) = 0;
switch (sel_out0)
   case 1, tr_hist(st0+1,stage+1) = st0; st_hist(st0+1,stage+1) = st0;
   case 2, tr_hist(st0+1,stage+1) = st4; st_hist(st0+1,stage+1) = st4;
end;

%======================
%   State 1 ACS
%======================
[sel_out1, metric_out1]=fACS_213(stage,L,hd(1,2),hd(1,10),acc_copy(1,(st0+1)),acc_copy(1,(st4+1)));

% Update State(001) Metrics
acc(1,st1+1)= metric_out1;
pathmem(st1+1,stage+1) = 1;
switch(sel_out1)
   case 1, tr_hist(st1+1,stage+1) = st0; st_hist(st1+1,stage+1) = st0;
   case 2, tr_hist(st1+1,stage+1) = st4; st_hist(st1+1,stage+1) = st4;
end;

      
%======================
%   State 2 ACS
%======================

if stage > 1,
   [sel_out2,metric_out2]=fACS_213(stage,L,hd(1,3),hd(1,11),acc_copy(1,(st1+1)),acc_copy(1,(st5+1)));
   % Update State(010) Metrics
   acc(1,st2+1)= metric_out2;
   pathmem(st2+1,stage+1) = 0;
   switch(sel_out2)
      case 1, tr_hist(st2+1,stage+1) = st1; st_hist(st2+1,stage+1) = st1;
      case 2, tr_hist(st2+1,stage+1) = st5; st_hist(st2+1,stage+1) = st5;
   end;
end   

%======================
%   State 3 ACS
%======================

if stage > 1,
   [sel_out3,metric_out3]=fACS_213(stage,L,hd(1,4),hd(1,12),acc_copy(1,(st1+1)),acc_copy(1,(st5+1)));
   % Update State(011) Metrics
   acc(1,st3+1)= metric_out3;
   pathmem(st3+1,stage+1) = 1;
   switch(sel_out3)   
      case 1, tr_hist(st3+1,stage+1) = st1; st_hist(st3+1,stage+1) = st1;
      case 2, tr_hist(st3+1,stage+1) = st5; st_hist(st3+1,stage+1) = st5;
   end;
end

%======================
%   State 4 ACS
%======================

if stage > 2,
   [sel_out4,metric_out4]=fACS_213(stage,L,hd(1,5),hd(1,13),acc_copy(1,(st2+1)),acc_copy(1,(st6+1)));
   % Update State (100) Metrics
   acc(1,st4+1)= metric_out4;
   pathmem(st4+1,stage+1) = 0;
   switch(sel_out4)
     case 1, tr_hist(st4+1,stage+1) = st2; st_hist(st4+1,stage+1) = st2;
     case 2, tr_hist(st4+1,stage+1) = st6; st_hist(st4+1,stage+1) = st6;
   end;
end;

%======================
%   State 5 ACS
%======================

if stage > 2,
   [sel_out5, metric_out5]=fACS_213(stage,L,hd(1,6),hd(1,14),acc_copy(1,(st2+1)),acc_copy(1,(st6+1)));
   % Update State(101) Metrics
   acc(1,st5+1) = metric_out5;
   pathmem(st5+1,stage+1) = 1;
   switch(sel_out5)
     case 1, tr_hist(st5+1,stage+1) = st2; st_hist(st5+1,stage+1) = st2;
     case 2, tr_hist(st5+1,stage+1) = st5; st_hist(st5+1,stage+1) = st6;
   end;
end;

%======================
%   State 6 ACS
%======================

if stage > 2,
   [sel_out6, metric_out6]=fACS_213(stage,L,hd(1,7),hd(1,15),acc_copy(1,(st3+1)),acc_copy(1,(st7+1)));
   % Update State(110) Metrics
   acc(1,st6+1) = metric_out6;
   pathmem(st6+1,stage+1) = 0;
   switch(sel_out6)
      case 1, tr_hist(st6+1,stage+1) = st3; st_hist(st6+1,stage+1) = st3;
      case 2, tr_hist(st6+1,stage+1) = st7; st_hist(st6+1,stage+1) = st7;
   end;
end;

%======================
%   State 7 ACS
%======================

if stage > 2,
   [sel_out7, metric_out7]=fACS_213(stage,L,hd(1,8),hd(1,16),acc_copy(1,(st3+1)),acc_copy(1,(st7+1)));
   % Update State(111) Metrics
   acc(1,st7+1) = metric_out7;
   pathmem(st7+1,stage+1) = 1;
   switch(sel_out7)
      case 1, tr_hist(st7+1,stage+1) = st3; st_hist(st7+1,stage+1) = st3;
      case 2, tr_hist(st7+1,stage+1) = st7; st_hist(st7+1,stage+1) = st7;
   end;
end;