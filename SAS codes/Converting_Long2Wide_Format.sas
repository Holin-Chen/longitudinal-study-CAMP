libname c "/home/u49993673/CAMP";

data camp;
set c.camp;
run;

proc sort data=camp;
by id;
run;

proc transpose data=camp out=camp_wide prefix=posfev_wide;
    by id;
    id visitc_num;
    var posfev;
run;

proc print data=camp_wide (obs=10);
run;

***********************************************************************************
* posfev_wide is not in the right order. Variables appear in the order they were  *
*	created which is not what we want.											  *
*					Reorder variables using RETAIN statement 	                  *
***********************************************************************************;
		
		proc contents data=camp_wide;
		ods output variables =camp_wide_var; *<--- Proc contents has variables in        ;
		run;								 *       alphabetical and chronological order;
			data camp_wide_var;
			set camp_wide_var;
			keep variable; *<----Drop useless info to grab variables easier
			run;
				proc print data=camp_wide_var noobs;
				run; *Copy and paste the single column of variables for RETAIN statement;
		
		
						/* 			
						_LABEL_
						_NAME_
						id
						posfev_wide0
						posfev_wide2
						posfev_wide4
						posfev_wide12
						posfev_wide16
						posfev_wide24
						posfev_wide28
						posfev_wide36
						posfev_wide40
						posfev_wide44
						posfev_wide48
						posfev_wide52
						posfev_wide56
						posfev_wide60
						posfev_wide64
						posfev_wide72
						posfev_wide84
						posfev_wide96
						posfev_wide108
						posfev_wide120
						*/

										data camp_wide2;
* reorders in the order you list-->;	retain _label_ _name_ id  
										posfev_wide0	               	 
										posfev_wide2	               	 
										posfev_wide4	               	 
										posfev_wide12	                
										posfev_wide16	               
										posfev_wide24	               
										posfev_wide28	               	 
										posfev_wide36	                
										posfev_wide40	                
										posfev_wide44	               	 
										posfev_wide48	                
										posfev_wide52	               
										posfev_wide56	               	 
										posfev_wide60	               	 
										posfev_wide64	               	 
										posfev_wide72	                      	 
										posfev_wide84	                
										posfev_wide96	               	 
										posfev_wide108              	 
										posfev_wide120;
										   set camp_wide;
										run;

*Posfev_wide is now in the correct order!;

proc print data=camp_wide2 (obs=10);
run;

*Make it permanent;

data c.camp_wide;
set camp_wide2;
run; *<-saving;

