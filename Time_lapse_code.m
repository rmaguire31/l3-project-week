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
k = 4*43.9;
Wn = (k/M)^0.5;

const = 2*(M*Wn)^0.5;

ex1_c = ex1_zeta.*const;
ex2_c = ex2_zeta.*const;
ex3_c = ex3_zeta.*const;
FL1_c = FL1_zeta.*const;

ex1_c_mean = mean(ex1_c)
ex2_c_mean = mean(ex2_c)
ex3_c_mean = mean(ex3_c)
FL1_c_mean = mean(FL1_c)

figure
scatter([1:10], ex1_c);
hold on
plot([1:10], ex1_c);
hold on
scatter([1:10], ex2_c);
hold on
plot([1:10], ex2_c);
hold on 
scatter([1:10], ex3_c);
hold on
plot([1:10], ex3_c);
hold on 
scatter([1:10], FL1_c);
hold on
plot([1:10], FL1_c);
legend
