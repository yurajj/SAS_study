data ex8_2;
input y x1 x2 x3 @@;
cards;
	7 1 -1 -1
	8 2 -1 0
	10 3 -1 1
	15 4 1 0
	18 5 1 0
	19 6 1 1
	14 7 0 0
;
run;

proc print data=ex8_2;
run;

proc sgscatter data=ex8_2;
matrix y x1-x3;
run; /* 행렬산점도 */

proc standard data=ex8_2 out=ex8_2st1 mean=0 std=1;
var x1-x3 y; /* 단위정상법 */
print;
run;

proc reg data=ex8_2st1;
model y = x1 x2 x3 / noint XPX;
run;

data ex8_2st2; /* 단위길이법 */
set ex8_2st1;
y = y/sqrt(6);
x1 = x1/sqrt(6);
x2 = x2/sqrt(6);
x3 = x3/sqrt(6);

proc reg data=ex8_2st2;
model y = x1 x2 x3 / noint XPX;
run;

