function [ x,y ] = extract_coords( G, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

x = real(G);
x = x(1:length(x)/n:end);
y = imag(G);
y = y(1:length(y)/n:end);

end

