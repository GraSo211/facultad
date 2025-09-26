
% Cantidad de Muestras
Nx = 301;

% Periodo de Muestreo
dt = 0.0001;
% dt = input('Ingrese el periodo de muestreo Δt (ej: 0.0001): ')


% Rango de Muestreo (Inicia en 0 y termina en La cantidad de muestras -1)
% (Recordar que el 0 cuenta)
t = 0:dt:(Nx-1)*dt;

% x[n]

% x =  input('Ingrese la señal x[n] (ej: -5*cos(2* pi *100*t) + 3*sin(2*pi*1500*t)): ');
x = -5*cos(2* pi *100*t) + 3*sin(2*pi*1500*t);
n = 0:Nx-1;

% Frecuencia de Corte
Fc = 800;
% Fc = input('Ingrese la frecuencia de corte Fc comprendida entre 100 y 1500 (ej: 800): ')


% Cantidad de Muestras
Nh = 101;

% dt es igual al usado en el muestreo

% Valores no nulos del Vector
M = (Nh-1)/2;
m = -M:M;

% h[n]
h=2*Fc*dt*sinc(2*Fc*dt*m);



% y[n]
y = conv(x,h);
ny = ((n(1)+m(1)):(n(end)+m(end)));

% Escalas
a = min([n m ny]);
b = max([n m ny]);


% Graficos
figure('Name', 'TP2', 'NumberTitle', 'off');


% Primer Grafico
subplot(3,1,1);
stem(n, x, 'r');
legend('x[n]');
title('Señal de entrada discreta x[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('x[n]');
grid on;
xlim([a,b])

% Segundo Grafico
subplot(3,1,2);
stem(m, h, 'b');
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
