* Finding Philips Curve
clear all

global dir "/Users/bishmaybarik/Library/CloudStorage/OneDrive-ShivNadarInstitutionofEminence/Philips"

import delimited "$dir/02_Raw Data/CORESTICKM159SFRBATL.csv", clear
save "$dir/04_Clean Data/inflation.dta", replace

import delimited "$dir/02_Raw Data/UNRATE.csv", clear
save "$dir/04_Clean Data/unemployment.dta", replace

* Merging files

clear

* Checking whether there are duplicates

/* 

Please uncomment to check whether there are any duplicates
use "$dir/04_Clean Data/inflation.dta", clear
duplicates report date

use "$dir/04_Clean Data/unemployment.dta", clear
duplicates report date

*/

use "$dir/04_Clean Data/inflation.dta", clear
merge 1:1 date using "$dir/04_Clean Data/unemployment.dta"

drop _merge

* Generating the Philips Curve

rename corestickm159sfrbatl inflation

sort unrate inflation

twoway (scatter inflation unrate) ///
       (lfit inflation unrate), ///
       title("Phillips Curve: Inflation vs Unemployment Rate") ///
       xlabel(, format(%9.1f)) ylabel(, format(%9.1f)) ///
       xtitle("Unemployment Rate") ytitle("Inflation") legend(off)
