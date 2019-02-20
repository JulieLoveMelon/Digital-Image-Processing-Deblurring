%% 读入图片
clc;
clear;
I=imread('image.jpg');
[m,n,p]=size(I);
%获取RGB三通道的像素值
Ir = I(:,:,1);
Ig = I(:,:,2);
Ib = I(:,:,3);
%柱形函数的半径
a=6.5;

%% 处理三通道
%构造成像系统的PSF h
h=zeros(m,n);
for i=1:m
    for j=1:n
        if((i-a)^2+(j-a)^2<a^2)
            h(i,j)=1 / (42.25 * pi);
        elseif ((i-a)^2+(j-a)^2>=a^2)
            h(i,j)=0;
        end
    end
end
h = h /sum(sum(h));
fft_h=fft2(h);
fft_h=conj(fft_h)./(fft_h.*conj(fft_h)+0.0025);

fft_I1=fft2(Ir);
fft_I_over1=fft_I1.*fft_h;
ifft_I1=ifft2(fft_I_over1);
I_over1=uint8(ifft_I1);

fft_I2=fft2(Ig);
fft_I_over2=fft_I2.*fft_h;
ifft_I2=ifft2(fft_I_over2);
I_over2=uint8(ifft_I2);

fft_I3=fft2(Ib);
fft_I_over3=fft_I3.*fft_h;
ifft_I3=ifft2(fft_I_over3);
I_over3=uint8(ifft_I3);

%% 结果显示
I_result = cat(3,I_over1,I_over2,I_over3);
figure(1)
imshow(I_result);