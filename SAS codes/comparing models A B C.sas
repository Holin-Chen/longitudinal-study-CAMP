libname c "/home/u49993673/CAMP";


*****************************************************

			Comparing Models A B

*****************************************************;
	
	
	proc mixed data=c.camp method=ml covtest; 	*<----- Unconditional Means Model;
	title "Model A Unconditional Means Model";
	class id;
	model posfev =/solution notest;
	random intercept/sub=id;
	run;
	
	*Time is visitc_num;
	proc mixed data=c.camp method=ml;			*<----- Unconditional Growth Model;
	title "Model B Unconditional Growth Model with visitc";
	class id visitc;
	model posfev = visitc_num/solution notest outpm=pred;
	random intercept visitc_num/ type=un sub=id;
	run;
	
	****************************************************************
			WARNING both unconditional growth models were unable to
			make Hessian positive definite. Mean estimates cannot be trusted!
			
			Solution: Take a random variance component out of the model and run again
			Since the slopes and variance component for slope have standard errors of 0
			take TIME out of the random statement.
	****************************************************************;
	
		*Time is fdays;
	proc mixed data=c.camp method=ml covtest maxiter=1000; *<----- Unconditional growth;
	title "Model B Unconditional Growth Model with fdays";
	class id;
	model posfev = fdays/solution notest;
	random intercept/ type=un sub=id;
	run;
	
	*Time is visitc;
	proc mixed data=c.camp method=ml;
	title "Model B Unconditional Growth Model with visitc_num";
	class id visitc;
	model posfev = visitc_num/solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
	
	*hypothesis testing models A vs B;
	
	data calc;
	pfdays = 1 - probchi(15207.7, 1);
	pvisitc_num = 1- probchi(18976.5,1);
	run;
	proc print data=calc;
	run;
*****************************************************
		Visitc_num has better properties than fdays
		Continue with vitistc_num
*****************************************************;	

		
*****************************************************
		
			Comparing Models B C

*****************************************************;
	
	*Model B: Visitc;
	proc mixed data=c.camp method=ml covtest;
	title "Model B Unconditional Growth Model with visitc_num";
	class id;
	model posfev = visitc_num/solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;

	*Model C: Visitc + TG;
	proc mixed data=c.camp method=ml;
	title "Model C visitc_num + TG";
	class id tg;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;

*****************************************************
		
			Comparing Models C and D

*****************************************************;

	*Model C: Visitc + TG;
	proc mixed data=c.camp method=ml;
	title "Model C visitc_num + TG";
	class id tg;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
	
	*Model D: Visitc + TG + age_rz;
	proc mixed data=c.camp method=ml;
	title "Model D visitc_num + TG + age_rz";
	class id tg;
	model posfev = visitc_num TG age_rz visitc_num*TG visitc_num*age_rz /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
*****************************************************
		Model C is better. Stick with model C.
*****************************************************;	


*****************************************************
		
			Comparing Models C and E

*****************************************************;

	*Model C: Visitc + TG;
	proc mixed data=c.camp method=ml;
	title "Model C visitc_num + TG";
	class id tg;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
	
	*Model E: Visitc + TG + age_rz;
	proc mixed data=c.camp method=ml;
	title "Model D visitc_num + TG + age_rz";
	class id tg;
	model posfev = visitc_num TG age_rz visitc_num*TG visitc_num*age_rz /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
 
 
*****************************************************
		
			Models A Through E

*****************************************************;
*Model A: Intercept only;
proc mixed data=c.camp method=ml covtest; 	
	title "Model A Unconditional Means Model";
	class id;
	model posfev =/solution notest;
	random intercept/sub=id;
	run;

*Model B: Visitc;
	proc mixed data=c.camp method=ml covtest;
	title "Model B Unconditional Growth Model with visitc_num";
	class id;
	model posfev = visitc_num/solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
	
*Model C: Visitc + TG;
	proc mixed data=c.camp method=ml covtest;
	title "Model C visitc_num + TG";
	class id tg;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;

*Model D: Visitc + TG + age_rz;
	proc mixed data=c.camp method=ml covtest;
	title "Model D visitc_num + TG + age_rz";
	class id tg;
	model posfev = visitc_num TG age_rz visitc_num*TG visitc_num*age_rz /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;

*Model E: Visitc + TG + age_rz;
	proc mixed data=c.camp method=ml covtest;
	title "Model D visitc_num + TG + age_rz";
	class id tg gender;
	model posfev = visitc_num TG gender visitc_num*TG visitc_num*gender /solution notest;
	random intercept visitc_num/ type=un sub=id;
	run;
 