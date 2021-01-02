libname c "/home/u49993673/CAMP";


*****************************************************

		Comparing Error covariance Matrixes

*****************************************************;
	

	*Independence model;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: ind";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=simple sub=id r rcorr;
	ods output fitstatistics = fitstat_ind;
	run;
	
	*Unstructured model;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: un";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=un sub=id r rcorr;
	ods output fitstatistics = fitstat_un;
	run;
	
	*Compound Symmetry;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: cs";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=cs sub=id r rcorr;
	ods output fitstatistics = fitstat_cs;
	run;
	
	*Hetereo Compound Symmetry;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: csh";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=csh sub=id r rcorr;
	ods output fitstatistics = fitstat_csh;
	run;
	
	*First order autoregressive structure;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: ar(1)";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=ar(1) sub=id r rcorr;
	ods output fitstatistics = fitstat_ar;
	run;
	
	*heterogenous autoregressive;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: ar(1)h";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=arh(1) sub=id r rcorr;
	ods output fitstatistics = fitstat_arh;
	run;
	
	*toeplitz;
	proc mixed data=c.camp method=reml covtest;
	title "Model C visitc_num + TG; Error Structure: toep";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	repeated waves/ type=toep sub=id r rcorr;
	ods output fitstatistics = fitstat_toep;
	run;
	
	*standard multilevel model;
	proc mixed data=c.camp;
	title "Model C visitc_num + TG; Error Structure: std";
	class id tg waves;
	model posfev = visitc_num TG visitc_num*TG /solution notest;
	random intercept visitc_num/type=un sub=id;
	ods output fitstatistics = fitstat_Std;
	run;

***************************************************

	Renaming "value" column of fit statistics table

**************************************************;
	data one;
	set fitstat_ind;
	IND = value;
	drop value;
	run;
	
	data two;
	set fitstat_std;
	STD = value;
	drop value;
	run;
	
	data three;
	set two;
	UN = "No Fit"; *<----------- Model did not converge using unstructured;
	drop STD;
	run;
	
	data four;
	set fitstat_cs;
	CS = value;
	drop value;
	run;
	
	data five;
	set fitstat_csh;
	CSH = value;
	drop value;
	run;
	
	data six;
	set fitstat_ar;
	AR = value;
	drop value;
	run;
	
	data seven;
	set fitstat_arh;
	ARH = value;
	drop value;
	run;
	
	data eight;
	set fitstat_toep;
	TOEP = value;
	drop value;
	run;

***************************************************;

***************************************************

	Merging fit statistics

**************************************************;

	data compare_covar_struc;
	    merge one two three four five six seven eight; *<---------- Merge fit statistics with common variable "Descr";
	    by Descr;
	run;
	
	proc print data=compare_covar_struc;
	run;
