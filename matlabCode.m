clc; clear all;format long;

L = 0.1;
dt = 0.025;

load ('pr3data.dat')

%Plotting currents and voltages

figure(1);
subplot(2,2,1);
plot(pr3data(:,1),pr3data(:,2));
title("Current(t)");
xlabel("time(t)");
ylabel("current(A)");
subplot(2,2,2);
plot(pr3data(:,1),pr3data(:,3));
title("Voltage(t)");
xlabel("time(t)");
ylabel("voltage(V)");
sgtitle("Datas");
subplot(2,2,3);
plot(pr3data(:,2),pr3data(:,3));
title("Voltage(t)");
xlabel("current(A)");
ylabel("voltage(V)");


%checking consistency

%Three Point Enpoint For First Value

derivatives(1,1) = (1/(2*dt))*((-3*pr3data(1,2))+(4*pr3data(2,2))-pr3data(3,2));

%Three Point Midpoint

for i=2:40
derivatives(i:i,1) = (1/(2*dt))*(pr3data(i+1:i+1,2) - pr3data(i-1:i-1,2));
end

%Three Point Enpoint For Final Value

derivatives(41,1) = (1/(2*(-dt)))*((-3*pr3data(41,2))+(4*pr3data(40,2))-pr3data(39,2));

for i =1:1:41
    new(i:i,1) = L*derivatives(i:i,1);
end

figure(2);
plot(pr3data(:,3),new(:,1));
title("V-di relation");
xlabel("di(A)");
ylabel("voltage(V)");


%determine and plotting powers

for i=1:1:41
    powers(i:i,1) = pr3data(i:i,2)*pr3data(i:i,3);
end

figure(1);
subplot(2,2,4);
plot(pr3data(:,1),powers(:,1));
title("Power(t)");
xlabel("time(t)");
ylabel("power(P)");

%determine the integral with composite midpoint rule

integral(1:1,3) = 0;
sum = 0;

for i = 2:1:41
    for j = 1:2:i
        sum = sum + powers(j:j,1);
    end
    h = (pr3data(i:i,1) - pr3data(1:1,1))/i;
    integral(i:i,1) = 2*h*sum;
    sum = 0;
end

figure(3);
subplot(2,2,1);
plot(pr3data(:,1),integral(:,1));
title("Midpoint");
xlabel("time(t)");
ylabel("energy(W)");

%determine the integral with composite trapezoidal rule

integral(1:1,3) = 0;
sum = 0;

for i = 2:1:41
    for j = 1:1:i-1
        sum = sum + powers(j:j,1);
    end
    h = (pr3data(i:i,1) - pr3data(1:1,1))/i;
    c = powers(1:1,1) + powers(i:i,1);
    integral(i:i,2) = h*(c+2*sum)/2;
    sum = 0;
end

figure(3);
subplot(2,2,2);
plot(pr3data(:,1),integral(:,2));
title("Trapezoid");
xlabel("time(t)");
ylabel("energy(W)");

% determine the integral with composite simpsons rule

integral(1:1,3) = 0;
sum2 = 0;
sum4 = 0;

for i = 2:1:41
    for j = 1:1:i
        if mod(j,2) == 0
            sum2 = sum2 + powers(j:j,1);
        else
            sum4 = sum4 + powers(j:j,1);
        end
    end
    h = (pr3data(i:i,1) - pr3data(1:1,1))/i;
    c = powers(1:1,1) + powers(i:i,1);
    integral(i:i,3) = h*(c+(2*sum2)+(4*sum4))/3;
    sum2 = 0;
    sum4 = 0;
end

figure(3);
subplot(2,2,3);
plot(pr3data(:,1),integral(:,3));
title("Simpsons");
xlabel("time(t)");
ylabel("energy(W)");

% determine the integral with equation 3

for i=1:1:41
    integral(i:i,4) = 0.5*L*(pr3data(i:i,2)*pr3data(i:i,2));
end

figure(3);
subplot(2,2,4);
plot(pr3data(:,1),integral(:,4));
title("3.equation");
xlabel("time(t)");
ylabel("energy(W)");

figure(4);
plot(pr3data(:,1),integral(:,1));
hold on
plot(pr3data(:,1),integral(:,2));
hold on
plot(pr3data(:,1),integral(:,3));
hold on
plot(pr3data(:,1),integral(:,4));
legend("Midpoint","Trapezoidal","Simpsons","3.equation");

fprintf('Error Analysis\n');
fprintf('Error of Composite Midpoint: %f\n',norm(integral(41,1)-integral(41,4))/norm(integral(41,4)));
fprintf('Error of Composite Trapezoidal: %f\n',norm(integral(41,2)-integral(41,4))/norm(integral(41,4)));
fprintf('Error of Composite Simpsons: %f\n',norm(integral(41,3)-integral(41,4))/norm(integral(41,4)));
