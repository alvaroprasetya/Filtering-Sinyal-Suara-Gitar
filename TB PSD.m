% Langkah 1: Mengimpor Sinyal Suara Gitar
filename = 'gitar.wav';
 
% Menggunakan audioread untuk membaca file audio
[guitar_signal, Fs] = audioread(filename);
 
% Menggunakan hanya satu saluran jika stereo
if size(guitar_signal, 2) > 1
    guitar_signal = guitar_signal(:,1);
end
 
t = (0:length(guitar_signal)-1)/Fs;
 
figure;
plot(t, guitar_signal);
title('Sinyal Suara Gitar dengan Noise');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
 
% Langkah 2: Merancang dan Menerapkan Filter Butterworth Low Pass Filter (LPF)
cutoffFrequency_LPF = 1000; % Frekuensi cutoff (Hz)
[b_LPF, a_LPF] = butter(8, cutoffFrequency_LPF/(Fs/2), 'low');
filtered_guitar_LPF = filter(b_LPF, a_LPF, guitar_signal);
 
% Menerapkan filter Butterworth pada sinyal
filtered_guitar_Butterworth = filter(b_LPF, a_LPF, guitar_signal);

figure;
subplot(2,1,1);
plot(t, guitar_signal);
title('Sinyal Suara Gitar Asli');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

subplot(2,1,2);
plot(t, filtered_guitar_LPF);
title('Hasil Filter LPF');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

% Memutar suara sebelum dan sesudah filter low Butterworth
disp('Memutar suara gitar asli...');
sound(guitar_signal, Fs);
pause(length(guitar_signal) / Fs + 2);
 
disp('Memutar suara gitar setelah filter LPF...');
sound(filtered_guitar_LPF, Fs);
pause(length(filtered_guitar_LPF) / Fs + 2);

% Langkah 3: Merancang dan Menerapkan Filter Butterworth High Pass Filter (HPF)
cutoffFrequency_HPF = 500; % Frekuensi cutoff (Hz)
[b_HPF, a_HPF] = butter(8, cutoffFrequency_HPF/(Fs/2), 'high');
filtered_guitar_HPF = filter(b_HPF, a_HPF, guitar_signal);

% Menerapkan filter Butterworth pada sinyal
filtered_guitar_Butterworth = filter(b_HPF, a_HPF, guitar_signal);

figure;
subplot(2,1,1);
plot(t, guitar_signal);
title('Sinyal Suara Gitar Asli');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

subplot(2,1,2);
plot(t, filtered_guitar_HPF);
title('Hasil Filter HPF');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

% Memutar suara sebelum dan sesudah filter low Butterworth
disp('Memutar suara gitar asli...');
sound(guitar_signal, Fs);
pause(length(guitar_signal) / Fs + 2);
 
disp('Memutar suara gitar setelah filter HPF...');
sound(filtered_guitar_HPF, Fs);
pause(length(filtered_guitar_HPF) / Fs + 2);

% Langkah 4: Membandingkan Hasil Filtering dengan Visualisasi
figure;
subplot(3,1,1);
plot(t, guitar_signal);
title('Sinyal Suara Gitar Asli');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

subplot(3,1,2);
plot(t, filtered_guitar_LPF);
title('Hasil Filter LPF');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

subplot(3,1,3);
plot(t, filtered_guitar_HPF);
title('Hasil Filter HPF');
xlabel('Waktu (detik)');
ylabel('Amplitudo');

% Langkah 5: Visualisasi spektrum frekuensi
figure;
subplot(3,1,1);
pwelch(guitar_signal, [], [], [], Fs);
title('Spektrum Frekuensi Sinyal Suara Gitar dengan Noise');
 
subplot(3,1,2);
pwelch(filtered_guitar_Butterworth, [], [], [], Fs);
title('Spektrum Frekuensi Setelah Filter Butterworth');

subplot(3,1,3);
pwelch(filtered_guitar_Butterworth, [], [], [], Fs);
title('Spektrum Frekuensi Setelah Filter Butterworth');