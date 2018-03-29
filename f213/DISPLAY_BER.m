function [D] = DISPLAY_BER(U,D,N,i)
%===================================================
%	function [D] = DISPLAY_BER(U,D,N,i)
% 
%	Initialize all data structures
%
%  John O'Shea, jfoshea@gmail.com 11th September 1999
%  Copyright (c) 1999 John O'Shea.
%  Revision: 1.0 Date: 11th September 1999
%===================================================


%Determine the number of bit errors
num_bit_errors=0;
for j=1:N,
   if xor(U,D)==1;
      num_bit_errors=num_bit_errors+1;
   end;
end;

%Determine bit error rate
bit_error_rate=sum(abs(U(1,1:N)-D(1,1:N)))/N;

str = ('==========================================');
disp(str);

str = sprintf('Pseudo Block =%d',i);
disp(str);

str = sprintf('Number of bit errors = %d,BER = %d',num_bit_errors,bit_error_rate);
disp(str);

str = ('==========================================');
disp(str);

D=[];