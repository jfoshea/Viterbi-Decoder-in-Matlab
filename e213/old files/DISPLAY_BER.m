function [D] = DISPLAY_BER(bit_errs,U,D,N,i)
%===================================================
%	function [D] = DISPLAY_BER(bit_errs,U,D,N)
% 
%	Initialize all data structures
%
%  John O'Shea, jfoshea@gmail.com 11th September 1999
%  Copyright (c) 1999 John O'Shea.
%  Revision: 1.0 Date: 11th September 1999
%===================================================


%Determine bit error rate

bit_error_rate=sum(abs(U(1,1:N)-D(1,1:N)))/N;

str = ('==========================================');
disp(str);

str = sprintf('Pseudo Block =%d',i);
disp(str);

str = sprintf('Number of bit errors injected =%d, BER = %d',bit_errs,bit_error_rate);
disp(str);

str = ('==========================================');
disp(str);

D=[];