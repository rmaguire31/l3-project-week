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



% ,'StartPoint',[1,2]








