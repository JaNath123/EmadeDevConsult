Use EmadeDev
Go
/**
						=====================================================================
						DEVELOPER: MR BEN
						CREATE DATE:		02/15/2025
						PROJECT		HEALTHCARE PROJECT
						DESCRIPTION:	HEALTHCARE PROJECT
						VERSION: 1
						====================================================================
**/

Select *
FROM[dbo].[healthcare_dataAnalysis]

/*
DATA ANALYSIS USING SQL ON HEALTHCARE_DATASET DATABASE
*/

--1. COUNTING Total Record in the database

SELECT COUNT (*) 
FROM Healthcare_dataAnalysis

--2.Finding maximum age of patients admitted 

SELECT Gender, Hospital, Max(Age) as MaximumAgeOfPatients
FROM Healthcare_dataAnalysis
GROUP BY Age,Gender, Hospital
ORDER BY MaximumAgeOfPatients DESC, Age DESC

--3. Finding Average age of Hospitalized patient

SELECT ROUND(avg(age),0) AS Averge_age 
FROM healthcare_dataAnalysis

--4. Calculating patient Hospitalized age-wise from maximum to minimum

SELECT Age, count(age) as totalofPatientHospitalised
FROM Healthcare_dataAnalysis
GROUP BY age
ORDER BY Age DESC

-- 5.Calculating maximum count of patient on basis of total patient hospitalized with respect to age

SELECT Age, count(Age) AS TotalPatientHospitalizedInRespectToAge
FROM healthcare_dataAnalysis
GROUP BY Age
ORDER BY TotalPatientHospitalizedInRespectToAge DESC, Age DESC

--6. RANKING Age on the number of patients hospitalized

SELECT Age, Count(Age) AS TOTAL, dense_Rank() over(ORDER BY COUNT(AGE) DESC, Age DESC) as RankingAge
FROM Healthcare_dataAnalysis
GROUP BY Age
--HAVING Total > Avg(Age)
ORDER BY total DESC, Age DESC


--7. Find Count of Medical Condition of Pateient and listing it by Maxium number of patients

SELECT Medical_Condition, Count(Medical_Condition) AS  MaximumNoOfPatient
FROM Healthcare_dataAnalysis
GROUP BY Medical_Condition
ORDER BY MaximumNoOfPatient DESC, Medical_Condition DESC


--8. Find the Rank and Maximum number of medicines recommended to patients based on medical condition partaining to them

SELECT Medical_Condition, Medication, Count (Medication) AS MaximumNoOfMedicines, 
dense_Rank() over(order by Count (Medication) DESC, Medication) AS Rank
FROM Healthcare_dataAnalysis
GROUP BY Medication, Medical_Condition
--HAVING Max(Medication)=Medication
ORDER BY MaximumNoOfMedicines DESC, Medication DESC

SELECT *
FROM Healthcare_dataAnalysis


--9. Most prefered insurrance provider by patients hospitalized

SELECT  Insurance_provider, COUNT(Insurance_provider) as MostPreferred
FROM healthcare_dataAnalysis
GROUP BY Insurance_provider
ORDER BY Insurance_provider DESC, MostPreferred DESC

--10. Finding out the most preferred hospital by patients

SELECT Top  10 * (Hospital, Count(Hospital)) as MostPreferredHospital 
FROM Healthcare_dataAnalysis
GROUP BY Hospital
ORDER BY MostPreferedHospital DESC

Most Preferred Hospitalselect top 1 *from (SELECT Hospital, COUNT(hospital) AS Total FROM HealthcareDataSetGROUP BY Hospital)xORDER BY Total DESC;

--11. Identiying Avarage Billing Amount by Medical_Condition

SELECT Medical_Condition, Round (Avg(Billing_Amount),2) as AverageBilling
FROM Healthcare_dataAnalysis
GROUP BY Medical_Condition
ORDER BY AverageBilling DESC , Medical_Condition DESC 

--Note from Class
-- 11. Identifying Average Billing Amount by Medical Condition.SELECT Medical_Condition, ROUND(AVG(Billing_Amount),2) AS Avg_Billing_AmountFROM HealthcareDataSetGROUP BY Medical_Condition;

--from Edie
SELECT [Medical Condition], ROUND(AVG(TRY_CAST([Billing Amount] AS FLOAT)),2) AS Average_BillingFROM HealthCareDatasetGROUP BY [Medical Condition]ORDER BY Average_Billing DESC

--12. Finding Billing Amount of Patients admitted and number of days spent in the respective facilities

SELECT Name, Hospital, ROUND (Sum(Billing_Amount),2) AS BillingAmountPatientAdmitted,
DATEDIFF(Day,Date_of_Admission, Discharge_Date) AS DaysSpent
FROM Healthcare_dataAnalysis
GROUP BY Hospital,Name, Billing_Amount, Date_of_Admission, Discharge_Date
ORDER BY BillingAmountPatientAdmitted DESC, DaysSpent DESC

/*from Class
- 12. Finding Billing Amount of patients admitted and number of days spent in respective hospital.SELECT Medical_Condition, Name, Hospital, DATEDIFF(DAY,Date_of_Admission,Discharge_date) as Number_of_Days, SUM(ROUND(Billing_Amount,2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_AmountFROM HealthcareDataSetORDER BY Medical_Condition
*/



--13. Finding Total number of days spent by patient in a hospital for a given Medical Condition

SELECT Name, Hospital, Medical_Condition, DateDiff(Day,Date_of_Admission, Discharge_Date) as TotalNumberOfDays
FROM Healthcare_dataAnalysis
--GROUP BY Name
ORDER BY TotalNumberOfDays ASC

/* FROM CLASS-- 13. Finding Total number of days sepnt by patient in an hospital for given medical conditionSELECT Name, Medical_Condition, ROUND(Billing_Amount,2) as Billing_Amount, Hospital, DATEDIFF(DAY,Date_of_Admission,Discharge_Date) as Total_Hospitalized_daysFROM HealthcareDataSet;
*/




--14. Finding Hospital which were successful in discharging patients after having test result as 'Normal' with 
-- count of days taken to get result to normal.

SELECT Hospital,Medical_Condition, Test_Results, Sum(DateDiff(Day, Date_of_Admission, Discharge_Date)) AS CountOfDays
FROM Healthcare_dataAnalysis
GROUP BY Hospital, Test_Results, Medical_Condition
HAVING Test_Results = 'Normal'
ORDER BY CountOfDays ASC
--GROUP BY Hospital,Test_Results
--WHERE Test_Result = 'Normal',THEN 'Successful'
--ORDER BY Hospital Desc, Successful ASC

/* FROM CLASS -- 14. Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to NormalSELECT Medical_Condition, Hospital, DATEDIFF(DAY, Date_of_Admission,Discharge_Date) as Total_Hospitalized_days,Test_resultsFROM HealthcareDataSetWHERE Test_results LIKE 'Normal'ORDER BY Medical_Condition, Hospital
*/

---15. Calculate number of blood types of patients which lies between age 20 to 45

SELECT Age,Blood_Type, Count(*) As BloodTypeOfPatients
FROM HealthCare_dataAnalysis
GROUP BY Blood_Type, Age
HAVING Age Between 20 and 45
ORDER BY Age DESC

/* FROM CLASS
-- 15. Calculate number of blood types of patients which lies betwwen age 20 to 45SELECT Age, Blood_type,COUNT(Blood_Type) as Count_Blood_TypeFROM HealthcareDataSetWHERE AGE BETWEEN 20 AND 45GROUP BY Age, Blood_typeORDER BY Blood_Type DESC;
*/

--16. Find how many of patient are universal Blood Donor and universal Blood reciever

SELECT Blood_Type, Count (*) AS BloodDonor, Count(*) AS BloodReciever 
FROM Healthcare_dataAnalysis
GROUP BY Blood_Type
HAVING Blood_Type = 'O+' OR Blood_Type = 'AB+'
OR Blood_Type = 'O-'OR Blood_Type = 'AB-'
ORDER BY BloodDonor DESC, BloodReciever DESC

/*
FROM CLASS
-- 16. Find how many of patient are Universal Blood Donor and Universal Blood recieverSELECT DISTINCT (SELECT Count(Blood_Type) FROM HealthcareDataSet WHERE Blood_Type IN ('O-')) AS Universal_Blood_Donor, (SELECT Count(Blood_Type) FROM HealthcareDataSet WHERE Blood_Type  IN ('AB+')) as Universal_Blood_recieverFROM HealthcareDataSet;*/SELECT Patients, Blood_Type, Donor_Reciver_Status From( Select Blood_Type, Count(NAME) Patients, Case  when Blood_Type like '%O-%' then 'Universal Blood Donor' when Blood_Type like '%AB+%' THEN 'Universal Blood reciever' ELSE ' ' END Donor_Reciver_Status FROM Emade_dev.[dbo].[healthcare_dataset] Where Blood_Type IN ('O-' , 'AB+') Group by Blood_Type) x