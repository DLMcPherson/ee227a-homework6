DrugRecipe = [3,1,1;1,0,1]'
IPrices = [3.50,2.60,6.80]
DrugPrices=IPrices*DrugRecipe
DrugRevenu=[25,10]
DrugProfit=DrugRevenu-DrugPrices
P=[25 10 0 0 -3.50 -2.60 -6.80]
C = zeros(7,7)
C(1,1) = 1;
C(2,2) = 1;
C(3,1) = 1 ; C(3,3) = -1;
C(4,2) = 1 ; C(4,4) = -1;
C(5,3) = 3 ; C(5,4) = 1 ; C(5,5)=-1;
C(6,3) = 1 ; C(6,4) = 0 ; C(6,6)=-1;
C(7,3) = 1 ; C(7,4) = 1 ; C(7,7)=-1;
C
D1=[100;100;0;0;0;0;0]
D2=[150;200;0;0;0;0;0]
D3=[200;250;0;0;0;0;0]
D=[D1,D2,D3]
zee = zeros(7,3);

% Maximize profit for each individual scenario
for i=1:3
    i
    D(:,i)
    cvx_begin
        variable z(7)
        maximize P*z
        subject to
            z   >= 0
            C*z <= D(:,i)
    cvx_end
    i
    zee(:,i) = z
    ooo(i)= cvx_optval
end
Eooo = sum(ooo)/3

% Maximize profit for the average scenario
ED=sum(D,2)/3
cvx_begin
    variable z(7)
    maximize P*z
    subject to
        z   >= 0
        C*z <= ED
cvx_end
Ez = z
Eo = cvx_optval

% Maximize profit for Part 3
cvx_begin
    variable ss1(2)
    variable ss2(2)
    variable ss3(2)
    variable y(2)
    variable x(3)
    maximize DrugRevenu*(0.2*ss1+0.5*ss2+0.3*ss3)-IPrices*x
    subject to
        x   >= 0
        y   >= 0
        ss1 >= 0
        ss2 >= 0
        ss3 >= 0
        DrugRecipe*y <= x
        ss1 <= y
        ss2 <= y
        ss3 <= y
        ss1 - D(1:2,1) <= 0
        ss2 - D(1:2,2) <= 0
        ss3 - D(1:2,3) <= 0
cvx_end
So = cvx_optval
Sx = x
Sy = y
Ss = ss3
Sz = [Ss;Sy;Sx]

% Maximize profit for Part 4
cvx_begin
    variable ss1(2)
    variable ss2(2)
    variable ss3(2)
    variable ys1(2)
    variable ys2(2)
    variable ys3(2)
    variable x(3)
    maximize DrugRevenu*(0.2*ss1+0.5*ss2+0.3*ss3)-IPrices*x
    subject to
        x   >= 0
        ys1 >= 0
        ys2 >= 0
        ys3 >= 0
        ss1 >= 0
        ss2 >= 0
        ss3 >= 0
        DrugRecipe*ys1 <= x
        DrugRecipe*ys2 <= x
        DrugRecipe*ys3 <= x
        ss1 <= ys1
        ss2 <= ys2
        ss3 <= ys3
        ss1 - D(1:2,1) <= 0
        ss2 - D(1:2,2) <= 0
        ss3 - D(1:2,3) <= 0
cvx_end

