% Ejercicio 2: Filtro pasa-bajo en tiempo discreto (Octave)
% Definir parámetros de muestreo
Nx = 301;           % Número de muestras de x[n]
dt = 0.0001;        % Intervalo de muestreo en segundos (0.1 ms)
t = (0:Nx-1) * dt;   % Vector de tiempo para x[n]

% Señal de entrada x[n] muestreos de x(t)
% x(t) = -5cos(2pi100t) + 3sin(2pi1500t)
x = -5*cos(2*pi*100*t) + 3*sin(2*pi*1500*t);

% Parámetros del filtro
Fc = 800;           % Frecuencia de corte en Hz
Nh = 101;           % Número de muestras de la respuesta al impulso (valor impar)
M = (Nh-1)/2;       % Desplazamiento para centrar h[n]

% Vector n para h[n]
n_h = -M:M;

% Definir h[n] = 2Fcdt * sinc(2Fcdtn)
% Octave sinc(x) = sin(pix)/(pix)
arg = 2 * Fc * dt * n_h;
% sinc_pi(x) = sin(pix)/(pi*x)
sinc_arg = sin(pi * arg) ./ (pi * arg);
sinc_arg(M+1) = 1;  % corregir división 0/0 en n=0
h = 2 * Fc * dt * sinc_arg;

% Convolución para obtener y[n]
y = conv(x, h);

% Vector de índice n para la salida
y_n = 0:(length(y)-1);

% Graficar las señales en la misma escala de n
figure;
subplot(3,1,1);
plot(0:Nx-1, x, 'LineWidth', 1.2);
title('Señal de entrada x[n]');
xlabel('n'); ylabel('x[n]');
grid on;

subplot(3,1,2);
plot(n_h, h, 'LineWidth', 1.2);
title('Respuesta al impulso h[n]');
xlabel('n'); ylabel('h[n]');
grid on;

subplot(3,1,3);
plot(y_n, y, 'LineWidth', 1.2);
title('Señal de salida y[n] = x[n] * h[n]');
xlabel('n'); ylabel('y[n]');
% Ajustar límites para centrado en parte no nula
xlim([0 length(y)-1]);
grid on;

% Ajustar la misma escala de n para comparación
sgtitle('Comparación de x[n], h[n] y y[n]');


