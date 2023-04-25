function f=fftplot(sig, ts)

% f=fftplot(signal, ts)
%
% Plots the first half of the spectrum of the signal.
%
% ts is the sampling period. If ts is omitted, it is assumed that
%

[rows,cols] = size(sig);

if cols > rows
  sig = sig';
end

len = length(sig);

p = ceil(log(length(sig))/log(2));

n=2^p;

% Window
sig = sig.*blackman(length(sig));

% Pad
sig = [sig' zeros(n-length(sig), 1)']';

f = abs(fft(sig));

n2 = n/2;

spec = db20(f(1:n2)*2/0.42/len);% 2 is for discarding half the fft result
				% 0.42 is the Blackman window dc gain

% spec = spec - max(spec);

freq = linspace(0, (n2-1)/(ts*n), n2);

plot(freq, spec);


f=spec;

