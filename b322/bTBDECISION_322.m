function [min_metric,tb_ptr]=bTBDECISION_322(acc)
%===========================================================
% function [minmetric,tb_ptr]=bTBDECISION_322(acc)
%
%	Traceback Decision Unit for (3,2,2) decoder
%
%   - Determine pointer to initial state for traceback
%     by finding the state with minimum accumulated metric
%
%   John O'Shea, jfoshea@gmail.com
%===========================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

[min_metric,tb_ptr] = min(acc);
% Decrement to adjust for actual state
tb_ptr=tb_ptr-1;




