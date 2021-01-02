Libname c "/home/u49993673/CAMP";

*This code requires CAMP to be in wide format;

***************************************************************************
	Create a Correlation Matrix of Measurement Occations Using Wide Format
***************************************************************************;

data new;
set camp_wide;
rename posfev_wide2 = Measurement1;
rename posfev_wide4 = Measurement2;
rename posfev_wide12 = Measurement3;
rename posfev_wide16 = Measurement4;
rename posfev_wide24 = Measurement5;
rename posfev_wide28 = Measurement6;
rename posfev_wide36 = Measurement7;
rename posfev_wide40 = Measurement8;
rename posfev_wide44 = Measurement9;
rename posfev_wide48 = Measurement10;
rename posfev_wide52 = Measurement11;
rename posfev_wide56 = Measurement12;
rename posfev_wide60 = Measurement13;
rename posfev_wide64 = Measurement14;
rename posfev_wide72 = Measurement15;
rename posfev_wide84 = Measurement16;
rename posfev_wide96 = Measurement17;
rename posfev_wide108 = Measurement18;
rename posfev_wide120 = Measurement19;
run;


proc corr data=new;
var  				  Measurement1
                      Measurement2
                      Measurement3
                      Measurement4
                      Measurement5
                      Measurement6
                      Measurement7
                      Measurement8
                      Measurement9
                      Measurement10
                      Measurement11
                      Measurement12
                      Measurement13
                      Measurement14
                      Measurement15
                      Measurement16
                      Measurement17
                      Measurement18
                      Measurement19	;
run;


                     
