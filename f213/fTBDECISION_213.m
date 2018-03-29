function [min_metric,tb_ptr]=bTBDECISION_213(A)
%===========================================================
% function [minmetric,tb_ptr]=bTBDECISION_213(A)
%
%	Traceback Decision Unit for (2,1,3) decoder
%
%   - Determine pointer to initial state for traceback
%     by finding the state with minimum accumulated metric
%
%   John O'Shea, jfoshea@gmail.com 16th August 2000
%   Copyright (c) 2000 John O'Shea.
%   Revision: 1.0 Date: 16th August 2000
%
%===========================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

[min_metric,tb_ptr] = min(A);
% Decrement to adjust for actual state
tb_ptr=tb_ptr-1;




