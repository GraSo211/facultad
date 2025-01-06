% Limpiar variables y pantalla
clc;
clear;
close all;



% x[n]
x =  input('Ingrese los valores de la señal x[n] como vector (ej: [4 6 4]): '); %[4 6 4];
nx = input('Ingrese el rango de índices (ej: 1:3): '); %(1:3);


% h[n]
h = input('Ingrese los valores de la señal h[n] como vector (ej: [2 6]): '); % [2 6];
nh = input('Ingrese el rango de índices (ej: 7:8): '); %(7:8);


% Convolucion
y = conv(x,h);
ny = ((nx(1)+nh(1)):(nx(end)+nh(end)));

% Escalas
a = min([nx nh ny])-2;
b = max([nx nh ny])+2;

% Graficos
figure('Name', 'TP1', 'NumberTitle', 'off');


% Primer Grafico
subplot(3,1,1);
stem(nx,x, 'r');
legend('x[n]');
title('Señal de entrada x[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('x[n]');
grid on;
xlim([a,b])

% Segundo Grafico
subplot(3,1,2);
stem(nh,h, 'b');
legend('h[n]');
title('Respuesta al impulso h[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('h[n]');
grid on;
xlim([a,b])

% Tercer Grafico
subplot(3,1,3);
stem(ny, y, 'm');
legend('y[n] = x[n] * h[n]');
title('Salida del sistema y[n] = x[n] * h[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('y[n]');
grid on;
xlim([a,b])
