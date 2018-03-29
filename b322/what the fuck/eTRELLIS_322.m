function bTRELLIS_322(Ux_,MLDpath,trellishistory,n,k,m,N)
%===================================================================================
%	function bTRELLIS_322(Ux_,MLDpath,trellishistory,n,k,m,N)
%
%	1. Plot the trellis survivors
%  
%  2. Plot the final surviving MLD path
%
%	3. Plot the decoded bit stream 
%	
%   John O'Shea, jfoshea@gmail.com
%   Copyright (c) 1999 John O'Shea.
%   Revision: 1.0 Date: 26th August 1999
%===============================================================================

if nargin==0, 
   error('Not enough input arguments.'); 
end;

figure;
subplot(211);

x = 1:N+m+1;y = 0:2^m-1;

for i=1:N+m+1,
   for j=1:2^m,
     plot(x(i),y(j),'k.');%plot all states over time
     hold on;
   end;
end;
axis([0 N+m+2 -1 2^m]);
xlabel('(2,1,3) Efficient Backward Label Decoder survivors and M.L.D. path');
   
%  Plot for first L-1 levels
cs=0; ns=[];

for t=1:m,
   for i=1:length(cs),
      for j=1:2^k,
         ns(1,j)=nsTable(cs(i)+1,j);
         x = [t t+1];y = [2^m-(cs(i)+1) 2^m-(ns(1,j)+1)];
         plot(x,y,'c-');
         hold on;
      end;
   end;
   y = [(2^m-(MLDpath(t)+1)) (2^enc_mem-(MLDpath(t+1)+1))];
   plot(x,y,'r-');
   hold on;
   if t==1,
      cs=[ns];ns = [];
   else
      cs = [cs ns];ns=[];
   end;
end;

%   Plot for central part of trellis
t=N+m;
cs=0; ns=[];
while t>m,
   for s=1:2^m,
      cs=trellishistory(s,t);
      for j=1:2^k,
         ns(1,j)=nsTable(1,j);
         x = [t t+1];
         y = [2^m-(cs+1) 2^m-s];
         plot(x,y,'c-');
         hold on;
      end;
   end;
   y = [(2^m-(MLDpath(t)+1)) (2^m-(MLDpath(t+1)+1))];
   plot(x,y,'r-');
   hold on;
   t=t-1;
end;


%Plot decoded bit stream
subplot(212);
x = 1:length(Ux_)+1; y = 0:1;

for i=1:length(Ux_)+1,
  for j=1:2,
    plot(x(i),y(j),'');
    hold on;
 end;
end;
axis([0 length(Ux_)+2 -1 2]);
xlabel ('Efficient Backward Label Viterbi Decoder output bit stream');

for t=1:length(Ux_),
   if t==1,
      if Ux_(t)==0,
        x = [t t+1]; y = [0 0];
        plot(x,y,'r-');
        hold on;
     elseif Ux_(t)==1,
        x = [t t+1]; y = [1 1];
        plot(x,y,'r-');
        hold on;
      end;
   elseif t~=1,
      if Ux_(t-1)==1 & Ux_(t)==0,
        x = [t t]; y = [1 0];
        plot(x,y,'r-');
        hold on;
        x = [t t+1]; y = [0 0];
        plot(x,y,'r-');
        hold on;
      elseif Ux_(t-1)==1 & Ux_(t)==1,
        x = [t t+1];y = [1 1];
        plot(x,y,'r-');
        hold on;  
      elseif Ux_(t-1)==0 & Ux_(t)==1,
        x=[t t];y=[0 1];
        plot(x,y,'r-');
        hold on;
        x = [t t+1];y = [1 1];
        plot(x,y,'r-');
        hold on;
      elseif Ux_(t-1)==0 & Ux_(t)==0,
        x = [t t+1];y = [0 0];
        plot(x,y,'r-');
        hold on;  
      end;
   end;  
end;
hold off;

