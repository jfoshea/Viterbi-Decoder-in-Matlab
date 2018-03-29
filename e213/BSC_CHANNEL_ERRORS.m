function [R]=BSC_CHANNEL_ERRORS(V,n,N,m,EbNo)
%==============================================================
% [R]=CHANNEL_ERRORS(V,n,N,m,EbNo)
% 
%  Models a Noisy BSC Channel
%  The decoder will then perform error correction by applying 
%  maximum likelihood decoding on the Received Message R.
%	 
%   John O'Shea, jfoshea@gmail.com
%==============================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

R = V;
alpha =sqrt(2*EbNo);
p=0.5*(1-erf(alpha/sqrt(2)));

error=rand(1,length(R));
error_pos=find(error<p);

for i=1:length(error_pos),
   R(error_pos(i)) = abs(R(error_pos(i))-1); %Change the bit in error
end;




