function [A,P]=eACSU_213(x,k,HD,A,P)
%==================================================================
%	function [A,P]=bACSU_213(x,k,HD,A,P)
%
%	Trellis stage computation for (2,1,3) backward label decoder
%
%   John O'Shea, jfoshea@gmail.com
%==================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

% Define Trellis State names
st0=0;st1=1;st2=2;st3=3;st4=4;st5=5;st6=6;st7=7;

% Generate copy of Acc for processing
A_copy = A;
%======================
%   State 0 ACS
%======================
[sel_out0, metric_out0]=eACS_213(HD(1,1),HD(1,9),A_copy(1,(st0+1)),A_copy(1,(st4+1)));

% Update State(000) Metrics
A(1,st0+1) = metric_out0;
if x > 3,
   P(st0+1,x-3) = D2B((sel_out0-1),k);
end;

%======================
%   State 1 ACS
%======================
[sel_out1, metric_out1]=eACS_213(HD(1,2),HD(1,10),A_copy(1,(st0+1)),A_copy(1,(st4+1)));

A(1,st1+1)= metric_out1;
if x > 3,
   P(st1+1,x-3) = D2B((sel_out1-1),k);
end;

      
%======================
%   State 2 ACS
%======================

[sel_out2,metric_out2]=eACS_213(HD(1,3),HD(1,11),A_copy(1,(st1+1)),A_copy(1,(st5+1)));
% Update State(010) Metrics
A(1,st2+1)= metric_out2;
if x > 3,
   P(st2+1,x-3) = D2B((sel_out2-1),k);
end;

%======================
%   State 3 ACS
%======================

[sel_out3,metric_out3]=eACS_213(HD(1,4),HD(1,12),A_copy(1,(st1+1)),A_copy(1,(st5+1)));
% Update State(011) Metrics
A(1,st3+1)= metric_out3;
if x > 3,
   P(st3+1,x-3) = D2B((sel_out3-1),k);
end;

%======================
%   State 4 ACS
%======================

[sel_out4,metric_out4]=eACS_213(HD(1,5),HD(1,13),A_copy(1,(st2+1)),A_copy(1,(st6+1)));
% Update State (100) Metrics
A(1,st4+1)= metric_out4;
if x > 3,
   P(st4+1,x-3) = D2B((sel_out4-1),k);
end;

%======================
%   State 5 ACS
%======================

[sel_out5, metric_out5]=eACS_213(HD(1,6),HD(1,14),A_copy(1,(st2+1)),A_copy(1,(st6+1)));
% Update State(101) Metrics
A(1,st5+1) = metric_out5;
if x > 3,
   P(st5+1,x-3) = D2B((sel_out5-1),k);
end;

%======================
%   State 6 ACS
%======================

[sel_out6, metric_out6]=eACS_213(HD(1,7),HD(1,15),A_copy(1,(st3+1)),A_copy(1,(st7+1)));
% Update State(110) Metrics
A(1,st6+1) = metric_out6;
if x > 3,
   P(st6+1,x-3) = D2B((sel_out6-1),k);
end;

%======================
%   State 7 ACS
%======================

[sel_out7, metric_out7]=eACS_213(HD(1,8),HD(1,16),A_copy(1,(st3+1)),A_copy(1,(st7+1)));
% Update State(111) Metrics
A(1,st7+1) = metric_out7;
if x > 3,
   P(st7+1,x-3) = D2B((sel_out7-1),k);
end;
