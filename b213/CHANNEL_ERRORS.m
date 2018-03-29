function [Rx]=CHANNEL_ERRORS(bit_errs,Vx,n,N,m)
%===================================================================
%	[Rx,]=CHANNEL_ERRORS(bit_errs,Vx,n,N,m)
% 
%	Generates a random number of bit errors on the Transmitted Message Vx
%  in the Received Message Rx
%  The decoder will then perform error correction by applying 
%  maximum likelihood decoding on the Received Message Rx.
%	 
%   John O'Shea, jfoshea@gmail.com
%===================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

Rx = Vx;

if (bit_errs~=0 & bit_errs< N),
   for i=1:num_bit_errors,
      bit=(ceil(rand(1,1)*N));
      Rx(1,bit)=bitcmp(Vx(1,bit),1);
   end;
end;



