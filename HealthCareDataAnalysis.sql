Use EmadeDev
Go

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

SELECT Medication, Max (Medication) AS MaximumNoOfMedicines, dense_Rank() over(order by Max (Medication) DESC, Medication) AS Rank
FROM Healthcare_dataAnalysis
GROUP BY Medication
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

SELECT Top 5 * --as MostPreferredHospital Dense_Rank() over(order by COUNT(Hospital) DESC Hospital) as Rank
FROM Healthcare_dataAnalysis
--GROUP BY Hospital
ORDER BY Hospital DESC
--ORDER BY MostPreferredHospital DESC --Hospital DESC

--11. Identiying Avarage Billing Amount by Medical_Condition

SELECT Medical_Condition, Round (Avg(Billing_Amount),0) as AverageBilling
FROM Healthcare_dataAnalysis
GROUP BY Medical_Condition
ORDER BY AverageBilling DESC , Medical_Condition DESC 

--12. Finding Billing Amount of Patients admitted and number of days spent in the respective facilities

SELECT Name, Hospital, ROUND (Sum(Billing_Amount),0) AS BillingAmountPatientAdmitted, DATEDIFF(Day,Date_of_Admission, Discharge_Date) AS DaysSpent
FROM Healthcare_dataAnalysis
GROUP BY Hospital,Name, Billing_Amount, Date_of_Admission, Discharge_Date
ORDER BY BillingAmountPatientAdmitted DESC, DaysSpent DESC

--13. Finding Total number of days spent by patient in a hospital for a given Medical Condition

SELECT Name, Hospital, Medical_Condition, DateDiff(Day,Date_of_Admission, Discharge_Date) as TotalNumberOfDays
FROM Healthcare_dataAnalysis
--GROUP BY Name
ORDER BY TotalNumberOfDays ASC


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


---15. Calculate number of blood types of patients which lies between age 20 to 45

SELECT Age,Blood_Type, Count(*) As BloodTypeOfPatients
FROM HealthCare_dataAnalysis
GROUP BY Blood_Type, Age
HAVING Age Between 20 and 45
ORDER BY Age DESC



--16. Find how many of patient are universal Blood Donor and universal Blood reciever

SELECT Blood_Type, Count (*) AS BloodDonor, Count(*) AS BloodReciever 
FROM Healthcare_dataAnalysis
GROUP BY Blood_Type
HAVING Blood_Type = 'O+' OR Blood_Type = 'AB+'
OR Blood_Type = 'O-'OR Blood_Type = 'AB-'
ORDER BY BloodDonor DESC, BloodReciever DESC
