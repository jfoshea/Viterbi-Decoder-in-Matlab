%============================================================================
%  eVITERBI_322.m 
%  (3,2,2)Efficient Backward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions.
%
%  The convolutional encoded block size = 456 bits
%  The Channel Model is Binary Symmetric
%  Ten 456-bit randomly generated pseudo blocks are generated to test
%  the decoding process
%
%   John O'Shea, jfoshea@gmail.com, 26th July 1999
%   Copyright (c) 1999 John O'Shea, University of Limerick.
%   Revision: 1.0 Date: 26th July 1999.
%===========================================================================
clear;
[n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbN0]=INITIALIZE;
           
%==== Cycle through each 20-bit pseudo block ====           
for i=1:k:NUM_VECTORS,
   %Read current N bit pseudo block
   msg=U_vectors(i:i+1,:);
   D=[];
   % Generate V, (Convolutional Encoded Message) for transmission 
   for i=1:N,
     U((i-1)*k+1:(i-1)*k+k) = flipud(msg(:,i));
   end;   

   V = VIT_ENC(msg,n,k,g,N);
   % Inject bit errors in to, V, to form the received message, R.
   [R]=BSC_CHANNEL(V,n,N,m,EbN0);
   %============= Processing the algorithm =================
   x=1;% Set trellis stage to 1
   while length(U) >length(D),
      %Determine the n-bit symbol, Rx, from the message, R, at the current stage
      if x<=N,
         Rx=R(n*(x-1)+1:n*x);
      end;
      %Determine all Branch Metrics for, Rx, at the current stage
      [HD]=eBMU_322(Rx);
      
      if (x <= T+(m-1)),
         %Calculate the partial path metrics and backward labels at stage x
         [A,P]=eACSU_322(x,k,HD,A,P)
      elseif (x <= N)
         % Perform traceback read & output an symbol, Dx, for one decoded stage
         [D]= eTRACEBACK_322(P,A,M,k,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:k*T) = [P(:,k+1:k*T) P(:,k*T-1:k*T)];
         %Calculate partial path metrics and backward labels at stage x
         [A,P]=eACSU_322(x,k,HD,A,P)
      else
         % Perform traceback read on the remaining n-bit symbols
         [D]= eTRACEBACK_322(P,A,M,k,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         %P(:,1:k*T) = [P(:,k+1:k*T) P(:,k*T-1:k*T)];
      end;
      x=x+1; %Increment stage pointer
   end;
   % Perform bit reversal on the decoded message, D
   D=fliplr(D);
   [D] = DISPLAY_BER(U,D,N,i);
end;





