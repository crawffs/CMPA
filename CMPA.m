Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7, 200);
I = Is.*(exp(V*1.2/0.025) - 1) + (Gp*V) - (Ib*(exp((V+Vb)*(-1.2)/0.025) ...
    - 1));
I2 = (0.8 + 0.4.*rand(size(I))).*I;

figure(1)
subplot(2,1,1)
plot(V,I,V,I2)
subplot(2,1,2)
semilogy(V,abs(I),V,abs(I2))

fit4 = polyfit(V,I2,4);
fit8 = polyfit(V,I2,8);

data4 = polyval(fit4,V);
data8 = polyval(fit8,V);

figure(2)
subplot(1,2,1)
plot(V,data4)
plot(V,data8)
hold on
subplot(1,2,2)
semilogy(V,data4)
semilogy(V,data8)
hold on

foac = fittype('A.*(exp(1.2*x/0.025)-1) + (0.1*x) - (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ffac = fit(V', I2', foac);
Ifac = ffac(V');

foabc = fittype('A,*(exp(1.2*x/0.025)-1) + (B.*x)- (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ffabc = fit(V', I2', foabc);
Ifabc = ffabc(V');

foabcd = fittype('A,*(exp(1.2*x/0.025)-1) + (B.*x)- (C*(exp(-1.2*(-(x+D))/0.025)-1))');
ffabcd = fit(V', I2', foabcd);
Ifabcd = ffabcd(V');

figure(3)
subplot(1,2,1)
plot(V, Ifac)
hold on
plot(V, Ifabc)
hold on
plot(V, Ifabcd)
subplot(1,2,2)
semilogy(V,Ifac)
semilogy(V,Ifabc)
semilogy(V,Ifabcd)
hold on

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net);
Inn = outputs;

figure(4)
subplot(1,2,1)
plot(V,I2)
hold on
plot(V, outputs')
hold on
subplots(1,2,2)
semilogy(V,I2)
hold on
semilogy(V, outputs')
hold on










