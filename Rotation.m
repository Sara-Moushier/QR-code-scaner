function [ New ] = Rotation( I )
%img = imrotate(I, -30); 4.1
%img = imrotate(I, 210); 2.1
%img = imrotate(I, -58); 4.4
% Convert from RGB to Gray
NumSquares = SquareNum(I);

if NumSquares <= 3 && NumSquares ~= 0
    New = I;

elseif NumSquares == 0
    BW2 = edge(I,'canny');
    % Perform the Hough transform
    [H, theta, ~] = hough(BW2);
    % Find the peak pt in the Hough transform
    peak = houghpeaks(H);
    % Find the angle of the bars
    QRAngle = theta(peak(2));
    New = imrotate(I,QRAngle + 180);
else
    BW2 = edge(I,'canny');
    % Perform the Hough transform
    [H, theta, ~] = hough(BW2);
    % Find the peak pt in the Hough transform
    peak = houghpeaks(H);
    % Find the angle of the bars
    QRAngle = theta(peak(2));
    New = imrotate(I,QRAngle);
end