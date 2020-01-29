%% Kyle Laviana / Lab 6-1 %%

% analysis parameters
frameSize = 2^nextpow2(512);
fftSize = 2^nextpow2(frameSize*2);
hopSize = (frameSize*.5);

% signal parameters
fs = 8000;
time = 1; 
amp1 = 1;
amp2 = .2;
freq1 = 1000;
freq2 = 1200;
samples = 0:1/fs:time;

% compute signals
sinWav1 = amp1*sin(2*pi*freq1*samples);
sinWav2 = amp2*sin(2*pi*freq2*samples);
noise = amp2*randn(1, fs*time+1);
noise = (1/max(noise))*noise;

% handle concatenation
sinWav1withNoise = sinWav1 + noise;
sinWav2withNoise = sinWav2 + noise;
x = horzcat(sinWav1withNoise, sinWav2withNoise);

% execute function
sound(x, fs);
stft = myspecgram(x, fs, frameSize, hopSize, fftSize);

%% myspecgram function

function stft = myspecgram(x, fs, frameSize, hopSize, fftSize)
% STFT = myspecgram(X, FS, FRAMESIZE, HOPSIZE, DFTSIZE) returns STFT,
% the short-time Fourier transform of the real input signal X (a column)
% using a Hann window FRAMESIZE samples long, skipping HOPSIZE samples
% between frames, and using a DFT length of DFTSIZE. STFT is a matrix
% that is DFTSIZE tall, with columns containing the DFT of the windowed
% signal segments.
%
% myspecgram() also plots an image of the spectrogram, with the time and
% frequency axes labeled in seconds and Hz, respectively, according to
% the input sampling rate FS in Hz.

    signalLength = length(x);
    numWindows = signalLength/hopSize;
    numWindows = round(numWindows, 0);
    numRows = (fftSize);
    numColumns = (numWindows - 1);
    % create empty matrix
    stft = zeros(numRows, numColumns);
    windows = zeros(numRows, numColumns);
    win = hanning(frameSize);
    % iterate through windows
    for thisWindow=1 : numWindows-4   
        thisClip = x((thisWindow-1)*hopSize+1 : ((thisWindow-1)*hopSize+frameSize));   
        windowed = win.*thisClip';
        windows(1 : frameSize, thisWindow) = windowed';
    end
    stft = fft(windows);
    time = (0 : numWindows-1)*hopSize/fs;
    freqs = 0.001*(0 : fftSize-1)*fs/fftSize;
    signalAmp = 20*log10(abs(stft(1 : fftSize/2,:)));
    maxAmp = max(max(signalAmp));
    values = [maxAmp-100, maxAmp];
    figure;
    imagesc(time, freqs/2, signalAmp, values);
    axis('xy');
    c = parula(20);
    colormap(c);
    colorbar;
    ylabel('freq (kHz)');
    xlabel('time (seconds)');

end
  
%%
