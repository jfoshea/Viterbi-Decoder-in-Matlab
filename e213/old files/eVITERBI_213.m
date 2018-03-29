%============================================================================
%  eVITERBI_213.m 
%  (2,1,3)Efficient Backward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions. 
%
%   John O'Shea, jfoshea@gmail.com, 26th July 1999
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 26th July 1999.
%===========================================================================
clear;
[n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N]=eINITIALIZE_213;
           
%==== Cycle through each 20-bit pseudo block ====           
for i=1:NUM_VECTORS,
   %Read current N bit pseudo block
   U=U_vectors(i,:);
   % Generate V, (Convolutional Encoded Message) for transmission 
   V = VIT_ENC(U,n,k,g,N);
   % Inject bit errors in to, V, to form the received message, R.
   [R]=CHANNEL_ERRORS(bit_errs,V,n,N,m);
   %============= Processing the algorithm =================
   x=1;% Set trellis stage to 1
   while N >length(D),
      %Determine current received n-bit symbol, Rx
      Rx=R(n*(x-1)+1:n*x);
      %Determine Branch Metrics for current received symbol Rx
      [HD]=eBMU_213(Rx);
      
      if (x-m <= T),
         %Calculate the partial path metrics and backward labels at stage x
         [A,P]=eACSU_213(x,k,m,HD,A,P,T);
      else
         % Perform traceback read & output an symol, Dx, for one decoded stage
         [D]= eTRACEBACK_213(P,A,m,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:T) = [P(:,2:T) P(:,T)];
         %Calculate partial path metrics and backward labels at stage x
         [A,P]=eACSU_213(T,k,m,HD,A,P,T);
      end;
      x=x+1; %Increment stage pointer
      if (x>=N+m),
         x=N+m;
      end;
   end;
   
   [D] = DISPLAY_BER(bit_errs,U,D,N,i);
end;





