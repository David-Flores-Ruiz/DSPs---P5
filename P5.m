%%%%%%%%%%%%%%%% P5 de DSP's: "CÁLCULO DEL RITMO CARDIACO %%%%%%%%%%%%%%%%%
%                  Y DEL NIVEL DE OXÍGENO EN LA SANGRE"                   %
%                                                                         %
%                       David Flores                                      %
%                       Javier Chávez                                     %
%   Realizar el cálculo del ritmo cardiaco y del nivel de saturación del  %
% oxígeno en la sangre, procesando las señales correspondientes en MatLab %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  DEFINES  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MORE_POINTS = 1;    % Factor para definir mayor número de puntos en la TF
ZOOM_TF1 = 3;  % Para un acercamiento a la gráfica, esperamos f0 = 1.25Hz
ZOOM_TF2 = 3;  % Para un acercamiento a la gráfica, esperamos f0 = 1.25Hz
ZOOM_TF3 = 3;  % Para un acercamiento a la gráfica, esperamos f0 = 1.25Hz
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


%filtro pasabandas para eliminar fecuencias indeseadas
%48 ppm 
wp = 0.8/ (Fs/2); %frecuencia de paso mínima = 0.8 Hz eliminando 
                  %la componente de directa
%240 ppm
wr= 3.5/(Fs/2);   %frecuencia de paso máxima = 3.5 Hz, medicamente no hay 
%pulsaciones saludables de más de 200ppm -> 3.33 Hz
% Filtro pasa bandas
%%%%%%%%%%%%%de 100 puntos, ventana triangular
bandpass = fir1(100,[wp wr], 'bandpass', triang(101)); 
freqz(bandpass); title('filtro pasa bandas');

%%=======aplicamos el filtro pasabanda  a nuestras señales Red e IR=====%%%

p_banda_red_1 = filter(bandpass,1,Struct_oxi1.x_red);
p_banda_ir_1 = filter(bandpass,1,Struct_oxi1.x_ir);

p_banda_red_2 = filter(bandpass,1,Struct_oxi2.x_red);
p_banda_ir_2 = filter(bandpass,1,Struct_oxi2.x_ir);

p_banda_red_3 = filter(bandpass,1,Struct_oxi3.x_red);
p_banda_ir_3 = filter(bandpass,1,Struct_oxi3.x_ir);

%%%%%%%%%%%%%%%%%%%%%%%% TRANSFORMADAS DE FOURIER %%%%%%%%%%%%%%%%%%%%%%%%%
nfft1 = sizeOxi1*MORE_POINTS;   % el numero de puntos de la fft
step1_W = Fs/(nfft1-1);   % frecuencia de muestreo / numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom1_W  = 0 : step1_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
% X_ir1_w   = abs( fft(Struct_oxi1.x_ir, nfft1) );
% X_red1_w  = abs( fft(Struct_oxi1.x_red,nfft1) );
X_ir1_w   = abs( fft(p_banda_ir_1, nfft1) );
X_red1_w  = abs( fft(p_banda_red_1,nfft1) );
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
nfft2 = sizeOxi2*MORE_POINTS;   % el numero de puntos de la fft
step2_W = Fs/(nfft2-1);   % frecuencia de muestreo / numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom2_W  = 0 : step2_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
% X_ir2_w   = abs( fft(Struct_oxi2.x_ir, nfft2) );
% X_red2_w  = abs( fft(Struct_oxi2.x_red,nfft2) );

X_ir2_w   = abs( fft(p_banda_ir_2, nfft2) );
X_red2_w  = abs( fft(p_banda_red_2,nfft2) );

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
nfft3 = sizeOxi3*MORE_POINTS;   % el numero de puntos de la fft
step3_W = Fs/(nfft3-1);   % frecuencia de muestreo / numero de puntos de TF

% Construccion del vector de frecuencias para usar en plot()
dom3_W  = 0 : step3_W : Fs; % Escala de frecuencia en "Hz"

% Primero se obtiene la magnitud de la transformada de Fourier FFT; de
% manera que el largo de la FFT sea nfft 
% X_ir3_w   = abs( fft(Struct_oxi3.x_ir, nfft3) );
% X_red3_w  = abs( fft(Struct_oxi3.x_red,nfft3) );

 X_ir3_w   = abs( fft(p_banda_ir_3, nfft3) );
 X_red3_w  = abs( fft(p_banda_red_3,nfft3) );
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%% SALVAMOS AMPLITUD DE "DC" EN LA TF %%%%%%%%%%%%%%%%%%%%
% AC_red1 = 0;              AC_red2 = 0;              AC_red3 = 0;
DC_red1 = abs(X_red1_w(1));    DC_red2 = abs(X_red2_w(1));    DC_red3 = abs(X_red3_w(1));

% AC_ir1 = 0;               AC_ir2 = 0;               AC_ir3 = 0;
DC_ir1 = abs(X_ir1_w(1));      DC_ir2 = abs(X_ir2_w(1));      DC_ir3 = abs(X_ir3_w(1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%% BÚSQUEDA DEL RITMO CARDIACO EN BPM y BPS %%%%%%%%%%%%%%%%
fprintf('Valores TF red1: 1 - 10');
X_red1_w(1:10)
fprintf(' - Eliminamos los primeros  5 componentes de TF red1\n');
X_red1_w(1:5) = 0;
fprintf('Valores TF red1: 1 - 10');
X_red1_w(1:10)
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual" \n\n');
X_red1_w(15:nfft1) = 0;

fprintf('Valores TF red2: 1 - 10 \n ');
X_red2_w(1:10);
fprintf(' - Eliminamos los primeros 35 componentes de TF red2\n');
X_red2_w(1:35) = 0;
fprintf('Valores TF red2: 1 - 10 \n ');
X_red2_w(1:10);
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual" \n\n');
X_red2_w(70:nfft2) = 0;

fprintf('Valores TF red3: 1 - 10 \n ');
X_red3_w(1:10);
fprintf(' - Eliminamos los primeros 40 componentes de TF red3\n');
X_red3_w(1:40) = 0;
fprintf('Valores TF red3: 1 - 10 \n ');
X_red3_w(1:10);
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual" \n\n');
X_red3_w(80:nfft3) = 0;

PICO_red1 = max(X_red1_w);
PICO_red2 = max(X_red2_w);
PICO_red3 = max(X_red3_w);

BPS_red1 = 0;
BPS_red2 = 0;
BPS_red3 = 0;

% Busqueda en la TF de la frecuencia a la que pertenezca cada Pico_red"n"
disp('Waiting please MatLab is processing: Búsqueda de f(Hz)-> Pico_red1');
for n=1 : 1 : nfft1
    if(X_red1_w(n) == PICO_red1)
        % Encontramos la f(Hz) a la que pertenece el Pico_1
        BPS_red1 = dom1_W(n);
    end
end

% Busqueda en la TF de la frecuencia a la que pertenezca cada Pico_red"n"
disp('Waiting please MatLab is processing: Búsqueda de f(Hz)-> Pico_red2');
for n=1 : 1 : nfft2
    if(X_red2_w(n) == PICO_red2)
        % Encontramos la f(Hz) a la que pertenece el Pico_2
        BPS_red2 = dom2_W(n);
    end
end

% Busqueda en la TF de la frecuencia a la que pertenezca cada Pico_red"n"
disp('Waiting please MatLab is processing: Búsqueda de f(Hz)-> Pico_red3');
for n=1 : 1 : nfft3
    if(X_red3_w(n) == PICO_red3)
        % Encontramos la f(Hz) a la que pertenece el Pico_3
        BPS_red3 = dom3_W(n);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%% IMPRESIÓN DE RITMO CARDIACO %%%%%%%%%%%%%%%%%%%%%%%
BPM_red1 = BPS_red1*60;
BPM_red2 = BPS_red2*60;
BPM_red3 = BPS_red3*60;

disp(' + Resultados para el cálculo del Ritmo Cardiaco (Latidos/tiempo):');
fprintf('Signal 1 -> BPSec = %.2fHz - BPMin = %.2f \n',BPS_red1, BPM_red1);
fprintf('Signal 2 -> BPSec = %.2fHz - BPMin = %.2f \n',BPS_red2, BPM_red2);
fprintf('Signal 3 -> BPSec = %.2fHz - BPMin = %.2f \n',BPS_red3, BPM_red3);
fprintf(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%% BÚSQUEDA DE LA AMPLITUD "AC" EN LA TF DE "IR" %%%%%%%%%%%%%%
fprintf(' - Eliminamos los primeros  5 componentes de TF ir1\n');
X_ir1_w(1:5) = 0;
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual" \n\n');
X_ir1_w(15:nfft1) = 0;

fprintf(' - Eliminamos los primeros 35 componentes de TF ir2\n');
X_ir2_w(1:35) = 0;
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual" \n\n');
X_ir2_w(70:nfft2) = 0;

fprintf(' - Eliminamos los primeros 40 componentes de TF ir3\n');
X_ir3_w(1:40) = 0;
fprintf(' - Eliminamos los ultimos componentes: "Pasabanda Manual"   \n');
X_ir3_w(80:nfft3) = 0;

PICO_ir1 = max(X_ir1_w);
PICO_ir2 = max(X_ir2_w);
PICO_ir3 = max(X_ir3_w);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% obtención de los valores de AC
%%%==============================señal 1===============================%%%

%encontramos los valores máximos y mínimos con la función findpeaks luego
%de esto, obtenemos un promedio de los minimos y máximos con mean(), 
%estos valores los restamos para así encontrar la amplitud real de AC de 
%la señal, se realiza este calculo para las 3 señales con sus 
%respectivos R e IR.

max_value_red = abs(findpeaks(p_banda_red_1));  
prom_max_red = mean(max_value_red);
 
max_value_ir = abs(findpeaks(p_banda_ir_1));
prom_max_ir = mean(max_value_ir);
 
min_value_red = abs(findpeaks(-p_banda_red_1));
prom_min_red = mean(min_value_red);
 
min_value_ir = abs(findpeaks(-p_banda_ir_1));
prom_min_ir = mean(min_value_ir);
 
AC_red_1 = abs(prom_max_red - prom_min_red);
AC_ir_1 = abs(prom_max_ir- prom_min_ir);
%%%guardamos los valores obtenidos
AC_red1 = AC_red_1;  AC_ir1  = AC_ir_1; 

%%%==============================señal 2===============================%%%
max_value_red = abs(findpeaks(p_banda_red_2));
prom_max_red = mean(max_value_red);
 
max_value_ir = abs(findpeaks(p_banda_ir_2));
prom_max_ir = mean(max_value_ir);
 
min_value_red = abs(findpeaks(-p_banda_red_2));
prom_min_red = mean(min_value_red);
 
min_value_ir = abs(findpeaks(-p_banda_ir_2));
prom_min_ir = mean(min_value_ir);
 
AC_red_1 = abs(prom_max_red - prom_min_red);
AC_ir_1 = abs(prom_max_ir- prom_min_ir);
%%%guardamos los valores obtenidos
AC_red2 = AC_red_1;
AC_ir2  = AC_ir_1;

%%%==============================señal 3===============================%%%
max_value_red = abs(findpeaks(p_banda_red_3));
prom_max_red = mean(max_value_red);
 
max_value_ir = abs(findpeaks(p_banda_ir_3));
prom_max_ir = mean(max_value_ir);
 
min_value_red = abs(findpeaks(-p_banda_red_3));
prom_min_red = mean(min_value_red);
 
min_value_ir = abs(findpeaks(-p_banda_ir_3));
prom_min_ir = mean(min_value_ir);
 
AC_red_1 = abs(prom_max_red - prom_min_red);
AC_ir_1 = abs(prom_max_ir- prom_min_ir);
%%%guardamos los valores obtenidos
AC_red3 = AC_red_1;
AC_ir3  = AC_ir_1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% ASIGNAMOS LAS AMPLITUDES DE "AC" DE LA TF %%%%%%%%%%%%%%%%
% AC_red1 = AC_red_1;       AC_red2 = PICO_red2;       AC_red3 = PICO_red3;
% AC_ir1  = AC_ir_1;        AC_ir2  = PICO_ir2;        AC_ir3  = PICO_ir3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
%%%%%% EQ1: CÁLCULO DEL OXÍGENO EN LA SANGRE SEGÚN RELACIÓN: (AC/DC) %%%%%%
EQ1_Factor_R1 = (AC_red1/DC_red1) / (AC_ir1/DC_ir1)

EQ1_Factor_R2 = (AC_red2/DC_red2) / (AC_ir2/DC_ir2)

EQ1_Factor_R3 = (AC_red3/DC_red3) / (AC_ir3/DC_ir3)
% fprintf(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n');
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - %
%%%% EQ2: CÁLCULO DEL OXÍGENO EN LA SANGRE: log10(AC_red)/log10(AC_ir) %%%%
EQ2_Factor_R1 = log10(AC_red1) / log10(AC_ir1)

EQ2_Factor_R2 = log10(AC_red2) / log10(AC_ir2)

EQ2_Factor_R3 = log10(AC_red3) / log10(AC_ir3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%se decide utilizar la ecuación 2 ya que de esta se obtienen los mejores
%resultados de R para el cálculo de porcentaje de oxigeno

%%%%%%%%%%%%% IMPRESIÓN DEL NIVEL DE OXIGENACIÓN EN LA SANGRE %%%%%%%%%%%%%
SpO2_1 = 110 - EQ2_Factor_R1*25;
SpO2_2 = 110 - EQ2_Factor_R2*25;
SpO2_3 = 110 - EQ2_Factor_R3*25;

disp(' + Resultados para el cálculo del Nivel de Oxígeno en sangre(%):  ');
fprintf('Signal 1 -> Nivel de Oxigeno = %.2f ',SpO2_1);   disp('%')
fprintf('Signal 2 -> Nivel de Oxigeno = %.2f ',SpO2_2);   disp('%')
fprintf('Signal 3 -> Nivel de Oxigeno = %.2f ',SpO2_3);   disp('%')
fprintf(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n');
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
plot(dom1_W,X_ir1_w, '-*')  % Señal original: Oxi1
xlim([0 ZOOM_TF1])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 1') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 4) % Varias Graficas (2 filas, 3 columnas, 4ta posición)
plot(dom1_W,X_red1_w, '-o')  % Señal original: Oxi1
xlim([0 ZOOM_TF1])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 1 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 2) % Varias Graficas (2 filas, 3 columnas, 2da posición)
plot(dom2_W,X_ir2_w, '-*')  % Señal original: Oxi2
xlim([0 ZOOM_TF2])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 2') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 5) % Varias Graficas (2 filas, 3 columnas, 5ta posición)
plot(dom2_W,X_red2_w, '-o')  % Señal original: Oxi2
xlim([0 ZOOM_TF2])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 2 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 3) % Varias Graficas (2 filas, 3 columnas, 3ra posición)
plot(dom3_W,X_ir3_w, '-*')  % Señal original: Oxi3
xlim([0 ZOOM_TF3])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: IR - señal 3') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada

subplot(2, 3, 6) % Varias Graficas (2 filas, 3 columnas, 6ta posición)
plot(dom3_W,X_red3_w, '-o')  % Señal original: Oxi3
xlim([0 ZOOM_TF3])  % Hacer un zoom al espectro, ver los armonicos y la f0
title('TFourier: RED - señal 3 (BPM)') % Titulo del gráfico
xlabel('frecuencia (w) en Hz') % Nombre del eje X
ylabel('Amplitud Am')          % Nombre del eje Y
grid on % Cuadrícula Activada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%