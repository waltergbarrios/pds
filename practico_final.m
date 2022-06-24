clc; close all; clear;
load('100m.mat');
y=val; %se carga con el nombre generico val
figure(1), 
subplot(2,2,1)
plot(y), title('Señal original'); %grafico la señal original

%% ruido
nm = size(y);
raf = rand(nm)*max(max(y))/8; % Generamos un vector de ruido aleatorio
y2 = raf + y; % Señal con ruido
figure(1), 
subplot(2,2,2)
plot(y2), title('Señal con ruido Alta Frecuencia');

%% analisis espectral
fm=250;
muestra=length(y2);
ordenadas= fft(y2, muestra); %y
abscisas=linspace(0, fm,muestra);
figure(1), 
subplot(2,2,3)
plot(abscisas, ordenadas), title('Analisis Espectral');

%% Diseño de un filtro pasa bajo IIR usando cheby1
wp1=0.45; wp2=0.65;
ws1=0.44; ws2=0.66;
Rp=1; Rs=15;
fc = 60; %frecuencia de corte
n = 8; % defino el orden del filtro
Wn = fc/(fm/2); % Frecuencia de corte normalizada 
[B,A]=cheby1(n,Rp,Wn);%%%%definimos los coeficientes; % uso cheby tipo 'pasa bajo'
%freqz(B,A) % Respuesta de frecuencia del Filtro Digital (vector de respuesta de frecuencia de punto y el vector de frecuencia angular)
se=y;
sefil = filter(B,A,se); % Señal filtrada
figure(1),
subplot(2,2,4),
plot(sefil), title('Señal filtrada'); %grafico la señal filtrada

%% wavelet Daubechies
f = y;
[c,l] = wavedec(f,3,'db2'); % Descomposición de la señal en 3 niveles
approx = appcoef(c,l,'db2'); % Coeficientes de aproximación (F.B.)
[cd1,cd2,cd3] = detcoef(c,l,[1,2,3]); % Coeficientes de detalle (F.A.)
figure(2),
subplot(5,1,1)
plot(f)
title('Señal original')
subplot(5,1,2)
plot(approx)
title('Coeficientes de aproximación')
subplot(5,1,3)
plot(cd3)
title('Coeficientes de detalle - Nivel 3')
subplot(5,1,4)
plot(cd2)
title('Coeficientes de detalle - Nivel 2')
subplot(5,1,5)
plot(cd1)
title('Coeficientes de detalle - Nivel 1')


