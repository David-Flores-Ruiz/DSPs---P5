%%%%%%%%%%%%%%% P5 de DSP's: "GEN... %%%%%%%%%%%%%%%%
%                                DE UNA ..."                   %
% Implementar un sistema ,
% sobre una señal.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  DEFINES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%% Lectura de los  3 archivos .mat proporcionados %%%%%%%%%%%%%%  
%%%%%%%%%%%%%%    con sus 3 variables: fs,  x_ir  y  x_red  %%%%%%%%%%%%%%%
Struct_oxi1 = load('oxi1.mat');
Struct_oxi2 = load('oxi2.mat');
Struct_oxi3 = load('oxi3.mat');

Fs = Struct_oxi1.fs;
fprintf('Valor de frecuencia de muestreo: ');	disp(Fs);

sizeOxi1 = length(Struct_oxi1.x_ir);      % Es igual a: x_red
sizeOxi2 = length(Struct_oxi2.x_ir);      % Es igual a: x_red
sizeOxi3 = length(Struct_oxi3.x_ir);      % Es igual a: x_red

fprintf('Tamaño del arreglo Oxi1:  ');      disp(sizeOxi1);
fprintf('Tamaño del arreglo Oxi2:  ');      disp(sizeOxi2);
fprintf('Tamaño del arreglo Oxi3:  ');      disp(sizeOxi3);

step = 1/Fs;          % Paso de tiempo de 1/25Hz = 40ms
t1 = 0:step:(step*(sizeOxi1-1)); % Duración de n muestras en segundos: Oxi1
t2 = 0:step:(step*(sizeOxi2-1)); % Duración de n muestras en segundos: Oxi2
t3 = 0:step:(step*(sizeOxi3-1)); % Duración de n muestras en segundos: Oxi3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%% TRANSFORMADAS DE FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%
nfft1 = sizeOxi1;         % el numero de puntos de la fft
step1_W = Fs/(nfft1-1); % frecuencia de muestreo / el numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom1_W  = 0 : step1_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
X_ir1_w   = abs( fft(Struct_oxi1.x_ir, nfft1) );
X_red1_w  = abs( fft(Struct_oxi1.x_red,nfft1) );
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
nfft2 = sizeOxi2;         % el numero de puntos de la fft
step2_W = Fs/(nfft2-1); % frecuencia de muestreo / el numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom2_W  = 0 : step2_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
X_ir2_w   = abs( fft(Struct_oxi2.x_ir, nfft2) );
X_red2_w  = abs( fft(Struct_oxi2.x_red,nfft2) );
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
nfft3 = sizeOxi3;         % el numero de puntos de la fft
step3_W = Fs/(nfft3-1); % frecuencia de muestreo / el numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom3_W  = 0 : step3_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
X_ir3_w   = abs( fft(Struct_oxi3.x_ir, nfft3) );
X_red3_w  = abs( fft(Struct_oxi3.x_red,nfft3) );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se GRAFICA las salidas de cada uno de los 3 archivos originales
figure(1);  % Grafica de la señal orginal de cada archivo
subplot(2, 3, 1) % Varias Graficas (2 filas, 3 columnas, 1ra posición)
plot(t1,Struct_oxi1.x_ir)  % Señal original: Oxi1
title('IR - señal 1') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 4) % Varias Graficas (2 filas, 3 columnas, 4ta posición)
plot(t1,Struct_oxi1.x_red)  % Señal original: Oxi1
title('RED - señal 1 (BPM)') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 2) % Varias Graficas (2 filas, 3 columnas, 2da posición)
plot(t2,Struct_oxi2.x_ir)  % Señal original: Oxi2
title('IR - señal 2') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 5) % Varias Graficas (2 filas, 3 columnas, 5ta posición)
plot(t2,Struct_oxi2.x_red)  % Señal original: Oxi2
title('RED - señal 2 (BPM)') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 3) % Varias Graficas (2 filas, 3 columnas, 3ra posición)
plot(t3,Struct_oxi3.x_ir)  % Señal original: Oxi3
title('IR - señal 3') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 6) % Varias Graficas (2 filas, 3 columnas, 6ta posición)
plot(t3,Struct_oxi3.x_red)  % Señal original: Oxi3
title('RED - señal 3 (BPM)') % Titulo del gráfico
xlabel('tiempo (s)') % Nombre del eje X
ylabel('Amplitud Am')% Nombre del eje Y
grid on % Cuadrícula Activada
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
% Se GRAFICA las TF para cada uno de los 3 archivos originales
figure(2);  % TF de cada señal de cada archivo
subplot(2, 3, 1) % Varias Graficas (2 filas, 3 columnas, 1ra posición)
plot(dom1_W,X_ir1_w)  % Señal original: Oxi1
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 1') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 4) % Varias Graficas (2 filas, 3 columnas, 4ta posición)
plot(dom1_W,X_red1_w)  % Señal original: Oxi1
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 1 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 2) % Varias Graficas (2 filas, 3 columnas, 2da posición)
plot(dom2_W,X_ir2_w)  % Señal original: Oxi2
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 2') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 5) % Varias Graficas (2 filas, 3 columnas, 5ta posición)
plot(dom2_W,X_red2_w)  % Señal original: Oxi2
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 2 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 3) % Varias Graficas (2 filas, 3 columnas, 3ra posición)
plot(dom3_W,X_ir3_w)  % Señal original: Oxi3
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 3') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 6) % Varias Graficas (2 filas, 3 columnas, 6ta posición)
plot(dom3_W,X_red3_w)  % Señal original: Oxi3
xlim([0 2])  % Para hecer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 3 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
