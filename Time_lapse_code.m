% Time Lapse code


d_per_pix = 1/12; 



%% %experiemnt 1 

T_sec = TL1_data(:,1).*(60*60) + TL1_data(:,1).*(60) + TL1_data(:,2) ;
T_hour = T_sec./(60*60);

pix_offset = 3;
pix_disp =  TL1_data(:,4) - pix_offset;
d = pix_disp.*d_per_pix;

x_error = 0.5/(60*60);
y_error = 0.5*d_per_pix*1000;

x = T_hour;
y = d.*1000;

plot(x,y,'x','color',[0.2 0.2 0.98],'linewidth',1.5); 
hold on 
% errorbar(y,y_error)

%X = [ones(length(x),1) x]; none zero start
%b = X\y;
%yCalc = X*b;

% red = [0.57 0 0]
% blue = [0.2 0.2 0.98]

% b = x\y;
% yCalc = x*b;
% plot(x,yCalc,'--','color',[0.2 0.2 0.98]);

% https://uk.mathworks.com/matlabcentral/fileexchange/45711-linear-fit-with-both-uncertainties-in-x-and-in-y
% Performs a linear fit with uncertainties in x and y, using a Monte Carlo method
[ p, sp ] = linfitxy( x, y, x_error, y_error); %1 +/- STD lines
A = p(1);
B = p(2);
x_lin = x;
y_lin = A*x + B;
plot(x_lin, y_lin);
xlabel('Time (hours)');
ylabel('Vertical Displacement');

% err = ones(size(x));
% errorbar(x, y, 0.5, 'LineStyle','none');

% Exponential fit
figure
f = fit(x,y,'exp1'); % 95%  confidence bound 
plot(f,x,y)


y1 = 13.11*exp(0.1191*x);
hold on
plot(x,y1,'k:');

y2 = 29.56*exp(0.1692*x);
hold on
plot(x,y2,'k:');




%% Experiment 2 

ex1_u1 = FAT_1(:,1) + (FAT_1(:,2).*FAT_1(:,6)) - 290;
ex2_u1 = FAT_2(:,1) + (FAT_2(:,2).*FAT_2(:,6)) - 290;
ex3_u1 = FAT_3(:,1) + (FAT_3(:,2).*FAT_3(:,6)) - 290;
FL1_u1 = FL_1(:,1) + (FL_1(:,2).*FL_1(:,6)) - 290;

ex1_un = FAT_1(:,3) + (FAT_1(:,4).*FAT_1(:,6))- 290;
ex2_un = FAT_2(:,3) + (FAT_2(:,4).*FAT_2(:,6))- 290;
ex3_un = FAT_3(:,3) + (FAT_3(:,4).*FAT_3(:,6))- 290;
FL1_un = FL_1(:,3) + (FL_1(:,4).*FL_1(:,6))- 290;


ex1_dec = log( (ex1_u1)./(ex1_un) ) ./ FAT_1(:,5);
ex2_dec = log( (ex2_u1)./(ex2_un) ) ./ FAT_2(:,5);
ex3_dec = log( (ex3_u1)./(ex3_un) ) ./ FAT_3(:,5);
FL1_dec = log( (FL1_u1)./(FL1_un) ) ./ FL_1(:,5);

den = ( (4*pi) + (ex1_dec).^2).^0.5;
ex1_zeta = ex1_dec./(den);
den = ( (4*pi) + (ex2_dec).^2).^0.5;
ex2_zeta = ex2_dec./(den);
den = ( (4*pi) + (ex3_dec).^2).^0.5;
ex3_zeta = ex3_dec./(den);
den = ( (4*pi) + (FL1_dec).^2).^0.5;
FL1_zeta = FL1_dec./(den);

M = 155.99/1000;
k = 4*54.04;
Wn = (k/M)^0.5;
const = 2*(M*Wn)^0.5;

ex1_c = ex1_zeta.*const;
ex2_c = ex2_zeta.*const;
ex3_c = ex3_zeta.*const;
FL1_c = FL1_zeta.*const;


ex1_c_error = (4.*(FAT_1(:,6)./2).*ex1_un.*const)./(FAT_1(:,5).*ex1_u1);
ex2_c_error = (4.*(FAT_2(:,6)./2).*ex2_un.*const)./(FAT_2(:,5).*ex2_u1);
ex3_c_error = (4.*(FAT_3(:,6)./2).*ex3_un.*const)./(FAT_3(:,5).*ex3_u1);
FL1_c_error = (4.*(FL_1(:,6)./2).*FL1_un.*const)./(FL_1(:,5).*FL1_u1);

ex1_c_mean = mean(ex1_c);
ex2_c_mean = mean(ex2_c);
ex3_c_mean = mean(ex3_c);
FL1_c_mean = mean(FL1_c);

ex1_c_error_mean = mean(ex1_c_error)/sqrt(length(ex1_c_error));
ex2_c_error_mean = mean(ex2_c_error)/sqrt(length(ex2_c_error));
ex3_c_error_mean = mean(ex3_c_error)/sqrt(length(ex3_c_error));
FL1_c_error_mean = mean(FL1_c_error)/sqrt(length(FL1_c_error));

% printf('experiment 1 mean = %f +- %f ', ex1_c_mean, ex1_c_error_mean);
% printf('experiment 2 mean = %f +- %f ', ex2_c_mean, ex2_c_error_mean);
% printf('experiment 3 mean = %f +- %f ', ex3_c_mean, ex3_c_error_mean);
% printf('experiment FL1 mean = %f +- %f ', FL1_c_mean, FL1_c_error_mean);

exp_all = [ex1_c_mean;ex2_c_mean;ex3_c_mean];
exp_mean = mean(exp_all)
exp_all_error = [ex1_c_error_mean;ex2_c_error_mean;ex3_c_error_mean];
exp_mean_error = mean(exp_all_error)/sqrt(length(exp_all_error))

x = [1:10];
x_all = [1:10,1:10,1:10];
y_all = [ex1_c;ex2_c;ex3_c];
error_all = [ex1_c_error;ex2_c_error;ex3_c_error];

figure
% scatter(x_all, y_all);
plot(x_all,y_all,'x','color',[0.2 0.2 0.98],'linewidth',1.5); 
hold on
[ p, sp ] = linfitxy( x_all, y_all, 0, error_all); %1 +/- STD lines
A = p(1);
B = p(2);
x_lin = x;
y_lin = A*x + B;
plot(x_lin, y_lin);

% figure
hold on
% scatter(x_all, y_all);
plot(x,FL1_c,'x','color',[0.57 0 0],'linewidth',1.5); 
hold on
[ p, sp ] = linfitxy( x, FL1_c, 0, FL1_c_error); %1 +/- STD lines
A = p(1);
B = p(2);
x_lin = x;
y_lin = A*x + B;
plot(x_lin, y_lin);



figure
% Just Scatter
plot(x_all,y_all,'x','color',[0.2 0.2 0.98],'linewidth',1.5); 
hold on
plot(x,FL1_c,'x','color',[0.57 0 0],'linewidth',1.5); 
xlabel('Iteration');
ylabel('Damping Coeficient');
legend('Air Pocket Bearing','Flooded Bearing');


% figure
% f = fit(x', FL1_c,'exp1'); % 95%  confidence bound 
% plot(f,x', FL1_c)

% figure
% scatter(x, ex1_c);
% hold on
% f = fit(x', ex1_c,'exp1'); % 95%  confidence bound 
% plot(f,x', ex1_c)
% [ p, sp ] = linfitxy( [1:10], ex1_c, 0, 0.1); %1 +/- STD lines
% A = p(1);
% B = p(2);
% x_lin = x;
% y_lin = A*x + B;
% plot(x_lin, y_lin);

% polyfit(x,y,1)

% % plot([1:10], ex1_c);
% % hold on
% scatter([1:10], ex2_c);
% hold on
% % plot([1:10], ex2_c);
% % hold on 
% scatter([1:10], ex3_c);
% hold on
% % plot([1:10], ex3_c);
% % hold on 
% scatter([1:10], FL1_c);
% % hold on
% % plot([1:10], FL1_c);
% legend
