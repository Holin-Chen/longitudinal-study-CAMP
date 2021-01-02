libname c "/home/u49993673/CAMP";


data camp;
set c.camp;
time = visitc/12 ;
time_cat = time;
run;

*orignial plot;
*sganno=annotest7;
proc sgplot data=camp nowall sganno=annocamp; *<--- Run SGplot with Annotation dataset;
styleattrs datacontrastcolors=(purple green orange)
             datalinepatterns=(solid)
             backcolor=whitesmoke
             ;
reg y=posfev x=time / cli cliattrs=(CLILINEATTRS=(pattern=2 thickness=0.1)) lineattrs=(pattern=1
thickness=0.01)
  nomarkers group=tg;
yaxis min=0 max=4;
 xaxis display=(nolabel noline noticks) valueattrs=(color=black) values= (0 to 10 by 1);
 yaxis display=(nolabel noline noticks) valueattrs=(color=black);
 yaxis label="FEV1 After Treatment (liters per sec)" labelattrs=(weight=bold) valueattrs=(color=black weight=bold) 
 values=(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5,4, 4.5, 5, 5.5, 6);
 xaxis label="Years Since Randomization" labelattrs=(weight=bold) ;
run;
ods trace on;
proc mixed data=camp method=ml covtest;
title "heterogenous autoregressive Error
Covariance Matrix";
class id TG time_cat;
model posfev = time TG time*TG/solution notest;
repeated time_cat/type=arh(1) sub=id;
estimate "posfev at follow up year 0 in A" intercept 1 TG 1 0 0 time 0 TG*time 0 0 0 /cl;
estimate "posfev at follow up year 0 in B" intercept 1 TG 0 1 0 time 0 TG*time 0 0 0 /cl;
estimate "posfev at follow up year 0 in C" intercept 1 TG 0 0 1 time 0 TG*time 0 0 0 /cl;
estimate "posfev at follow up year 2 in A" intercept 1 TG 1 0 0 time 2 TG*time 2 0 0 /cl;
estimate "posfev at follow up year 2 in B" intercept 1 TG 0 1 0 time 2 TG*time 0 2 0 /cl;
estimate "posfev at follow up year 2 in C" intercept 1 TG 0 0 1 time 2 TG*time 0 0 2 /cl; 
estimate "posfev at follow up year 4 in A" intercept 1 TG 1 0 0 time 4 TG*time 4 0 0 /cl;
estimate "posfev at follow up year 4 in B" intercept 1 TG 0 1 0 time 4 TG*time 0 4 0 /cl;
estimate "posfev at follow up year 4 in C" intercept 1 TG 0 0 1 time 4 TG*time 0 0 4 /cl;
estimate "posfev at follow up year 5 in A" intercept 1 TG 1 0 0 time 5 TG*time 5 0 0 /cl;
estimate "posfev at follow up year 5 in B" intercept 1 TG 0 1 0 time 5 TG*time 0 5 0 /cl;
estimate "posfev at follow up year 5 in C" intercept 1 TG 0 0 1 time 5 TG*time 0 0 5 /cl;
estimate "posfev at follow up year 6 in A" intercept 1 TG 1 0 0 time 6 TG*time 6 0 0 /cl;
estimate "posfev at follow up year 6 in B" intercept 1 TG 0 1 0 time 6 TG*time 0 6 0 /cl;
estimate "posfev at follow up year 6 in C" intercept 1 TG 0 0 1 time 6 TG*time 0 0 6 /cl;
estimate "posfev at follow up year 8 in A" intercept 1 TG 1 0 0 time 8 TG*time 8 0 0 /cl;
estimate "posfev at follow up year 8 in B" intercept 1 TG 0 1 0 time 8 TG*time 0 8 0 /cl;
estimate "posfev at follow up year 8 in C" intercept 1 TG 0 0 1 time 8 TG*time 0 0 8 /cl;
estimate "posfev at follow up year 10 in A" intercept 1 TG 1 0 0 time 10 TG*time 10 0 0 /cl;
estimate "posfev at follow up year 10 in B" intercept 1 TG 0 1 0 time 10 TG*time 0 10 0 /cl;
estimate "posfev at follow up year 10 in C" intercept 1 TG 0 0 1 time 10 TG*time 0 0 10 /cl;
ods output estimates= est;
run;
ods trace off;

proc print data=est;
run;

data camp_est;
set est;
left = estimate - StdErr;
right = estimate + StdErr;
keep label estimate StdErr left right;
run;

proc print data=camp_est;
run;
*combine the mean estimates and standard errors to the original data set; 
data camp_stderr;
set camp;
if TG = "A" and time = 0 then estimate=1.8589;
if TG = "A" and time = 0 then left = 1.82700;
if TG = "A" and time = 0 then right = 1.89084;

if TG = "B" and time = 0 then estimate=1.7422;
if TG = "B" and time = 0 then left = 1.71029;
if TG = "B" and time = 0 then right = 1.77409;

if TG = "C" and time = 0 then estimate=1.7898;
if TG = "C" and time = 0 then left = 1.76186;
if TG = "C" and time = 0 then right = 1.81767;


if TG = "A" and time = 5 then estimate=2.9211;
if TG = "A" and time = 5 then left = 2.87748;
if TG = "A" and time = 5 then right = 2.96463;

if TG = "B" and time = 5 then estimate=2.8987;
if TG = "B" and time = 5 then left = 2.85501;
if TG = "B" and time = 5 then right = 2.94243;

if TG = "C" and time = 5 then estimate=2.8723;
if TG = "C" and time = 5 then left = 2.83442;
if TG = "C" and time = 5 then right = 2.91019;


if TG = "A" and time = 10 then estimate=3.9832;
if TG = "A" and time = 10 then left = 3.91580;
if TG = "A" and time = 10 then right = 4.05057;

if TG = "B" and time = 10 then estimate=4.0553;
if TG = "B" and time = 10 then left = 3.98755;
if TG = "B" and time = 10 then right = 4.12296;

if TG = "C" and time = 10 then estimate=3.9548;
if TG = "C" and time = 10 then left = 3.89638;
if TG = "C" and time = 10 then right = 4.01331;
run;
*The original plot added with the standard error bars;
proc sgplot data=camp_stderr nowall sganno=annocamp; *<--- Run SGplot with Annotation dataset;
styleattrs datacontrastcolors=(purple green orange)
             datalinepatterns=(solid)
             backcolor=whitesmoke
             ;
reg y=posfev x=time / cli cliattrs=(CLILINEATTRS=(pattern=2 thickness=0.1)) lineattrs=(pattern=1
thickness=0.01)
  nomarkers group=tg;
scatter y=estimate x=time/ group=TG yerrorlower=left yerrorupper=right
markerattrs=(symbol=Circle size=5);
yaxis min=0 max=4;
 xaxis display=(nolabel noline noticks) valueattrs=(color=black) values= (0 to 10 by 1);
 yaxis display=(nolabel noline noticks) valueattrs=(color=black);
 yaxis label="FEV1 After Treatment (liters per sec)" labelattrs=(weight=bold) valueattrs=(color=black weight=bold) 
 values=(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5,4, 4.5, 5, 5.5, 6);
 xaxis label="Years Since Randomization" labelattrs=(weight=bold) 
 values =(0,1,2,3,4,5,6,7,8,9,10);
run;
*The zoom in plot without confidence interval and with only the standard error bars; 
proc sgplot data=camp_stderr nowall sganno=annocamp; *<--- Run SGplot with Annotation dataset;
styleattrs datacontrastcolors=(purple green orange)
             datalinepatterns=(solid)
             backcolor=whitesmoke
             ;
reg y=posfev x=time / cliattrs=(CLILINEATTRS=(pattern=2 thickness=0.1)) lineattrs=(pattern=1
thickness=0.01)
  nomarkers group=tg;
scatter y=estimate x=time/ group=TG yerrorlower=left yerrorupper=right
markerattrs=(symbol=Circle size=5);
yaxis min=0 max=4;
 xaxis display=(nolabel noline noticks) valueattrs=(color=black) values= (0 to 10 by 1);
 yaxis display=(nolabel noline noticks) valueattrs=(color=black);
 yaxis label="FEV1 After Treatment (liters per sec)" labelattrs=(weight=bold) valueattrs=(color=black weight=bold) 
 values=(1.5, 2, 2.5, 3, 3.5,4, 4.5);
 xaxis label="Years Since Randomization" labelattrs=(weight=bold) 
 values =(0,1,2,3,4,5,6,7,8,9,10);
run;
