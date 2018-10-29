close all;
clear all;
clc;

%% load the source file
a=xlsread('input_file.xls');

%interelement spacing
d=5;

%specify the x -axis (angle)
theta=-pi/20:0.001:pi/20; 
freq=linspace(50,500,10);
A=a(:,1:2:end);
P=a(:,2:2:end);
pc1=linspace(-7.5,7.5,16);
pc2=linspace(-1.5,1.5,4);
% sampling theta to use later

A1=A(1:4,:);
A2=A(5:8,:);
A3=A(9:12,:);
A4=A(13:16,:);

P1=P(1:4,:);
P2=P(5:8,:);
P3=P(9:12,:);
P4=P(13:16,:);

for i = 1: length(freq)
    h=figure;
    lambda(i) = 300/freq(i);
    fi(i,:)=(2*pi/lambda(i)) *d*sin(theta);
    fi1=ones(length(A),1)*fi(i,:);
    fi11=ones(length(A)/4,1)*fi(i,:);
    
        for j=1:length(A)
            pattern(j,:)=A(j)*exp(1i*(pc1(j)*(fi1(j,:)+(P(j,i)*ones(1,length(fi))))));
        end;
        
        for j=1:length(A)/4
            pattern1(j,:)=A1(j)*exp(1i*(pc2(j)*(fi11(j,:)+(P1(j,i)*ones(1,length(fi))))));
            pattern2(j,:)=A2(j)*exp(1i*(pc2(j)*(fi11(j,:)+(P2(j,i)*ones(1,length(fi))))));
            pattern3(j,:)=A3(j)*exp(1i*(pc2(j)*(fi11(j,:)+(P3(j,i)*ones(1,length(fi))))));
            pattern4(j,:)=A4(j)*exp(1i*(pc2(j)*(fi11(j,:)+(P4(j,i)*ones(1,length(fi))))));
        end;

        
        for l=1:length(A)/4
            pattern_1(l,:)=pattern1(l,i)*exp(1i*(pc2(l)*(fi11(l,i)+(P1(l,i)*ones(1,length(fi))))));
            pattern_2(l,:)=pattern2(l,i)*exp(1i*(pc2(l)*(fi11(l,i)+(P2(l,i)*ones(1,length(fi))))));
            pattern_3(l,:)=pattern3(l,i)*exp(1i*(pc2(l)*(fi11(l,i)+(P3(l,i)*ones(1,length(fi))))));
            pattern_4(l,:)=pattern4(l,i)*exp(1i*(pc2(l)*(fi11(l,i)+(P4(l,i)*ones(1,length(fi))))));
        end; 
        
    antenna_16=sum(pattern);
    antenna_4=sum(pattern2);   
  
    plot(theta*180/pi,abs(antenna_16)./max(abs(antenna_16)),'LineWidth',2);
    hold all;
    plot(theta*180/pi,abs(antenna_4)./max(abs(antenna_4)),'LineWidth',2)
    grid on;
       
%     plot(theta*180/pi,abs(antenna_16));
%     hold all;
%     plot(theta*180/pi,abs(antenna_4))
    
  
    
    
    xlabel('Angle(theta)','FontSize',14)
    ylabel('Amplitude(normalized)','FontSize',14)
    legend('16 Antennas','4 Antennas','FontSize',14)
    title(strcat(num2str(i*50),' {}  ','MHz'),'FontSize',14)
    saveas(h,sprintf('FIG%d.png',i));
    export_fig(sprintf('FIG%d.fig', i));
end;

close all;
