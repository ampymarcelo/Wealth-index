
 ///////////////////////////
gen maison= C1
 replace maison=. if C1==.
 replace maison=1 if C1==1
 replace maison=0 if C1 ==2 | C1==3 | C1==77 
 
 tab maison
 
 ///////////////////////////
 gen Propmaison= C3
 replace Propmaison=. if C3==.
 replace Propmaison=1 if C3==1
 replace Propmaison=0 if C3 ==2 | C3==3 | C3==77 
 
 tab Propmaison
 
 
  ///////////////////////////
 gen Mur= C4
 replace Mur=. if C4==.
 replace Mur=1 if C4==1 | C4 ==2 
 replace Mur=0 if C4 ==3 | C4==4 | C4==5 | C4==6 | C4==7 | C4==8 | C4==77  
 
 tab Mur
 
  ///////////////////////////
  gen Toit= C5
 replace Toit=. if C5==.
 replace Toit=1 if C5 ==2 
 replace Toit=0 if C5==1 | C5 ==3 | C5==4 | C5==5 | C5==6 | C5==7 | C5==77  
 
 tab Toit
 
 ///////////////////////////
   gen dallage = C6
 replace dallage =. if C6==.
 replace dallage =1 if C6==6 
 replace dallage =0 if C6==1 | C6 ==2 | C6 ==3 | C6==4 | C6==5 | C6==7 | C6==77  
 
 tab dallage
 
 ///////////////////////////
 
    gen electricite = C7
 replace electricite =. if C7==.
 replace electricite =1 if C7==1
 replace electricite =0 if C7 ==2 | C7 ==3 | C7 ==4 | C7 ==5 | C7==6 | C7 ==7 | C7 ==77  
 
 tab electricite
 
  ///////////////////////////
  gen eau = C8
  
 replace eau =. if C8==.
 replace eau =1 if inlist(C8, 1, 2, 3, 4, 5, 6, 8)
 replace eau =0 if inlist(C8, 7, 9, 10, 11, 12, 13, 14, 77)
 
  tab eau
  
 ///////////////////////////
 
  gen toilet = C10
  
 replace toilet =. if C10 ==.
 replace toilet =1 if inlist(C10, 1, 2)
 replace toilet =0 if inlist(C10, 3, 4, 5, 6, 7, 77)
 
  tab toilet
  
///////////////////////////
  
  recode D1-D29 (2=0)
  
  ///////////////////////////
  
 fac maison toilet eau dallage electricite Toit Mur Propmaison maison D1-D29
 
xtile asset_index=fac1,n(5)
 
sum maison toilet eau dallage electricite Toit Mur Propmaison maison D1-D29

***

estat kmo
predict Comp1
rename Comp1 quintile

xtile Niveau_quintile  = quintile,nq(5)

lab def Niveau_quintile 1 "Plus pauvre" 2 "Pauvre" 3 "Moyen" 4 "Riche" 5 "Plus riche"
lab val Niveau_quintile  Niveau_quintile
lab var Niveau_quintile "Niveau de vie"

tab Niveau_quintile


lab def Niveau_quintile 1 "Plus pauvre" 2 "Pauvre" 3 "Moyen" 4 "Riche" 5 "Plus riche", modify



