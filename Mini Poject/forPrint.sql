SQL> connect system/gokhul;
Connected.

SQL> create user medicalshop22 identified by gokhul;

User created.

SQL> grant connect, resource to medicalshop22;

Grant succeeded.

SQL> connect medicalshop22/gokhul;
Connected.
SQL> @ C:\Users\gokhu\Desktop\pharmacy.sql
SQL> 
SQL> 
SQL> 
SQL> drop table pharmacy;
drop table pharmacy
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table doctor;
drop table doctor
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table customer;
drop table customer
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table manufacturer;
drop table manufacturer
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table mediquipment;
drop table mediquipment
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table supplier;
drop table supplier
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table employee;
drop table employee
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table hospital;
drop table hospital
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table bill;
drop table bill
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table works;
drop table works
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table contract;
drop table contract
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> drop table prescribe;
drop table prescribe
           *
ERROR at line 1:
ORA-00942: table or view does not exist 


SQL> 
SQL> create table pharmacy
  2  (
  3  phid integer primary key,
  4  name varchar2(20),
  5  city varchar2(20),
  6  fax varchar2(20),
  7  phone number(10));

Table created.

SQL> 
SQL> create table doctor
  2  (
  3  did number(2) primary key,
  4  dname varchar2(20),
  5  speciality varchar2(20),
  6  age number(2) not null,
  7  mobile integer,
  8  gender varchar2(6));

Table created.

SQL> 
SQL> create table customer
  2  (
  3  pid number(3) primary key,
  4  name varchar2(20),
  5  sex varchar2(6),
  6  city varchar2(20),
  7  phone integer,
  8  age number(2),
  9  did references doctor(did) on delete set null);

Table created.

SQL> 
SQL> create table manufacturer
  2  (
  3  cid number(4) primary key,
  4  name varchar2(20),
  5  email varchar2(20),
  6  mobile integer,
  7  city varchar2(20),
  8  pharid references pharmacy(phid) on delete set null);

Table created.

SQL> 
SQL> create table mediquipment
  2  (
  3  code number(5) primary key,
  4  Trade_name varchar2(20),
  5  Product_Type varchar2(20),
  6  Mfg_date date,
  7  Exp_date date,
  8  price number(10,2),
  9  cid references manufacturer(cid) on delete set null);

Table created.

SQL> 
SQL> create table supplier
  2  (
  3  name varchar2(20),
  4  city varchar2(20),
  5  mobile integer primary key,
  6  email varchar2(20),
  7  cid references manufacturer(cid) on delete set null,
  8  pharid references pharmacy(phid) on delete set null);

Table created.

SQL> 
SQL> create table employee
  2  (
  3  name varchar2(20),
  4  city varchar2(20),
  5  doj date,
  6  mobile integer primary key,
  7  salary number(10),
  8  age number(2),
  9  sex varchar2(1),
 10  pharid references pharmacy(phid) on delete set null);

Table created.

SQL> 
SQL> create table hospital
  2  (
  3  hid number(2) primary key,
  4  name varchar2(20),
  5  email varchar2(40),
  6  phone integer,
  7  city varchar2(20),
  8  pharid references pharmacy(phid) on delete set null);

Table created.

SQL> 
SQL> create table bill
  2  (
  3  bid number(3) primary key,
  4  DOB date,
  5  age number(3),
  6  pname varchar2(20),
  7  mobile integer,
  8  city varchar2(20),
  9  product varchar2(20),
 10  amount number(10,2),
 11  pharid references pharmacy(phid) on delete set null);

Table created.

SQL> 
SQL> create table works
  2  (
  3  pharid references pharmacy(phid) on delete cascade,
  4  start_date date,
  5  end_date date,
  6  primary key(pharid));

Table created.

SQL> 
SQL> create table contract
  2  (
  3  pharid references pharmacy(phid) on delete cascade,
  4  cid references manufacturer(cid) on delete cascade,
  5  start_date date,
  6  end_date date,
  7  primary key(pharid,cid));

Table created.

SQL> 
SQL> create table prescribe
  2  (
  3  DOP date,
  4  medicine varchar2(20),
  5  did references doctor(did) on delete cascade,
  6  pid references customer(pid) on delete cascade,
  7  primary key(pid,did));

Table created.

SQL> 
SQL> 
SQL> 
SQL> insert into pharmacy values(1,'abbott','bangalore',212-9765433,9001002003);

1 row created.

SQL> insert into pharmacy values(2,'allergan','mumbai',222-9838212,9001002004);

1 row created.

SQL> insert into pharmacy values(3,'janssen','bangalore',233-9812113,9001002001);

1 row created.

SQL> insert into pharmacy values(4,'solvay','delhi',235-9862263,9010126387);

1 row created.

SQL> insert into pharmacy values(5,'roche','chennai',248-9818181,9661268268);

1 row created.

SQL> insert into pharmacy values(6,'schwarz','bangalore',253-9866547,9662312312);

1 row created.

SQL> insert into pharmacy values(7,'busk','bangalore',258-9001536,9234234110);

1 row created.

SQL> insert into pharmacy values(8,'novartis','mysore',287-9112543,9235231510);

1 row created.

SQL> insert into pharmacy values(9,'boots','chennai',284-9112541,9878685412);

1 row created.

SQL> 
SQL> insert into doctor values(10,'DPGupta','cardiologists',45,9831312512,'m');

1 row created.

SQL> insert into doctor values(11,'AKSahay','diabetologists',50,9826263264,'m');

1 row created.

SQL> insert into doctor values(12,'LalaAshok','gynaecologists',30,9006001002,'m');

1 row created.

SQL> insert into doctor values(13,'CNMishra','hygienists',32,9875400500,'m');

1 row created.

SQL> insert into doctor values(14,'MKMishra','leprologists',28,9861621312,'m');

1 row created.

SQL> insert into doctor values(15,'vineeta','neurologists',28,9811254112,'f');

1 row created.

SQL> insert into doctor values(16,'Ragini Khanna','neurologists',24,9831054112,'f');

1 row created.

SQL> insert into doctor values(17,'Ajay Solanki','pathologists',32,9811211311,'m');

1 row created.

SQL> insert into doctor values(18,'MD Arif','psychiatrists',31,9006112534,'m');

1 row created.

SQL> insert into doctor values(19,'Salma Ahmad','sexologists',32,9110110221,'f');

1 row created.

SQL> 
SQL> 
SQL> insert into customer values(100,'anshu','m','delhi',9002001004,21,10);

1 row created.

SQL> insert into customer values(101,'iqbal','m','rampur',9821330400,8,11);

1 row created.

SQL> insert into customer values(102,'priya','f','chennai',9840050022,7,12);

1 row created.

SQL> insert into customer values(103,'kaushik','m','patna',9840050023,14,13);

1 row created.

SQL> insert into customer values(104,'nitu','f','bangalore',9840050024,13,14);

1 row created.

SQL> insert into customer values(105,'reshma','f','bangalore',9840050028,22,14);

1 row created.

SQL> insert into customer values(106,'rekha','f','illinois',9840050026,35,15);

1 row created.

SQL> insert into customer values(107,'alisha','f','pune',9840050027,50,16);

1 row created.

SQL> insert into customer values(108,'sonia','f','pehlgaon',9840050021,57,14);

1 row created.

SQL> insert into customer values(109,'vishak sen','m','arwal',9821246112,41,17);

1 row created.

SQL> 
SQL> insert into manufacturer values(1000,'hoivo','hoivo1@gmail',9112113114,'bangalore',1);

1 row created.

SQL> insert into manufacturer values(1001,'medicyl','med2@gmail',9212123134,'mysore',2);

1 row created.

SQL> insert into manufacturer values(1002,'vitade','vit3@gmail',9812121368,'chennai',2);

1 row created.

SQL> insert into manufacturer values(1003,'annuva','ann4@gmail',9001002115,'delhi',3);

1 row created.

SQL> insert into manufacturer values(1004,'mandavus','man5@gmail',9122113114,'hyderabad',1);

1 row created.

SQL> insert into manufacturer values(1005,'inovine','ino5@gmail',9881828112,'bangalore',5);

1 row created.

SQL> insert into manufacturer values(1006,'naturals','nat6@gmail',9111111111,'delhi',6);

1 row created.

SQL> insert into manufacturer values(1007,'versure','ver7@gmail',9865112111,'delhi',7);

1 row created.

SQL> insert into manufacturer values(1008,'bioleap','bio8@gmail',9999511012,'mumbai',8);

1 row created.

SQL> insert into manufacturer values(1009,'borax','bor2@gmail',9006012018,'pune',2);

1 row created.

SQL> 
SQL> insert into mediquipment values(12122,'paracetamol','capsule','06-aug-16','20-aug-20',38,1001);

1 row created.

SQL> insert into mediquipment values(12100,'quinapril','tablets','07-aug-16','19-aug-21',56,1003);

1 row created.

SQL> insert into mediquipment values(12115,'zafirlukast','tablets','08-sep-16','17-sep-19',100,1004);

1 row created.

SQL> insert into mediquipment values(12116,'crocin','syrup','09-may-16','16-may-18',210,1005);

1 row created.

SQL> insert into mediquipment values(12117,'injection','operation','18-jun-16','23-apr-23',112,1006);

1 row created.

SQL> insert into mediquipment values(12109,'bandage','cloth','19-sep-16','18-aug-19',112.07,1006);

1 row created.

SQL> insert into mediquipment values(12121,'oxygen mask','operation','25-jul-16','28-dec-17',212.12,1007);

1 row created.

SQL> insert into mediquipment values(12120,'dalacin T','gel','28-oct-16','21-jan-21',303.08,1008);

1 row created.

SQL> insert into mediquipment values(12112,'paramax','tablets','29-apr-16','20-feb-20',308.16,1009);

1 row created.

SQL> insert into mediquipment values(12104,'vinyl','syrup','13-sep-16','13-mar-18',113.18,1003);

1 row created.

SQL> 
SQL> insert into employee values('arjun','bangalore','02-aug-14',9110220330,15000,23,'m',1);

1 row created.

SQL> insert into employee values('ankita','mumbai','03-mar-13',9112221312,20000,24,'f',2);

1 row created.

SQL> insert into employee values('ganesh','chennai','03-apr-14',9112222331,24000,25,'m',3);

1 row created.

SQL> insert into employee values('mayur','delhi','02-may-14',9113114118,25000,26,'m',4);

1 row created.

SQL> insert into employee values('mayank','bangalore','05-jun-15',9116100200,26000,25,'m',5);

1 row created.

SQL> insert into employee values('satyam','hyderabad','06-dec-16',9081812812,27000,26,'m',6);

1 row created.

SQL> insert into employee values('abhishek','surat','07-sep-15',9081813813,18000,27,'m',7);

1 row created.

SQL> insert into employee values('daniel','jaipur','08-jul-14',9112134168,19000,21,'m',8);

1 row created.

SQL> insert into employee values('ron','dispur','09-sep-13',9081812113,25000,28,'m',9);

1 row created.

SQL> 
SQL> insert into supplier values('priyank','bangalore',9812131212,'pri1@gmail',1001,1);

1 row created.

SQL> insert into supplier values('trishal','mumbai',9811210000,'tri2@gmail',1002,2);

1 row created.

SQL> insert into supplier values('raj','pune',9800100211,'raj3@gmail',1003,3);

1 row created.

SQL> insert into supplier values('aryan','chennai',9761610610,'ary4@gmail',1004,4);

1 row created.

SQL> insert into supplier values('vishak','hyderabad',9661252213,'vis5@gmail',1005,5);

1 row created.

SQL> insert into supplier values('shubham','surat',9012101131,'shu6@gmail',1006,6);

1 row created.

SQL> insert into supplier values('rohit','ahmedabad',9002112117,'roh7@gmail',1007,7);

1 row created.

SQL> insert into supplier values('rishabh','bhopal',9811011021,'ris8@gmail',1008,8);

1 row created.

SQL> insert into supplier values('anshuman','jaipur',9811300200,'ans4@gmail',1009,9);

1 row created.

SQL> 
SQL> insert into hospital values(50,'krishna','kri6@gmail',9771700700,'delhi',1);

1 row created.

SQL> insert into hospital values(51,'jayadeva','jay5@gmail',9772800800,'bangalore',2);

1 row created.

SQL> insert into hospital values(52,'apollo','apo7@gmail',9812900912,'mysore',3);

1 row created.

SQL> insert into hospital values(53,'paras','par8@gmail',9310315315,'delhi',3);

1 row created.

SQL> insert into hospital values(54,'getwello','get9@gmail',9410055000,'chennai',4);

1 row created.

SQL> insert into hospital values(55,'arunodaya','aru8@gmail',9610066100,'mumbai',5);

1 row created.

SQL> insert into hospital values(56,'aastha','aas1@gmail',9780078001,'pune',6);

1 row created.

SQL> insert into hospital values(57,'devagiri','dev7@gmail',9871001002,'surat',7);

1 row created.

SQL> insert into hospital values(58,'shanti','sha8@gmail',9860010081,'bhopal',8);

1 row created.

SQL> insert into hospital values(59,'lakshmi','lak1@gmail',9861001012,'kolkata',9);

1 row created.

SQL> 
SQL> insert into bill values(300,'01-sep-17',20,'anshu',9854575613,'bangalore','quinapril',56,1);

1 row created.

SQL> insert into bill values(301,'02-sep-17',25,'iqbal',8755425417,'bangalore','oxygen mask',212.12,1);

1 row created.

SQL> insert into bill values(302,'03-aug-17',35,'priya',7611413161,'mumbai','crocin',110,1);

1 row created.

SQL> insert into bill values(303,'01-jan-17',45,'kaushik',9153484335,'delhi','injection',112,1);

1 row created.

SQL> insert into bill values(304,'02-feb-17',65,'nitu',7535413431,'chennai','dalacin T',303.08,1);

1 row created.

SQL> insert into bill values(305,'08-feb-17',75,'reshma',8351354134,'mumbai','crocin',110,1);

1 row created.

SQL> insert into bill values(306,'09-feb-17',85,'rekha',9354533131,'mysore','bandage',112.07,1);

1 row created.

SQL> insert into bill values(307,'07-mar-17',95,'alisha',8453431211,'delhi','paramax',308.16,1);

1 row created.

SQL> insert into bill values(308,'08-apr-17',44,'sonia',7153131323,'mysore','vinyl',113.18,1);

1 row created.

SQL> insert into bill values(309,'08-apr-17',26,'sonia',9534351743,'delhi','crocin',110,1);

1 row created.

SQL> 
SQL> insert into works values(1,'01-aug-16','19-mar-19');

1 row created.

SQL> insert into works values(2,'02-aug-16','20-mar-19');

1 row created.

SQL> insert into works values(3,'03-aug-16','21-mar-19');

1 row created.

SQL> insert into works values(4,'04-may-16','22-mar-19');

1 row created.

SQL> insert into works values(5,'05-may-16','23-mar-19');

1 row created.

SQL> insert into works values(6,'06-jun-16','26-oct-19');

1 row created.

SQL> insert into works values(7,'21-jul-16','28-oct-19');

1 row created.

SQL> insert into works values(8,'21-sep-16','29-oct-19');

1 row created.

SQL> insert into works values(9,'22-sep-16','23-mar-19');

1 row created.

SQL> 
SQL> insert into contract values(1,1000,'01-jan-15','11-sep-19');

1 row created.

SQL> insert into contract values(2,1001,'01-jan-15','21-sep-19');

1 row created.

SQL> insert into contract values(3,1002,'02-jan-15','01-oct-19');

1 row created.

SQL> insert into contract values(4,1003,'03-mar-15','02-oct-19');

1 row created.

SQL> insert into contract values(5,1004,'03-mar-15','03-oct-19');

1 row created.

SQL> insert into contract values(6,1005,'04-apr-15','04-dec-19');

1 row created.

SQL> insert into contract values(7,1006,'05-apr-15','08-dec-20');

1 row created.

SQL> insert into contract values(8,1004,'06-apr-15','09-nov-20');

1 row created.

SQL> insert into contract values(9,1002,'10-jun-15','08-nov-19');

1 row created.

SQL> 
SQL> insert into prescribe values('01-sep-17','paracetamol',10,101);

1 row created.

SQL> insert into prescribe values('02-sep-17','crocin',11,102);

1 row created.

SQL> insert into prescribe values('03-sep-17','crocin',12,103);

1 row created.

SQL> insert into prescribe values('01-sep-17','bandage',13,105);

1 row created.

SQL> insert into prescribe values('02-sep-17','oxygen mask',14,106);

1 row created.

SQL> insert into prescribe values('08-sep-17','vinyl',15,107);

1 row created.

SQL> insert into prescribe values('07-sep-17','paramax',16,108);

1 row created.

SQL> insert into prescribe values('21-sep-17','dalacin T',17,109);

1 row created.

SQL> insert into prescribe values('22-sep-17','quinapril',18,104);

1 row created.

SQL> 
SQL> 
SQL> select name,salary
  2  	from employee
  3  	group by name,salary
  4  	having salary > (select avg(salary)
  5  			 from employee
  6  			 where city='bangalore')
  7  	order by 2 asc;

NAME                     SALARY                                                                                                                       
-------------------- ----------                                                                                                                       
ganesh                    24000                                                                                                                       
mayur                     25000                                                                                                                       
ron                       25000                                                                                                                       
mayank                    26000                                                                                                                       
satyam                    27000                                                                                                                       

SQL> 
SQL> update mediquipment set price=300
  2  	where cid in (select cid
  3  		      from manufacturer
  4  		      where city='pune');

1 row updated.

SQL> 
SQL> select p.name,pharid,count(distinct cid) as count1
  2  	from pharmacy p, manufacturer
  3  	where phid = pharid
  4  	group by p.name, pharid
  5  	having count(*)>1;

NAME                     PHARID     COUNT1                                                                                                            
-------------------- ---------- ----------                                                                                                            
allergan                      2          3                                                                                                            
abbott                        1          2                                                                                                            

SQL> 
SQL> select p.name, e.name, e.salary
  2  	from employee e, pharmacy p
  3  	where phid=pharid
  4  	minus
  5  	select p.name,e.name, e.salary
  6  	from employee e, pharmacy p
  7  	where e.sex='f';

NAME                 NAME                     SALARY                                                                                                  
-------------------- -------------------- ----------                                                                                                  
abbott               arjun                     15000                                                                                                  
boots                ron                       25000                                                                                                  
busk                 abhishek                  18000                                                                                                  
janssen              ganesh                    24000                                                                                                  
novartis             daniel                    19000                                                                                                  
roche                mayank                    26000                                                                                                  
schwarz              satyam                    27000                                                                                                  
solvay               mayur                     25000                                                                                                  

8 rows selected.

SQL> 
SQL> 
SQL> create procedure update_medi as
  2    begin
  3    update mediquipment set price = price+100 where trade_name='paramax';
  4    end;
  5    /

Procedure created.

SQL> 
SQL> 
SQL> create trigger price_check
  2  	before insert or update on mediquipment
  3  	for each row
  4  	when (new.price>500)
  5  	begin
  6  	:new.price:= 499;
  7  	end;
  8  	/

Trigger created.

SQL> 
SQL> create trigger age_check1
  2  	before insert or update on doctor
  3  	for each row
  4  	when (new.age>80)
  5  	begin
  6  	dbms_output.put_line('DOCTOR AGE CANNOT BE MORE THAN 80!!!');
  7  	end;
  8  	/

Trigger created.

SQL> 
SQL> 
SQL> 
SQL> commit;

Commit complete.

SQL> spool off;
