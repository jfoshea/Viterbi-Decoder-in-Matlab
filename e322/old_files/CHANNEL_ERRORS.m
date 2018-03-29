function [Rx,num_bit_errors]=CHANNEL_ERRORS(Vx,n,N,L)
%===================================================================
%	[Rx,num_bit_errors]=CHANNEL_ERRORS(Vx,n,N,L)
% 
%	Generates a random number of bit errors on the Transmitted Message Vx
%  in the Received Message Rx
%  The decoder will then perform error correction by applying 
%  maximum likelihood decoding on the Received Message Rx.
%	 
%   John O'Shea, jfoshea@gmail.com 11th September 1999
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 11th September 1999
%===================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

Rx = Vx;
% Randomly generate "num_bit_errors" - The number of bits in error
% Maximum is e=5
ans=input('Inject up to 5 random bit errors (y/n) :-','s');
if isempty(ans),
   num_bit_errors=(round(rand(1,1)*5));
elseif ans=='y',
   num_bit_errors=(round(rand(1,1)*5));
else
   num_bit_errors=0;
end;

if (num_bit_errors~=0 & num_bit_errors< N),
   for i=1:num_bit_errors,
      bit=(ceil(rand(1,1)*N));
      Rx(1,bit)=bitcmp(Vx(1,bit),1);
   end;
else
   num_bit_errors=0;   
end;



