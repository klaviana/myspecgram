# myspecgram
short-time Fourier transform implemented in Matlab

STFT = myspecgram(X, FS, FRAMESIZE, HOPSIZE, DFTSIZE) returns STFT,
the short-time Fourier transform of the real input signal X (a column)
using a Hann window FRAMESIZE samples long, skipping HOPSIZE samples
between frames, and using a DFT length of DFTSIZE. STFT is a matrix
that is DFTSIZE tall, with columns containing the DFT of the windowed
signal segments.

myspecgram() also plots an image of the spectrogram, with the time and
frequency axes labeled in seconds and Hz, respectively, according to
the input sampling rate FS in Hz.

In this instance, a sample input signal takes the form of a two 1-second-long sinusoids concatenated together at a sampling rate of 8kHz. The first sinusoid has a frequency of 1.0 kHz and the second one has a frequency of 1.2 kHz. White Gaussian noise is added to the concatenated sinusoids.

Browse my other projects or learn about me at [laviana.me](https://laviana.me).
