
% Cantidad de Muestras
Nx = 10001;

% Periodo de Muestreo
% LO SUSTITUIMOS POR Fm
% dt = 0.0001;
Fm = 1000000

% Rango de Muestreo (Inicia en 0 y termina en La cantidad de muestras -1)
% (Recordar que el 0 cuenta)
t = 0:(1/Fm):(Nx-1)* (1/Fm);

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
h=2*Fc*(1/Fm)*sinc(2*Fc*(1/Fm)*m);


% OBTENER y POR CONVOLUCION

% y[n]
y_conv = conv(x,h);
ny_conv = ((n(1)+m(1)):(n(end)+m(end)));



% OBTENER y POR PROPIEDADES DE LA TRANSFORMADA


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
% Previamente aplicamos Hamming de la misma longitud que h
ventana_hamming = hamming(Nh);

% En octave cuando aplicamos hamming nos devuelve valores en columna
% Y nosotros los necesitamos en filas por lo que usamos su transpuesta
% hN = [ventana_hamming', zeros(1,N-Nh)]
% H = fft(hN)


% Podriamos tambien utilizar una aproximacion de nuestra señal H con hamming:
% Hacemos multiplicacion punto a punto de la señal h con la transpuesta de la ventana_hamming
h_hamming = h .* ventana_hamming'
% Normalizamos
h_hamming_normalizada = h_hamming / sum(h_hamming);
hN = [h_hamming, zeros(1,N-Nh)]
H = fft(hN)

% Producto escalar
Y = X .* H

% Antitransformada
y_transf = ifft(Y);
ny_transf = ((n(1)+m(1)):(n(end)+m(end)));

% Longitudes de las señales en la frecuencia
k = 0:(N-1);

% Escalas del Tiempo
a = min([n m ny_conv]);
b = max([n m ny_conv]);


% Escalas de la Frecuencia
c = 0
d = N-1


% Graficos
figure('Name', 'TP4', 'NumberTitle', 'off');


% Primer Grafico
subplot(4,2,1);
stem(n, x, 'r');
legend('x');
title('Señal de entrada x[n]');
set(gca, 'FontSize', 12);
xlabel('t(s)');
ylabel('Amplitud');
grid on;
xlim([a,b])


% Segundo Grafico
subplot(4,2,2);
stem(k, abs(X), 'r');
legend('X');
title('Modulo de X(f)');
set(gca, 'FontSize', 12);
xlabel('f(hz)');
ylabel('Amplitud');
grid on;
xlim([c, d]);



% Tercer Grafico
subplot(4,2,3);
stem(m,  h_hamming_normalizada , 'b');
legend('h');
title('Respuesta al impulso h[n] enventanada y normalizada');
set(gca, 'FontSize', 12);
xlabel('t(s)');
ylabel('Amplitud');
grid on;
xlim([a,b])

% Cuarto Grafico
subplot(4,2,4);
stem(k, abs(H), 'b');
legend('H');
title('Modulo de H(f)');
set(gca, 'FontSize', 12);
xlabel('f(hz)');
ylabel('Amplitud');
xlim([c, d]);
grid on;



% Quinto Grafico
subplot(4,2,5);
stem(ny_conv, y_conv, 'm');
legend('y');
title('Señal de Salida y[n]');
set(gca, 'FontSize', 12);
xlabel('t(s)');
ylabel('Amplitud');
grid on;
xlim([a,b])

% Sexto Grafico
subplot(4,2,6);
stem(k, abs(Y), 'm');
legend('Y');
title('Modulo de Y(f)');
set(gca, 'FontSize', 12);
xlabel('f(hz)');
ylabel('Amplitud');
xlim([c, d]);
grid on;

% Septimo Grafico
subplot(4,2,7);
stem(ny_transf, y_transf(1:length(ny_conv)), 'm');
legend('|Y[k]| = X[k] .* H[k]');
title('Señal de Salida y[n] por convolucion FFT');
set(gca, 'FontSize', 12);
xlabel('t(s)');
ylabel('Amplitud');
xlim([a, b]);
grid on;


% Octavo Grafico
subplot(4,2,8);
stem(k, abs(Y), 'm');
legend('Y');
title('Modulo de Y(f)');
set(gca, 'FontSize', 12);
xlabel('f(hz)');
ylabel('Amplitud');
xlim([c, d]);
grid on;


