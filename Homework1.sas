/*data carinsurance;
infile 'H:\Homework\car_insurance_19.csv' dlm=',' firstobs=2 expandtabs; 
input Customer $ State $ Cust_Life_Value Response $ Coverage $ Education $ 
Eff_date $ Employment_Status $ Gender $ Income LocationCode $ 
MaritalStatus $ MonthPreAuto LastClaimMonth PolicyInceptionMonth NoOfOpenComplaints
NoOfPolicies PolicyType $ Policy $ RenewOfferType $ SalesChannel $ 
TotalClaimAmount VehicleClass $ VehicleSize $
;
run;
proc print; run;
*/
/* Reading the dataset */
Data carinsurance;
proc import datafile= 'H:\Homework\car_insurance_19.csv'
out = carinsurance
DBMS = CSV replace; GUESSINGROWS = 60000; getnames=yes; 
run;
proc print; run;
/* Question 1*/ 
proc freq; table Gender Vehicle_Size Vehicle_Class; run;
/* Question 2 */
proc means; var Customer_Lifetime_Value; class Gender Vehicle_Size Vehicle_Class; run;
/* Question 3 */
data carinsurance1; set carinsurance;
if Vehicle_Size = "Medsize" or Vehicle_Size = "Large"; run;
proc ttest; var Customer_Lifetime_Value; class Vehicle_Size; run;
/* Question 4 */
data carinsurance2; set carinsurance;
if Gender = "F" or Gender = "M"; run;
proc ttest; var Customer_Lifetime_Value; class Gender; run;
/* Question 5 */
proc anova data = carinsurance;
class Sales_Channel;
model Customer_Lifetime_Value = Sales_Channel;
run;
proc means; var Customer_Lifetime_Value; class Sales_Channel; run;
/* Question 6 */
proc corr data = carinsurance; var Customer_Lifetime_Value Income; run;
proc univariate; var Customer_Lifetime_Value; run;
data carinsurance3; set carinsurance;
if Customer_lifetime_Value le 4000 then clv=1;
if Customer_lifetime_value gt 4000 and Customer_Lifetime_value lt 9000 then clv=2;
if Cuztomer_Lifetime_Value ge 9000 then clv=3;
run;
proc freq data=carinsurance3; table Education*clv/CHISQ;run;
proc freq data=carinsurance3; table Marital_Status*clv/CHISQ;run;
proc freq data=carinsurance3; table State*clv/CHISQ;run;
proc freq data=carinsurance3; table Location_Code*clv/CHISQ;run;
proc freq data=carinsurance3; table Gender*clv/CHISQ;run;
/* Question 7 */
proc freq; table Renew_Offer_Type*Response/chisq;run;
/* Question 8 */
proc anova; class Renew_Offer_Type; model Customer_Lifetime_Value = Renew_Offer_Type; run;
proc means; var Customer_Lifetime_Value; class Renew_Offer_Type; run;

data top_3_offers; set carinsurance; 
if Renew_Offer_Type = "Offer1" or Renew_Offer_Type = "Offer2" or Renew_Offer_Type = "Offer3";run;
/* Using anova to see if variances of three offer groups are different */
proc anova data = Top_3_Offers; class Renew_Offer_Type; model Customer_Lifetime_Value = Renew_Offer_Type; run;
/* ttest */
data Offer_1_3; set carinsurance;
if Renew_Offer_Type = "Offer1" or Renew_Offer_Type = "Offer3"; run;
proc ttest data = Offer_1_3; var Customer_Lifetime_Value; class Renew_Offer_Type; run;
data offer_1_2;set carinsurance; 
if Renew_Offer_Type = "Offer1" or Renew_Offer_Type = "Offer2"; run;
proc ttest data =offer_1_2; var Customer_Lifetime_Value; class Renew_Offer_Type;run ;
/* Question 9 */
data offer1; set carinsurance; if Renew_Offer_Type="Offer1";run;
data offer2; set carinsurance; if Renew_Offer_Type="Offer2";run;
data offer3; set carinsurance; if Renew_Offer_Type="Offer3";run;
data offer4; set carinsurance; if Renew_Offer_Type="Offer4";run;
proc anova data = offer1; class State; model Customer_Lifetime_Value=State ; run;
proc anova data = offer2; class State; model Customer_Lifetime_Value=State ; run;
proc anova data = offer3; class State; model Customer_Lifetime_Value=State ; run;
proc anova data = offer4; class State; model Customer_Lifetime_Value=State ; run;

 
