--1. Create a view Schedule_15 that display the flight number, route, airport(origin, destination)
--departure (date, time), arrival (date, time) of a flight on 15 apr 2005. Label the view column
--as flight, route, from_airport, to_airport, ddate, dtime, adate, atime respectively.

CREATE OR REPLACE VIEW Schedule_15 as
select fl.flno as flight,r.routeid as route,r.orig_airport as from_airport,r.dest_airport as to_airport,fl.departs as ddate,
fl.dtime as dtime,fl.arrives as adate,fl.atime as atime from Fl_schedule fl,Flights f,Routes r
where fl.flno = f.flightno AND f.rid = r.routeid AND fl.departs = '15-apr-2005';

REM : not inserting
insert into Schedule_15 values('CX-111', 'LNY107', 'Los Angeles', 'New York','21-APR-2020','1234','22-APR-2020','2345');

REM : ITS updatable it affects base table
update Schedule_15 set ddate = '20-apr-2005' 
	where flight = 'BA-178'; 

--its deletable and affects base table;
delete from Schedule_15 where flight = 'RP-5018';
select * from Fl_schedule where flno = 'RP-5018';

--2. Define a view Airtype that display the number of aircrafts for each of its type. Label the
--column as craft_type, total.

CREATE VIEW Airtype as
select type as craft_type, count(aid) as total from aircraft group by type;

--Not insertable

insert into Airtype values('Abdul',5);

REM : not updatable

update Airtype set craft_type = 'ab' where craft_type = 'Schweizer';

REM : not deletable

delete from Airtype where craft_type = 'Schweizer';

--3. Create a view Losangeles_Route that display the information about Los Angeles route.
--Ensure that the view always contain/allows only information about the Los Angeles route.

CREATE VIEW Losangeles_Route as
select * from Routes where orig_airport = 'Los Angeles';

--insertion affects base table

insert into Losangeles_Route values('AB123','Los Angeles','Chennai','3000');
select * from Routes where routeid = 'AB123';

--updatable and affects base table

update Losangeles_Route set dest_airport ='Chennai' where dest_airport = 'New York';
select * from Losangeles_route where dest_airport = 'Chennai'
select * from Routes where dest_airport = 'Chennai';

--Deleting
delete from Losangeles_Route WHERE dest_airport = 'Chennai';

--4. Create a view named Losangeles_Flight on Schedule_15 (as defined in 1) that display flight,
--departure (date, time), arrival (date, time) of flight(s) from Los Angeles.

CREATE VIEW Losangeles_Flight as
select * from Schedule_15 where (from_airport = 'Los Angeles');

--Not insertable

insert into Losangeles_Flight values('CX-185','LNY107','Chennai','Trichy','23-APR-05','1234','24-apr-05','2345');

--Updatable and affects base table

update Losangeles_Flight set dtime = 9999 where to_airport = 'Tokyo';
	select * from Losangeles_Flight where dtime = 9999;
	select * from Schedule_15 where dtime = 9999;

--Deletable and affects base table
delete from Losangeles_Flight where dtime = 9999;
	select * from Losangeles_Flight where dtime = 9999;
	select * from Schedule_15 where dtime = 9999;
