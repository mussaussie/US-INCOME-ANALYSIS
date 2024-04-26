SELECT * FROM us_income_project.ushouseholdincome_statistics;

Select *
From us_income_project.ushouseholdincome
;

Select *
From us_income_project.ushouseholdincome_statistics;

# Lets Start Cleaning the Data by deleting duplicates

Delete From ushouseholdincome
Where row_id IN (
				select row_id 
                From ( select row_id,id,
		                          ROW_NUMBER() OVER ( PARTITION BY id order by id) as row_num
                       from us_income_project.ushouseholdincome
                       ) as dup
                 Where row_num > 1
	             );   
                       
	Select id, Count(id)
    from ushouseholdincome_statistics
    Group by id
    Having count(id) >1;
    
    ## we dont have any duplicates in the above table but the other table has 6 and we delete that.
    
    
update ushouseholdincome
SET State_name = 'Georgia'
Where State_name = 'georia';

UPDATE ushouseholdincome
SET place = 'Autaugaville'
WHERE City = 'Vinemont';

Select Type, Count(Type)
From ushouseholdincome
Group by Type ;

UPDATE ushouseholdincome
SET Type  = 'Borough'
Where Type = 'Boroughs';

select ALAND, AWATER
From ushouseholdincome
where ALAND IN ( '','0')
     OR AWATER IN ('', '0');
     
     
# Thats all cleaning we need which includes column name, duplciates and null values 

## Part Two Explonatory Data Analysis of US household income

Select State_Name , Sum(ALAND), SUM(AWATER)
from ushouseholdincome
Group by State_Name
Order by 2 DESC;     

#TEXAS has Largest Land Area now check for the WATER

Select State_Name , Sum(ALAND), SUM(AWATER)
from ushouseholdincome
Group by State_Name
Order by 3 DESC; 

Select State_Name , Sum(ALAND), SUM(AWATER)
from ushouseholdincome
Group by State_Name
Order by 3 DESC
Limit 10;

## Yep MICHIGAN.. top

SELECT 
    State_Name, SUM(ALAND), SUM(AWATER)
FROM
    ushouseholdincome
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;


Select ui.State_Name,  Mean, Median
From ushouseholdincome as ui
INNER JOIN ushouseholdincome_statistics as us
ON ui.id = us.id
Where Mean <> '0';



Select Type, Count(Type) ,ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
From ushouseholdincome as ui
INNER JOIN ushouseholdincome_statistics as us
      ON ui.id = us.id
Where Mean <> '0'
Group by 1
HAVING Count(Type) > 100
Order by 4 DESC
Limit 20;

# lets see which State in which community earn less

Select * 
From ushouseholdincome
Where Type = 'Community' ;

## it turn out to be Puerto Rico

## Check for the cities

Select ui.State_Name, City,ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
From ushouseholdincome as ui
INNER JOIN ushouseholdincome_statistics as us
      ON ui.id = us.id
Where Mean <> '0'
Group by ui.State_Name, City
Order by  ROUND(AVG(Mean),1) DESC ;

## Delta Junction in Alaska has the hihger mean AVG income.. 


