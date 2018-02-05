clear variables
syms x y z al be ga real

% translation of the top plate w.r.t. base frame
T = [1 0 0 x; 0 1 0 y; 0 0 1 z; 0 0 0 1]; 

% rotation of the top plate w.r.t. base frame
R = Rz(degtorad(al))*Ry(degtorad(be))*Rx(degtorad(ga)) 

rb = 0.5; % radius of bottom plate
rt = 0.2; % radius of top plate
dt = 10; % half of angle between two legs mount point
l = [0; 0; 0.02; 0]; % static link at the bottom of the leg

% calculation of mounting points on base (b) and platform (p)
b = zeros(4,6); p = zeros(4,6);
b(:,1) = [rb*cos(degtorad(330+dt)); rb*sin(degtorad(330+dt)); 0; 1];
b(:,2) = [rb*cos(degtorad(90-dt)); rb*sin(degtorad(90-dt)); 0; 1];
b(:,3) = [rb*cos(degtorad(90+dt)); rb*sin(degtorad(90+dt)); 0; 1];
b(:,4) = [rb*cos(degtorad(210-dt)); rb*sin(degtorad(210-dt)); 0; 1];
b(:,5) = [rb*cos(degtorad(210+dt)); rb*sin(degtorad(210+dt)); 0; 1];
b(:,6) = [rb*cos(degtorad(330-dt)); rb*sin(degtorad(330-dt)); 0; 1];

p(:,1) = [rt*cos(degtorad(30-dt)); rt*sin(degtorad(30-dt)); 0; 1];
p(:,2) = [rt*cos(degtorad(30+dt)); rt*sin(degtorad(30+dt)); 0; 1];
p(:,3) = [rt*cos(degtorad(150-dt)); rt*sin(degtorad(150-dt)); 0; 1];
p(:,4) = [rt*cos(degtorad(150+dt)); rt*sin(degtorad(150+dt)); 0; 1];
p(:,5) = [rt*cos(degtorad(270-dt)); rt*sin(degtorad(270-dt)); 0; 1];
p(:,6) = [rt*cos(degtorad(270+dt)); rt*sin(degtorad(270+dt)); 0; 1];

% calculation of legs' vectors (L)
L = sym('L',[4 6]); d = zeros(4,6);

% initial position
x=0.2; y=0; z=0.25; al=0; be=0; ga=0;

for i=1:6
    L(:,i) = T*R*p(:,i) - b(:,i) - l;
    d(:,i) = subs(L(:,i));
end

lengths = zeros(6,1);
for n=1:6
    lengths(n) = norm((d(1:3,n))) - 0.2;
end

lengths

% animation code
iter=1000;
len = zeros(6,iter);
angle = 0;
delta = 0.04;
for n=1:iter
    for i=1:6
        L(:,i) = T*R*p(:,i) - b(:,i) - l;
        d(:,i) = subs(L(:,i));
    end
    for m=1:6
        quiver3(b(1,m),b(2,m),0.02,d(1,m),d(2,m),d(3,m));
        hold on;
    end
    for k=1:6
        len(k,n) = norm(d(1:3,k)) - 0.2;
    end
    angle = angle + delta;
    x = cos(angle)*0.2;
    y = sin(angle)*0.2;
    saveas(gcf,'pic/chart' + string(n) + '.png')
    pause(0.1);
    clf;
end

figure;
for a=1:6
    subplot(3,2,a);
    plot(1:iter,len(a,:))
end





