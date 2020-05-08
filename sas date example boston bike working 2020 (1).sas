data bostonblue201909; set bostonbluesept2019;

Data all; set bostonblue201909;
     trip = 1;
     tripmin = tripduration/60;
	 tripcost = tripmin*.25;

     sex = "Unknown";
	 if gender = 1 then sex="Male   ";
     if gender = 2 then sex="Female ";
    if birth_year le 1970 then Generation = "OLD     ";
if 1971 le birth_year lt 1980 then Generation = "Mill    ";
if 1981 le birth_year lt 1990 then Generation = "GenX    ";
if 1991 le birth_year lt 2008 then Generation = "Young   ";

syrmoda = substr (starttime,1,10);
sdate = input(syrmoda,yymmdd10.);

eyrmoda = substr (stoptime,1,10);
edate = input(eyrmoda,yymmdd10.);


proc contents;

proc means;

proc corr;

proc sort; by end_station_name end_station_latitude end_station_longitude;


PROC SUMMARY DATA=all MISSING NWAY;
   CLASS end_station_name end_station_latitude end_station_longitude;
   var  trip tripmin tripcost ; 
 
   OUTPUT OUT=y SUM=;

proc print;


options linesize=256;
var end_station_name end_station_latitude end_station_longitude trip tripmin tripcost;
format trip comma14.0 tripmin comma15.2 tripcost dollar15.2;

run;

proc gplot;
   plot  end_station_latitude * end_station_longitude
        
;

data all; set all

proc sort; by sdate;


PROC SUMMARY DATA=all MISSING NWAY;
   CLASS sdate;
   var  trip tripmin tripcost ; 
 
   OUTPUT OUT=y SUM=;

proc print;


options linesize=256;
var sdate trip tripmin tripcost;
format sdate yymmdd10. trip comma14.0 tripmin comma15.2 tripcost dollar15.2;

run;

symbol1 interpol=join
        value=dot; 


proc gplot;
   plot  trip * sdate;
   format sdate yymmdd10.
       
;






Run;

Run;
