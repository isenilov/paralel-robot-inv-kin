
function R = Rxd(deg)
    R = [1 0 0 0; 0 -sin(pi*deg/180) -cos(pi*deg/180) 0; 0 cos(pi*deg/180) -sin(pi*deg/180) 0; 0 0 0 1];
end

