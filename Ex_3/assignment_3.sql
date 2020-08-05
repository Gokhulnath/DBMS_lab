Rem:Creating the predefined table
@ C:\Users\1051\Desktop\DML2\air_cre.sql
@ C:\Users\1051\Desktop\DML2\air_pop.sql

Rem:description of all the tables
Rem: Aircraft table
desc aircraft;
Rem: Employee table
desc employee;
Rem: Certified table
desc certified;
Rem: Routes table
desc routes;
Rem: Flights table
desc flights;
Rem: Fl_schedule table
desc fl_schedule;


Rem:1. Display the flight number,departure date and time of a flight, its route details and aircraft name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM.

select flightno, departs, (atime-dtime) as Time_flight, routeid, orig_airport, dest_airport, distance, aname
from (((flights f
left outer join aircraft a on f.aid=a.aid)
left outer join routes on f.rid=routeid)
left outer join fl_schedule on f.flightno=flno)
where f.aid in(select a.aid from aircraft a where a.aname in ('Schweizer 2-33','Piper PA-46 Meridian'))
and (dtime between 2000 and 2100);


Rem:2. For all the routes, display the flight number, origin and destination airport, if a flight is assigned for that route.

select routeid, flightno, orig_airport, dest_airport
from routes r
left outer join flights f on r.routeid=f.rid;


Rem:3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the average salary of all pilots certified for this aircraft.

select aname, avg(salary) as avgsalary
from ((certified c
left outer join aircraft a on c.aid=a.aid)
left outer join employee e on c.eid=e.eid)
where cruisingrange>=5000
group by aname;


Rem:4. Show the employee details such as id, name and salary who are not pilots and whose salary is more than the average salary of pilots.

select eid, ename, salary
from employee
where eid not in(select e.eid from employee e inner join certified c on e.eid=c.eid) and
(salary>(select avg(salary) from employee e inner join certified c on e.eid=c.eid));


Rem:5. Find the id and name of pilots who were certified to operate some aircrafts but at least one of that aircraft is not scheduled from any routes.

select e.eid,e.ename from employee e
inner join certified c on c.eid=e.eid
left join flights f on f.aid=c.aid
where f.rid is null
group by (e.eid,e.ename);


Rem:6. Display the origin and destination of the flights having at least three departures with maximum distance covered.


REM:7. Display name and salary of pilot whose salary is more than the average salary of any pilots for each route other than flights originating from Madison airport.

select distinct(e.ename),e.salary
from employee e,certified c,routes r,flights f
where e.eid=c.eid and r.routeID=f.rid and f.aid=c.aid and r.orig_airport!='Madison' and e.salary>
(select avg(e1.salary) from employee e1,certified c1,routes r1,flights f1
where e1.eid=c1.eid and r1.routeID=f1.rID
and f1.aid=c1.aid and r1.routeid=r.routeid);

Rem:8.Display the flight number, aircraft type, source and destination airport of the aircraft having maximum number of flights to Honolulu.

select f.flightNo,a.type,r.orig_airport,r.dest_airport
from flights f,aircraft a,routes r
where f.rID=r.routeID and a.aid=f.aid
and r.dest_airport='Honolulu'
and a.aid=
(select a3.aid from flights f3,aircraft a3,routes r3
where f3.rID=r3.routeID and a3.aid=f3.aid and r3.dest_airport='Honolulu' group by a3.aid
having count(*)=
(select max(c) as m from (select count(*) as c from flights f1,aircraft a1,routes r1
where f1.rID=r1.routeID and a1.aid=f1.aid and r1.dest_airport='Honolulu' group by a1.aid)));

Rem:9.Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.


Rem:10.Name the employee(s) who is earning the maximum salary among the airport havingmaximum number of departures.

select e3.ename,e3.salary from employee e3 where e3.salary=
(select max(sal) from (select distinct e2.ename,e2.salary as sal
from employee e2,flights f2,routes r2,aircraft a2,certified c2
where r2.routeId=f2.rid and f2.aid=a2.aid and e2.eid=c2.eid and c2.aid=a2.aid and
r2.orig_airport=
(select r1.orig_airport from routes r1,flights f1
where r1.routeId=f1.rid group by r1.orig_airport having count(*)=
(select max(c) as m from (select count(*) as c from routes r,flights f
where r.routeid=f.rid group by r.orig_airport)))));

Rem: 11.Display the departure chart as follows: flight number, departure(date,airport,time), destination airport, arrival time, aircraft name for the flights from New York airport during 15 to 19th April 2005. Make sure that the route contains at least two flights in the above specified condition.

select f1.flightNo,fl1.departs,r1.orig_airport,r1.dest_airport,fl1.dtime,fl1.atime,a1.aname
from aircraft a1,routes r1,flights f1,fl_schedule fl1
where fl1.flno=f1.flightno and f1.rID=r1.routeId and f1.aid=a1.aid and r1.orig_airport='New York'
and fl1.departs between '15-apr-05' and '19-apr-05' and exists(
(select r.routeId from aircraft a,routes r,flights f,fl_schedule fl
where fl.flno=f.flightno and f.rID=r.routeId and f.aid=a.aid and r.orig_airport='New York'
and fl.departs between '15-apr-05' and '19-apr-05' and r1.routeId=r.routeId
group by (r.routeId) having count(*)>=2));

Rem:12. A customer wants to travel from Madison to New York with no more than two changes of flight. List the flight numbers from Madison if the customer wants to arrive in New York by 6.50 p.m.

select distinct f.flightNo from flights f,routes r,fl_schedule fs where f.rid=r.routeID and fs.flno=f.flightNo
and r.orig_airport='Madison' and r.dest_airport='New York' and fs.atime<=1850
union
select distinct f1.flightNo from flights f1,routes r1,fl_schedule fs1,flights f11,routes r11
where f1.rid=r1.routeID and fs1.flno=f11.flightNo and f11.rid=r11.routeID
and r1.orig_airport='Madison' and r11.dest_airport='New York' and r1.dest_airport=r11.orig_airport and fs1.atime<=1850
union
select distinct f2.flightNo from flights f2,routes r2,fl_schedule fs2,flights f21,routes r21,flights f22,routes r22
where f2.rid=r2.routeID and fs2.flno=f22.flightNo and f21.rid=r21.routeID  and f22.rid=r22.routeID
and r2.orig_airport='Madison' and r22.dest_airport='New York' and r2.dest_airport=r21.orig_airport
and r21.dest_airport=r22.orig_airport and fs2.atime<=1850;

Rem: 13. Display the id and name of employee(s) who are not pilots.

select e1.eid,e1.ename from employee e1
where e1.eid in
(select e.eid from employee e
minus
select c.eid from certified c);

Rem: 14. Display the id and name of employee(s) who pilots the aircraft from Los Angeles and Detroit airport.

select distinct e.eid,e.ename from employee e,certified c,routes r,flights f,aircraft a
where e.eid=c.eid and r.routeID=f.rID and f.aid=a.aid and c.aid=a.aid
and r.orig_airport='Los Angeles'
intersect
select distinct e.eid,e.ename from employee e,certified c,routes r,flights f,aircraft a
where e.eid=c.eid and r.routeID=f.rID and f.aid=a.aid and c.aid=a.aid
and r.orig_airport='Detroit';