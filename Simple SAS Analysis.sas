options linesize = 64;

data drug; set sasuser.drug; run;
data bodyfat; set sasuser.bodyfat; run;

data analysis;
	merge 
	drug (in=in1)
	bodyfat (in=in2);
	if in1 and in2;
Run;

*Show the data;
**>>>ST:Verbatim(Label="Show Data", Frequency="Always");
Proc Print data = Analysis(obs = 10) noobs;
	Var PatientID DrugDose BloodP PctBodyFat1 Density Age;
Run;
**<<<;

*Number of observations;
%let dsid=%sysfunc(open(analysis));
%let num=%sysfunc(attrn(&dsid,nlobs));
%let rc=%sysfunc(close(&dsid));

**>>>ST:Value(Label="Total N", Frequency="Always", Type="Default");
%put &num;
**<<<;

*The average Blood Pressure;
**>>>ST:Verbatim(Label="Avg Blood Pressure", Frequency="Always");
Proc Means Data = Analysis;
	Var BloodP;
Run;
**<<<;

Proc Freq Data = Analysis;
	Table DrugDose;
	ods output onewayfreqs = DrugDose;
Run;

**>>>ST:Table(Label="Simple Table", Frequency="Always", Type="Default");
ods csv file = "%qsubstr(%sysget(SAS_EXECFILEPATH),1,%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname)))DrugDose.csv";
Proc Print Data = DrugDose Noobs; 
	Var DrugDose Frequency Percent;
Run;
ods csv close;
**<<<;

*A plot looking at the relationship between age and PctBodyFat1;
**>>>ST:Figure(Label="Age vs Body Fat", Frequency="Always");
ods pdf file = "%qsubstr(%sysget(SAS_EXECFILEPATH),1,%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname)))Body Fat Age.pdf";
Proc SgPlot Data = Analysis;
	Scatter x=age y=pctbodyfat1;
Run;
ods pdf close;
**<<<;

*A model for the linear relationship between body fat and age;
ods graphics off;
**>>>ST:Verbatim(Label="Regression", Frequency="Always");
Proc Reg Data = Analysis;
	Model pctbodyfat1 = age;
Run;
**<<<;
