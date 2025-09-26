
% Cantidad de Muestras
Nx = 301;

% Periodo de Muestreo
dt = 0.0001;

% Rango de Muestreo (Inicia en 0 y termina en La cantidad de muestras -1)
% (Recordar que el 0 cuenta)
t = 0:dt:(Nx-1)*dt;

% x[n]
x = -5*cos(2* pi *100*t) + 3*sin(2*pi*1500*t);
n = 0:Nx-1;

% Frecuencia de Corte
Fc = 800;

% Cantidad de Muestras
Nh = 101;

% Valores no nulos del Vector
M = (Nh-1)/2;
m = -M:M;

% h[n]
h=2*Fc*dt*sinc(2*Fc*dt*m);


% Calculamos el N = 2^r para elegir el N adecuado lo comparamos con la suma de las longitudes de las 2 señales.
for i=1:16
  if(2^i > Nx+Nh)
    N = 2^i
    break
  endif
endfor


% y[n]
% Calculamos X
xN = [x,zeros(1,N-Nx)]
X = fft(xN)

% Calculamos H
hN = [h, zeros(1,N-Nh)]
H = fft(hN)



% Producto Punto a Punto
Y = X .* H

% Antitransformada
y = ifft(Y);
ny = ((n(1)+m(1)):(n(end)+m(end)));

% Longitudes de las señales en la frecuencia
k = 0:(N-1);

% Escalas del Tiempo
a = min([n m ny]);
b = max([n m ny]);

% Escalas de la Frecuencia
a = min([n m ny]);
b = max([n m ny]);

% Escalas de la Frecuencia
c = 0
d = N-1


% Graficos
figure('Name', 'TP3', 'NumberTitle', 'off');


% Primer Grafico
subplot(3,2,1);
stem(n, x, 'r');
legend('x');
title('Señal de Entrada x[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('Amplitud');
grid on;
xlim([a,b])


% Segundo Grafico
subplot(3,2,2);
stem(k, abs(X), 'r');
legend('X');
title('Modulo de X(f)');
set(gca, 'FontSize', 12);
xlabel('k');
ylabel('Amplitud');
grid on;
xlim([c, d]);


% Tercer Grafico
subplot(3,2,3);
stem(m, h, 'b');
legend('h');
title('Respuesta al impulso h[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('Amplitud');
grid on;
xlim([a,b])

% Cuarto Grafico
subplot(3,2,4);
stem(k, abs(H), 'b');
legend('H');
title('Modulo de H(f)');
set(gca, 'FontSize', 12);
xlabel('k');
ylabel('Amplitud');
xlim([c, d]);
grid on;



% Quinto Grafico
subplot(3,2,5);
stem(ny, y(1:length(ny)), 'm');
legend('y');
title('Señal de Salida y[n]');
set(gca, 'FontSize', 12);
xlabel('n');
ylabel('Amplitud');
grid on;
xlim([a,b])

% Sexto Grafico
subplot(3,2,6);
stem(k, abs(Y), 'm');
legend('Y');
title('Modulo de Y(f)');
set(gca, 'FontSize', 12);
xlabel('k');
ylabel('Amplitud');
xlim([c, d]);
grid on;




