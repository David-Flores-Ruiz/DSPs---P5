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



