set linesize 150;
set echo on;
Rem:Dropping the table if it exist, if doesn't it throws  error.
drop table sungby;
drop table artist;
drop table song;
drop table album;
drop table studio;
drop table musician;
Rem:Creating the musician table with musician id as primary key.
create table musician (m_id varchar2(5) constraint musician_pk primary key,
                         m_name varchar2(20),
                         birthplace varchar2(20));
insert into musician values ('M0001','dsp','Madurai');
insert into musician values ('M0002','hip hop tamizha','coimbatore');
insert into musician values ('M0003','Brodha V','chennai');
select * from musician;
Rem:Creating the studio table with stuio name as primary key.
create table studio (stu_name varchar2(20) constraint studio_pk primary key,
                       stu_address varchar2(20),
                       stu_phone number(10));
insert into studio values ('A studio','chennai',1111111111);
insert into studio values ('B studio','coimbatore',2222222222);
insert into studio values ('c studio','Madurai',3333333333);
select * from studio;  
Rem:Creating the album table with album id as primary key, release year check which must be greater than 1945, No.of tracks as not null, genre as                     
create table album (al_id varchar2(5) constraint album_pk primary key,
                      al_name varchar2(20),
                      release_year number(4) constraint year_check check(release_year>1945),
                      no_of_tracks number(3) constraint nt_nn not null,
                      genre varchar2(3) constraint genre_check check (genre in ('CAR','DIV','MOV','POP')),
                      m_id varchar2(5) constraint album_fk references musician(m_id),
                      studio varchar2(20) constraint studio_fk references studio(stu_name));
insert into album values ('A0001','al1',2019,4,'DIV','M0001','A studio');
insert into album values ('A0002','al2',2010,3,'POP','M0002','B studio');
insert into album values ('A0003','al3',2000,4,'MOV','M0003','c studio');
select * from album;                                                                                
insert into album values ('A0003','al4',2000,4,'MOV','M0004','c studio');
insert into album values ('A0004','al4',1900,4,'MOV','M0004','c studio');
insert into album values ('A0004','al4',1900,null,'MOV','M0004','c studio');
insert into album values ('A0004','al4',1900,4,'ABC','M0004','c studio');
insert into album values ('A0003','al4',2000,4,'MOV','M0010','c studio');
insert into album values ('A0004','al4',2000,4,'MOV','M0004','Z studio');
create table song (al_id varchar2(5) constraint song_fk references album(al_id),
                     track_no number(3),
                     sng_name varchar2(20),
                     length number(2),
                     sng_gnr varchar2(3) constraint genre_check1 check (sng_gnr in ('PHI','REL','LOV','DEV','PAT')),
                     constraint sngpk primary key (al_id,track_no),
                     constraint ln_chk check((length>7 and sng_gnr='PAT') or sng_gnr!='PAT'));
insert into song values ('A0001',1,'FIRST',5,'DEV');
insert into song values ('A0002',1,'SECOND',5,'LOV');
insert into song values ('A0003',1,'THIRD',5,'REL');
insert into song values ('A0002',3,'FOURTH',10,'PAT');
select * from song;
insert into song values ('A0001',1,'FI',5,'DEV');
insert into song values ('A0002',2,'check',5,'ABC');
insert into song values ('A0010',2,'check',5,'DEV');
insert into song values ('A0002',2,'check',5,'PAT');
create table artist (art_id varchar2(5) constraint artist_pk primary key,
                       art_name varchar2(20) constraint name_nn not null);
insert into artist values ('AT001','AAA');
insert into artist values ('AT002','BBB');
insert into artist values ('AT003','CCC');
select * from artist;
insert into artist values ('AT001','AAA');
insert into artist values ('AT004',null);
create table sungby (al_id varchar2(5),
                       art_id varchar2(5) constraint fk1 references artist(art_id),
                       track_no number(3),
                       recd_date date,
                       constraint fk2 foreign key (al_id,track_no) references song(al_id,track_no),
                       constraint pk primary key (al_id,track_no,art_id));
insert into sungby values ('A0001','AT001',1,'10-JAN-2000');
insert into sungby values ('A0002','AT002',1,'10-MAR-2000');
insert into sungby values ('A0002','AT003',1,'10-JAN-2000');
insert into sungby values ('A0001','AT002',1,'10-DEC-2000');
insert into sungby values ('A0001','AT002',1,'10-DEC-2000');
insert into sungby values ('A0001','AT007',1,'10-APR-2000');