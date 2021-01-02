libname c "/home/u49993673/CAMP";

proc mixed data=c.camp method=ml covtest;
	title "Model C visitc_num + TG";
	class id tg;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/ type=arh(1) sub=id;
run;
