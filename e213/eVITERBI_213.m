%============================================================================
%  eVITERBI_213.m 
%  (2,1,3)Efficient Backward Label Viterbi Decoder.
%
%  This MATLAB routine performs forward error correction using the
%  Viterbi decoding algorithm on the Message based on hard decisions. 
%
%   John O'Shea, jfoshea@gmail.com
%===========================================================================
clear;
[n,k,m,g,M,bit_errs,D,T,A,P,HD,PPM,U_vectors,NUM_VECTORS,N,EbNo]=INITIALIZE;
         
%==== Cycle through each 20-bit pseudo block ====           
for i=1:NUM_VECTORS,
   %Read current N bit pseudo block
   U =U_vectors(i,:);
   % Generate V, (Convolutional Encoded Message) for transmission 
   V = VIT_ENC(U,n,k,g,N);
   % Inject bit errors in to, V, to form the received message, R.
   [R]=BSC_CHANNEL_ERRORS(V,n,N,m,EbNo);
   %============= Processing the algorithm =================
   x=1;% Set trellis stage to 1
   while N >length(D),
      %Determine the n-bit symbol, Rx, from the message, R, at the current stage
      if x<=N+m,
         Rx=R(n*(x-1)+1:n*x);
      end;
      %Determine all Branch Metrics for, Rx, at the current stage
      [HD]=eBMU_213(Rx);
      
      if (x <= T),
         %Calculate the partial path metrics and backward labels at stage x
         [A,P]=eACSU_213(x,k,HD,A,P);         
      elseif (x <= N+m)
         % Perform traceback read & output an symbol, Dx, for one decoded stage
         [D]= eTRACEBACK_213(P,A,m,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:T-m) = [P(:,2:T-m) P(:,T-m)];
         %Calculate partial path metrics and backward labels at stage x
         [A,P]=eACSU_213(T,k,HD,A,P);
      else
         % Perform traceback read on the remaining n-bit symbols
         [D]= eTRACEBACK_213(P,A,m,D,N,T,x);
         % Shift window k stage's left for next set of path descisions 
         P(:,1:T-m) = [P(:,2:T-m) P(:,T-m)];
      end;
      x=x+1; %Increment stage pointer
   end;
   % Perform bit reversal on the decoded message, D
   D=fliplr(D);
   [D] = DISPLAY_BER(U,D,N,i);
end;





