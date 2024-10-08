1)Show first name, last name, and gender of patients whose gender is 'M'

SELECT first_name,last_name,gender FROM patients where gender='M';

2)Show first name and last name of patients who does not have allergies. (null)

SELECT first_name,last_name FROM patients where allergies is null;

3)Show first name of patients that start with the letter 'C'

SELECT first_name FROM patients where first_name like "C%";

4)Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT first_name, last_name FROM patients where weight between 100 and 120;
(or)
SELECT
  first_name,
  last_name
FROM patients
WHERE weight >= 100 AND weight <= 120;

5)Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

update patients set allergies='NKA' where allergies is null;

6)Show first name and last name concatinated into one column to show their full name.

select concat(first_name,' ',last_name) as full_name from patients;

7)Show first name, last name, and the full province name of each patient.

Example: 'Ontario' instead of 'ON'

cross join:

select patients.first_name,patients.last_name,province_names.province_name from patients,province_names 
where patients.province_id=province_names.province_id;

8)Show how many patients have a birth_date with 2010 as the birth year.

select count(*) as total from patients where year(birth_date)= 2010;

9)Show the first_name, last_name, and height of the patient with the greatest height.

select first_name,last_name,height from patients where height=(select max(height) from patients);

10)Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000

select * from patients where patient_id in (1,45,534,879,1000);

11)Show the total number of admissions

select count(*) from admissions;

12)Show all the columns from admissions where the patient was admitted and discharged on the same day.

select * from admissions where admission_date=discharge_date;

13)Show the patient id and the total number of admissions for patient_id 579.

select patient_id,count(admission_date) from admissions where patient_id=579;

(or)

select patient_id,count(*) from admissions where patient_id=579;

14)Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

select distinct city from patients where province_id='NS';

15)Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70

select first_name,last_name,birth_date from patients where height>160 and weight>70;

16)Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'


select first_name,last_name,allergies from patients where allergies is not null and city='Hamilton';

17)Show unique birth years from patients and order them by ascending.

SELECT distinct year(birth_date) as birth_year FROM patients order by birth_year;

18)Show unique first names from the patients table which only occurs once in the list.

For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT first_name FROM patients group by first_name having count(first_name) =1;

19)Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT patient_id,first_name FROM patients where first_name like "s%s" and length(first_name)>5;

20)Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.


SELECT patients.patient_id,patients.first_name,patients.last_name FROM patients,admissions  where  patients.patient_id = admissions.patient_id and admissions.diagnosis ="Dementia";

21)Display every patient's first_name.
Order the list by the length of each name and then by alphabetically.


SELECT first_name FROM patients order by len(first_name),first_name;


22)Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.



SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;


23)Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.



select first_name,last_name,allergies from patients where allergies="Penicillin" or allergies="Morphine"
order by allergies,first_name,last_name;

24)Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

select patient_id,diagnosis from admissions group by patient_id, diagnosis having count(*) >1;


25)Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.


select city,count(patient_id) as num_patients from patients group by city order by num_patients desc,city;


26)Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

select  first_name,last_name, 'Patient' as role from patients union all select first_name,last_name,'Doctor' from doctors;



27)Show all allergies ordered by popularity. Remove NULL values from query.



SELECT
  allergies,
  COUNT(*) AS total_diagnosis
FROM patients
WHERE
  allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC



28)Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.



select first_name,last_name,birth_date from patients where year(birth_date)
  between 1970 and 1979 order by birth_date;

29)We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane


SELECT
  CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;


30)Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.


SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000



31)Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

select max(weight)-Min(weight) from patients group by last_name having last_name="Maroni";



32)Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.


SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC

33)Show all columns for patient_id 542's most recent admission_date.

SELECT * FROM admissions where patient_id=542 group by patient_id having  admission_date=max(admission_date);


34)Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

select patient_id,attending_doctor_id,diagnosis from admissions where (patient_id%2<>0 and attending_doctor_id in (1,5,19))
or (attending_doctor_id like "%2%" and len(patient_id)=3);


35)Show first_name, last_name, and the total number of admissions attended for each doctor.

Every admission has been attended by a doctor.


inner join:

select first_name,last_name,count(*) from admissions a join doctors d on
a.attending_doctor_id=d.doctor_id group by attending_doctor_id;

36)For each doctor, display their id, full name, and the first and last admission date they attended.


select doctor_id, concat(first_name," ",last_name) as full_name,min(admission_date),max(admission_date) from doctors d join admissions a on
a.attending_doctor_id=d.doctor_id group by attending_doctor_id;


37)Display the total amount of patients for each province. Order by descending.

SELECT province_name ,count(*) as total FROM patients p join province_names pr on p.province_id=pr.province_id group by
p.province_id order by
total desc;

38)For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem

3 tables joined

SELECT concat(patients.first_name,' ',patients.last_name) as full_name,diagnosis,concat(doctors.first_name,' ',doctors.last_name)
as doctor_fullname from 
patients join admissions join doctors on patients.patient_id=admissions.patient_id and 
       admissions.attending_doctor_id=doctors.doctor_id;

39)display the first name, last name and number of duplicate patients based on their first name and last name.

Ex: A patient with an identical name can be considered a duplicate.



SELECT first_name,last_name,count(*) as duplicates from patients group by first_name,last_name having
count(*)>1;

40)Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.


SELECT concat(first_name,' ',last_name)as full_name,round(height/30.48,1), round(weight*2.205,0),birth_date,
case 
when gender='M' then "MALE" else "FEMALE" end  from patients  ;


41) Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.))


SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions
  )






42)Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.


SELECT count(*) as pgr ,floor(weight/10)*10 as weight_group FROM patients group by weight_group order by weight_group desc;


43)Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.

weight is in units kg.

height is in units cm.


SELECT patient_id,weight,height,
(case when weight/power(height/100.0,2)>=30 then 1 else 0 end ) as isObese from patients;


44)Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information.


SELECT p.patient_id,p.first_name,p.last_name,d.specialty from patients p join 
admissions a  join doctors d on p.patient_id=a.patient_id and a.attending_doctor_id=d.doctor_id where
a.diagnosis="Epilepsy" and d.first_name="Lisa";



45)All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date




SELECT distinct p.patient_id, concat(p.patient_id,len(p.last_name),year(p.birth_date)) as temp_password from patients p join admissions a on p.patient_id=a.patient_id;


46)Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.

Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.


SELECT case when patient_id%2=0 then "Yes" else "No" end as has_insurance, 
 sum(case when patient_id%2=0 then 10 else 50 end) as cost_after_insurance from admissions group by has_insurance;


47)Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name


SELECT pr.province_name from province_names pr join patients p where pr.province_id=p.province_id
group by pr.province_name
having sum(gender='M')>sum(gender='F');

48)

We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'

SELECT * FROM patients where first_name like "__r%" and gender ="F" and month(birth_date) in (
2,5,12) and weight between 60 and 80 and patient_id%2<>0 and city="Kingston";  


49)Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.


SELECT round((count(*)*100.0)/(select count(*) from patients),2)'%' from patients
where gender ='M';  


50)For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

use of lag:- to get previous value 

SELECT  admission_date, count(admission_date) as admission_day,
count(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
from admissions group by admission_date 
 

51)Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

SELECT province_name from province_names order by (not  province_name="Ontario") ,province_name;

52)We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

SELECT  d.doctor_id ,concat(d.first_name,' ',d.last_name),d.specialty,year(a.admission_date) as y, count(*) from doctors
 d join admissions a on d.doctor_id=a.attending_doctor_id group by y,doctor_id;
