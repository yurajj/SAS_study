data ex8_1; /* 자료의 입력 및 이름 부여 */
input x1 x2 x3 y @@;
cards;
	1 -1 -1 7 2 -1 0 8 3 -1 1 10
	1 1 1 15 2 1 0 18 3 1 -1 26
;
run;

proc print data=ex8_1; run; /*입력자료의 출력*/

PROC sgscatter data=ex8_1;
matrix y x1-x3;
run; /*행렬산점도*/


/* 계획행렬 구성 */
proc iml;
use ex8_1;
read all; /* read all var{x1 x2 x3} into x123; */
read all var{y} into y;
print x1 x2 x3 y;
x = j(6,1,1) ||x1||x2||x3; /* x = j(6,1,1)||x123; */
print x;


/* (1) 수정항을 포함하지 않는 분산분석 */
n=6; k=3; alpha=0.05;
b = inv(x`*x)*x`*y;
i=i(n);
j=(n,n,1);
h=x*inv(x`*x)*x`;
print n k alpha, b i h;

ssr = b`*x`*y;
dfr = k+1;
msr = ssr/dfr;

sse = y`*(i-h)*y;
dfe = n-k-1;
mse = sse/dfe;

sst = y`*y;
dft = n;
f0 = msr/mse;

cv = quantile('f', 1-alpha, dfr, dfe); /* 임계값 */
sp = 1-cdf('f', f0, dfr, dfe); /* 유의확률 */
print ssr dfr msr, sse dfe mse, sst dft, f0 cv sp;


/* (2) 추가제곱합과 가설 검정 */
x023 = j(n,1,1) || x2 || x3;
b023 = inv(x023`*x023)*x023`*y;
ss023 = b023`*x023`*y;
ess = ssr - ss023; /* 추가제곱합 */
mess = ess/1;
f023 = mess/mse;
cv023 = quantile('f', 1-alpha, 3, dfe); /* 임계값 */
sp023 = 1 - cdf('f', f023, dfr, dfe); /* 유의확률 */
print x023 b023, ss023 ess mess, f023 cv023 sp023;


/* (3) 행렬 X의 분할과 분할행렬들의 직교성 검토 */
x01 = j(n,1,1) || x1;
x23 = x2 || x3; /* 행렬분할 */
x01tx23 = x01`*x23; /* 분할행렬의 직교 검토 */
print x01 x23 x01tx23;

b01 = inv(x01`*x01)*x01`*y;
b23 = inv(x23`*x23)*x23`*y;
print b01, b23;

ssb01 = b01`*x01`*y;
ssb23 = b23`*x23`*y;
print ssb01 ssb23;

ssb = ssb01 + ssb23;
ssb01gb23 = ssb-ssb23;
ssb23gb01 = ssb-ssb01;
print ssb ssb01gb23 ssb23gb01;

run;