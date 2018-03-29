function [R]=BSC_CHANNEL(V,n,N,m,EbN0)
%==============================================================
% [R]=BSC_CHANNEL(V,n,N,m,EbN0)
% 
%  Models a Noisy BSC Channel
%  The decoder will then perform error correction by applying 
%  maximum likelihood decoding on the Received Message R.
%	 
%   John O'Shea, jfoshea@gmail.com 11th September 1999
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 11th September 1999
%==============================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

R = V;

% Model the bit error probaility over a BSC channel.

p=0.5*(erfc(sqrt(2*EbN0)/sqrt(2))); 
%Generate A random message of length of R = N
error=rand(1,length(R));
% Find the symbol positions that are less than the transition probability p
error_pos=find(error<p);
% For every symbol position < p, change the bit in error
for i=1:length(error_pos),
   R(error_pos(i)) = abs(R(error_pos(i))-1); %Change the bit in error
end;




