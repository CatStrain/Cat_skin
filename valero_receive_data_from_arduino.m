s = serial('COM3');  %port
set(s,'BaudRate',9600);  %
fopen(s);  
 
interval = 200; %read 200 numbers from arduino. can be adjusted.
passo = 1;
t = 1;
x1 = 0;   %8 signals representing 8 strai gauges 
x2 = 0;
x3 = 0;
x4 = 0;
x5 = 0;
x6 = 0;
x7 = 0;
x8 = 0;

i=1;
m=zeros(1,1000); %counter

while(t < interval)
    b = str2num(fgetl(s)); %drag one line from arduino
    if (mod(i,8)==1)
        x2 = [x2;b];
        m(i) = i;
    elseif (mod(i,8)==2)
        x3 = [x3;b];
    elseif (mod(i,8)==3)
        x4 = [x4;b];
    elseif (mod(i,8)==4)
        x5 = [x5;b];
    elseif (mod(i,8)==5)
        x6 = [x6;b];
    elseif (mod(i,8)==6)
        x7 = [x7;b];
    elseif (mod(i,8)==7)
        x8 = [x8;b];
    else
        x1 = [x1;b]; 
    end
    i=i+1;  
                  
    %subplot(6,1,1);
    %plot(x1);
    %subplot(6,1,2);
    %plot(x2);
    %subplot(6,1,3);
    %plot(x3);
    %subplot(6,1,4);
    %plot(x4);
    %subplot(6,1,5);
    %plot(x5);
    %subplot(6,1,6);
    %plot(x6);
    %grid
    t = t+passo;
    %drawnow;
end
fclose(s);
T=table(ValName1,x1,x2,x3,x4,x5,x6,x7,x8);
writetable(T,'signal.csv');

