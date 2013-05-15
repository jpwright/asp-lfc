% For Each ADC: (Hz)
adcSampleRate = 1/((12.8-7)/10000000);
disp(['Individual ADC Sample Rate: ' num2str(adcSampleRate/1000000) ' MHz']);

% Total ADC sample rate: (Hz)
totalAdcSampleRate = 24*adcSampleRate;
disp(['Total ADC Sample Rate: ' num2str(totalAdcSampleRate/1000000) ' MHz']);

% Assuming 8 bit external adcs:
eightbitExternalAdcMinCPU = totalAdcSampleRate;
disp(['8 Bit ADC Slave Sample Rate: ' num2str(eightbitExternalAdcMinCPU/1000000) ' MHz']);

% Assuming 9-16 bit external adcs:
sixteenbitExternalAdcMinCPU = totalAdcSampleRate*2;
disp(['16 Bit ADC Slave Sample Rate: ' num2str(sixteenbitExternalAdcMinCPU/1000000) ' MHz']);

% xmega onboard: number of CPUs in 1 frame
xmegaOneFrame = 24/(32000000/adcSampleRate);
disp(['Number of XMegas/frame required: ' num2str(xmegaOneFrame)]);