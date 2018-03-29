%============================================================================
%  bVITERBI_213.m 
%  (2,1,3)Backward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions.
%
%  The convolutional encoded block size = 456 bits
%  The Channel Model is Binary Symmetric
%  Ten 456-bit randomly generated pseudo blocks are generated to test
%  the decoding process
%
%   John O'Shea, jfoshea@gmail.com
%===========================================================================
clear;
[n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbN0]=INITIALIZE;
           
%==== Cycle through each 20-bit pseudo block ====           
for i=1:NUM_VECTORS,
   %Read current N bit pseudo block
   [U]=U_vectors(i,:);
   % Generate V, (Convolutional Encoded Message) for transmission 
   V = VIT_ENC(U,n,k,g,N);
   % Inject bit errors in to, V, to form the received message, R.
   [R]=BSC_CHANNEL(V,n,N,m,EbN0);
   %============= Processing the algorithm =================
   x=1;% Set trellis stage to 1
   while N >length(D),
      %Determine the n-bit symbol, Rx, from the message, R, at the current stage
      if x<=N+m,
         Rx=R(n*(x-1)+1:n*x);
      end;
      %Determine all Branch Metrics for, Rx, at the current stage
      [HD]=bBMU_213(Rx);
      
      if (x <= T),
         %Calculate the partial path metrics and backward labels at stage x
         [A,P]=bACSU_213(x,k,m,HD,A,P);
      elseif (x <= N+m)
         % Perform traceback read & output an symbol, Dx, for one decoded stage
         [D]= bTRACEBACK_213(P,A,m,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:T) = [P(:,2:T) P(:,T)];
         %Calculate partial path metrics and backward labels at stage x
         [A,P]=bACSU_213(T,k,m,HD,A,P);
      else
         % Perform traceback read on the remaining n-bit symbols
         [D]= bTRACEBACK_213(P,A,m,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:T) = [P(:,2:T) P(:,T)];
      end;
      x=x+1; %Increment stage pointer
   end;
   % Perform bit reversal on the decoded message, D
   D=fliplr(D);
   [D] = DISPLAY_BER(U,D,N,i);
end;





