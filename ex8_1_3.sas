/* 변수선택 방법 (가능한 모든 회귀, 뒤로부터 제거, 앞으로부터 선택, 단계별 회귀) */

data ex8_1; /* 자료의 입력 및 이름 부여 */
input x1 x2 x3 y;
cards;
	1 -1 -1 7
	2 -1 0 8
	3 -1 1 10
	1 1 1 15
	2 1 0 18
	3 1 -1 26
;
run;

proc print data=ex8_1; run; /* 입력자료의 출력 */

proc reg data=ex8_1;
model y=x1-x3 / selection=rsquare; /* all, 결정계수 */
model y=x1-x3 / selection=adjrsq; /* all, 수정결정계수 */
model y=x1-x3 / selection=backward; /* 뒤로부터 제거 */
model y=x1-x3 / selection=forward; /* 앞으로부터 제거 */
model y=x1-x3 / selection=stepwise; /* 단계별 회귀 */
run;
