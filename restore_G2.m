function [ G2 ] = restore_G2( G1, S )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

G2 = (G1 - S(1,1)) ./ (S(1,2) .* S(2,1) - S(1,1) .* S(2,2) + G1 .* S(2,2));

end