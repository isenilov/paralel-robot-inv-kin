
function R = Rzd(deg)
    R = [-sin(pi*deg/180) -cos(pi*deg/180) 0 0; cos(pi*deg/180) -sin(pi*deg/180) 0 0; 0 0 1 0; 0 0 0 1];
end