/* FAdel */
/*retirve order_provider's name and patient's name sent by them and the test's name patient order Q1*/
use mydb;
select OP_name as order_provider,P_name as patient_name,direct_Date,T_name as test_name
from order_provider as o,patient as p,patient_order_test as ot,test as t,direct as di
where o.ID=di.Order_provider_ID and p.ID=di.patient_ID and  p.ID=ot.patient_ID and t.T_code=ot.test_T_code;


/* retrieve report contain secretary's name that give the report and doctor name's that do the test
and release date and test name and actual value of test and statu of result Q2*/
select r.id as report_id, P_name as patient_name , S_name as secratary_name, R_date as release_date
 ,T_name, doctor_name, actual_value,tr.status 
from patient as p,report as r,staff as s,sceratary as c,test as t,t_result as tr
where p.ID=r.Patient_ID and c.staff_ssn=r.Sceratary_staff_ssn1 and c.staff_ssn=s.ssn 
and tr.ID=r.result_ID and tr.test_T_code=t.T_code
 order by report_id;
 
 /*retrieve patient's name and total price he will pay  Q3*/
select p_name,sum(t_price)
from patient,test,patient_order_test
where id=patient_id and t_code=test_t_code
group by p_name
order by 2 desc;
 
 /* retrieve name ,salary of staff member who work at the branch that have maximum salary Q4*/
select S_name,salary
from staff
where Branch_id=
(select Branch_id
from staff
where salary=
(select max(salary)
from staff));

/*retrieve secratary's name and doctor's name and manegar's name that work in branch with id=1 Q5 */
select  b.ID as Branch_ID,c.S_name as secretary_name,d.S_name as doctor_name,m.S_name as mngr_name
from staff as c,staff as d,staff as m,sceratary as se,doctor as dc,manager as ma,branch as b
where c.Branch_id=b.ID and d.Branch_id=b.ID and m.ssn=ma.staff_ssn
and c.ssn=se.staff_ssn and d.ssn=dc.staff_ssn and b.manager_staff_ssn=m.ssn
and b.ID=1;
///////////////////////////////////////////////////////////////////////////////////////
/*Badr*/
/* retrieve oeder provider name and the number of patient that he direct  Q 6*/
select op_name,count(patient_id) as no_patient
from direct,Order_provider
where
id=order_provider_id
group by op_name;

/* retrieve patient name, his/her id,branch id and the rate that is more 
than the average of rate for all branches  Q7*/
select p_name, patient_id,branch_id,rate from rate,patient where
rate>= (select avg(rate) from rate) and id=patient_id;

/* reteieve all patient name and the total price descending order Q8 */
select p_name,sum(t_price) as total_price
from patient,test,patient_order_test
where id=patient_id
and t_code=test_t_code
group by p_name 
order by 2 desc;

/* retrieve each branch info and average of staff salary descinding order Q9*/
select branch_id,avg(salary) as average_of_salary,b.phone,b.b_address from staff,branch b
where branch_id=b.id
group by branch_id
order by 2 desc;
////////////////////////////////////////////////////////////////////////////////////////////////////
/*Iraqi*/
/*retrive patient name ,order_provider name for patient that has directed from doctor or not Q10*/
use mydb;
select P_name as patient_name  ,OP_name
from patient p 
left outer join direct d  
on p.ID= d.patient_ID 
left outer join order_provider o
on d.Order_provider_ID=o.ID ;

/*RETRIVE patient name and number of abnormal test results for each one Q11*/
select p.P_name , count(t.ID) as abnormal_tests
from patient p , report r , t_result t
where p.ID=r.Patient_ID and r.result_ID = t.ID and status in ('abnormal')
group by p.P_name;

/*retrieve branch number and manager name where rate of branch more than avg rate of all branches Q12*/
select b.ID , s.S_name ,r.Rate
from branch b, staff s , manager m , rate r
where m.staff_ssn=s.ssn and  m.staff_ssn=b.manager_staff_ssn and b.ID=r.Branch_id
group by b.ID
having r.Rate > (select avg(Rate) from rate);

/*retrieve report of the patient has id=1014 Q13*/
select r.id as report_id, p.ID ,  p.P_name , p.sex , r.R_date as receiving_date ,m.T_price, r.doctor_name ,
 t.test_T_code ,t.actual_value ,t.status,m.T_name
from patient p , report r , t_result t , test m
where p.ID=r.Patient_ID and r.result_ID=t.ID and t.test_T_code=m.T_code and p.ID=1014
group by r.id having status in('normal');
/////////////////////////////////////////////////////////////////////////////////////////////////
/*kamel*/
/* retrive patient name and branch id and visit where date between '2022-04-14' and '2022-11-05' Q14 */
use mydb;
select p_name as patient_name ,v.type, Branch_id,date as visit_date
 from patient p , visit v 
 where 
 date between '2022-04-14' and '2022-11-05'
 and p.ID = v.patient_ID;
 
 /* retrive patient name and collecting date and sample type = 'Urine Samples'  Q15*/
use mydb;
select P_name as patient_name,collecting_date,S_type as sample_type
from patient p,sample s
where
p.ID=S.patient_ID AND
S_type ='Urine Samples';

/* retrive test result id and releaseing date, test name and category where status is abnormal Q16 */
use mydb;
select  ID as t_result_id , releaseing_date , status , T_name , category
from test , t_result 
where T_code = test_T_code and 
status in('abnormal');

/*retrieve most expensive test from each category Q17*/
select T_name, max(T_price) as max_price , category
from test 
group by category 
order by 2 asc ;

/* retrive all information from staff where salary >= 5000 Q18 */
use mydb;
 select * from staff
  where salary >= 5000 ;
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*mixed*/
/* retrive test name and min value and max value for test where category = blood test Q19 */
 use mydb;
 select T_name as test_name , min as min_value , max as max_value from test
 where category like '%blood test%';
 
 /* retrive secratary name and no of language and secratary phone  Q20 */
use mydb;
SELECT s_name as secratary_name ,  no_of_lang , S_phone as secratary_phone
FROM staff s , sceratary l 
where s.ssn= l.staff_ssn ;

/*retrieve all patient details that name have o second char Q21*/
select * from patient 
where P_name like '_o%';
  
/*retrieve number of reports that release at month Abril Q22*/
Select count(id) as number_of_reports
From report
Where R_date like '%__-04%';

/*retrieve doctor_ ssn and number of samples the doctor take where collecting date between '2022-03-23' and '2022-08-27' Q23*/
select d.staff_ssn , count(ID) as no_of_sample from doctor d , staff s , sample e
where s.ssn=d.staff_ssn and d.staff_ssn = e.Doctor_staff_ssn
 and e.collecting_date between '2022-03-23' and '2022-08-27' 
group by d.staff_ssn;