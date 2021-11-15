data ex8_1; /* 자료의 입력 및 이름 부여 */
input x0 x1 x2 x3 y;
cards;
	1 1 -1 -1 7
	1 2 -1 0 8
	1 3 -1 1 10
	1 1 1 1 15
	1 2 1 0 18
	1 3 1 -1 26
;
run;

proc print data=ex8_1; run; /*입력자료의 출력*/

/* (1) */
Proc reg data=ex8_1;
model y = x0 x1 x2 x3 / noint; /* noint는 절편항(x) */
run;

/* (2) */
proc reg data=ex8_1;
model y = x0 x1 x2 x3 / ss1 ss2; /* ss1=축차제곱합, ss2=부분제곱합 */
run;
