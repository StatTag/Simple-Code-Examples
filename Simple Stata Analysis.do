
sysuse "bpwide"

*Show the data;

**>>>ST:Verbatim(Label="Show Data", Frequency="Always")
list if _n<=10
**<<<

*Number of observations;
count
**>>>ST:Value(Label="N obs", Frequency="Always", Type="Numeric", Decimals=0, Thousands=False)
display r(N)
**<<<

*mean of bp before
summarize bp_before
**>>>ST:Value(Label="BP before mean", Frequency="Always", Type="Numeric", Decimals=1, Thousands=False)
display r(mean)
**<<<
**>>>ST:Value(Label="BP before sd", Frequency="Always", Type="Numeric", Decimals=1, Thousands=False)
display r(sd)
**<<<

**>>>ST:Table(Label="Age Groups", Frequency="Always", Type="Default")
*Table of Age Groups
tabulate agegrp, matcell(x)
matrix list x
**<<<

local dir `c(pwd)'

*Graph of BP before by agegrp
**>>>ST:Figure(Label="BP by Age Group", Frequency="Always")
graph box bp_before, over(agegrp) title("Blood Pressure by Age Group")
graph export "`c(pwd)'\BloodPressurebyAgeGroup.pdf", as(pdf) replace
**<<<

*Model of relationship between bloodpressure anf age group
**>>>ST:Verbatim(Label="Univariate Model", Frequency="Always")
xi: regress bp_before i.agegrp
**<<<
