libname c "/home/u49993673/CAMP";

proc contents data=c.camp_teach;
run;

***************************************************************************

			Create a subset of CAMP_teach with variables of interest

***************************************************************************;

	Data c.camp;
	set c.camp_teach;
	if visitc = "000" then visitc_num = 0;
	if visitc = "002" then visitc_num = 2;
	if visitc = "004" then visitc_num = 4;
	if visitc = "012" then visitc_num = 12;
	if visitc = "016" then visitc_num = 16;
	if visitc = "024" then visitc_num = 24;
	if visitc = "028" then visitc_num = 28;
	if visitc = "036" then visitc_num = 36;
	if visitc = "040" then visitc_num = 40;
	if visitc = "044" then visitc_num = 44;
	if visitc = "048" then visitc_num = 48;
	if visitc = "052" then visitc_num = 52;
	if visitc = "056" then visitc_num = 56;
	if visitc = "060" then visitc_num = 60;
	if visitc = "064" then visitc_num = 64;
	if visitc = "072" then visitc_num = 72;
	if visitc = "084" then visitc_num = 84;
	if visitc = "096" then visitc_num = 96;
	if visitc = "108" then visitc_num = 108;
	if visitc = "120" then visitc_num = 120;
	
	fup_yr = visitc_num / 12;
	
	waves = visitc_num;
	
	keep posfev gender ethnic diff_fev gender age_rz TG
			visitc id waves visitc_num fup_yr;
	run;

	
	
	