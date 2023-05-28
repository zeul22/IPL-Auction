--Creation of tables

create table balls(
	id int,
	inning int,
	over int,
	ball int,
	batsman varchar,
	non_striker varchar,
	bowler varchar,
	batsman_runs int,
	extra_runs int,
	total_runs int,
	is_wicket int,
	dismissal_kind varchar,
	player_dismissed varchar,
	fielder varchar,
	extras_type varchar,
	batting_team varchar,
	bowling_team varchar
);


create table matches(
	id int,
	city varchar,
	date date,
	player_of_match varchar,
	venue varchar,
	neutral_venue int,
	team1 varchar,
	team2 varchar,
	toss_winner varchar,
	toss_decision varchar,
	winner varchar,
	result varchar,
	result_margin int,
	eliminator varchar,
	method varchar,
	umpire1 varchar,
	umpire2 varchar
);

-- Importing the data

Copy balls from 'D:\Internshala\SQL\IPL Dataset\IPL Dataset\IPL_Ball.csv' DELIMITER ',' CSV HEADER;
select * from balls;


Copy matches from 'D:\Internshala\SQL\IPL Dataset\IPL Dataset\IPL_matches.csv' DELIMITER ',' CSV HEADER;
select * from matches;


---------------------Bidding on Batsman

--Players who have faced atleast 500 balls
select batsman, sum(ball) as total_balls ,sum(batsman_runs) as Total_runs,(sum(batsman_runs)*100/sum(ball)) as Strike_Rate
from balls where extras_type !='wides' group by batsman having sum(ball)>=500 ;


--Top 10 Players who faced atleast 500 balls and high S.R 
select batsman, sum(ball) as total_balls ,sum(batsman_runs) as Total_runs, (sum(batsman_runs)*100/sum(ball)) as Strike_Rate from balls 
where extras_type !='wides'
group by batsman having sum(ball)>=500 order by 4 desc limit 10;

--Total Matches played per year
select Extract(Year from date), count(*) as Total_Matches from matches group by Extract (Year from date) order by 1;

--Total Matches played in cities per year
select Extract(Year from date), city, count(city) as Total_Matches from matches group by Extract (Year from date),city order by 1;

--Balls Played, Total runs of a batsman per match
Select a.batsman, id, sum(a.ball) as balls_played, sum(a.batsman_runs) as Total_runs, (sum(a.batsman_runs)*100/sum(a.ball)) as Strike_rate
from balls as a where extras_type!='wides'  group by 2,1;

--Runs made, balls played, strike rate of a batsman per year
select a.batsman, sum(a.ball) as Total_Balls, sum(a.batsman_runs) as Total_runs, 
(sum(a.batsman_runs)*100/sum(a.ball)) as Strike_Rate, Extract (Year from b.date)
from balls as a left join matches as b
on a.id=b.id
group by 5,1
order by 5;

--Players that have played more than 2 ipls
select c.batsman, count(*) as IPL_Played from (select a.batsman, sum(a.ball) as Total_Balls, sum(a.batsman_runs) as Total_runs, 
(sum(a.batsman_runs)*100/sum(a.ball)) as Strike_Rate, Extract (Year from b.date)
from balls as a left join matches as b
on a.id=b.id
group by 5,1
order by 5) as c group by batsman having count(*)>2;


select * from balls;
select * from matches;

select batsman,
	Case 
		when sum(is_wicket)>0 then sum(batsman_runs)/sum(is_wicket)
		else 0
	end as avgruns
from balls group by batsman ;

--Top 10 players with good averages and have played more than 2 ipl seasons
select x.batsman, x.avgruns, y.IPL_played from (select batsman,
	Case 
		when sum(is_wicket)>0 then sum(batsman_runs)/sum(is_wicket)
		else 0
	end as avgruns
from balls group by batsman ) as x
inner join 
(select c.batsman, count(*) as IPL_Played from (select a.batsman, sum(a.ball) as Total_Balls, sum(a.batsman_runs) as Total_runs, 
(sum(a.batsman_runs)*100/sum(a.ball)) as Strike_Rate, Extract (Year from b.date)
from balls as a left join matches as b
on a.id=b.id
group by 5,1
order by 5) as c group by batsman having count(*)>2) as y
on x.batsman=y.batsman
order by 2 desc limit 10;


select * from balls;

--Total Boundaries hit by a batsman
select batsman, sum(batsman_runs) from balls where extras_type != 'wide' and batsman_runs>3 group by batsman order by 2 desc;

--Top 10 players having the highest boundaries proportion

select a.batsman, b.Total_Runs as Runs, a.Total_Boundaries as Boundaries_Runs, a.Total_Boundaries*100/b.total_Runs as Boundary_Weightage from 
(select batsman, sum(batsman_runs)as Total_Boundaries from balls where extras_type != 'wide' and batsman_runs>3 group by batsman order by 2 desc) as a
inner join
(select batsman, sum(batsman_runs) as Total_Runs from balls where extras_type != 'wide' group by batsman ) as b
on a.batsman=b.batsman
order by 2 desc,4 desc limit 10;


--Players that have played more than 2 ipls
select c.batsman, count(*) as IPL_Played from (select a.batsman, sum(a.ball) as Total_Balls, sum(a.batsman_runs) as Total_runs, 
(sum(a.batsman_runs)*100/sum(a.ball)) as Strike_Rate, Extract (Year from b.date)
from balls as a left join matches as b
on a.id=b.id
group by 5,1
order by 5) as c group by batsman having count(*)>2;

--Top 10 players having the highest boundaries proportion with playing more than 2 ipl matches
select x.batsman, x.Boundary_Weightage, y.IPL_Played from
(select a.batsman, b.Total_Runs as Runs, a.Total_Boundaries as Boundaries_Runs, a.Total_Boundaries*100/b.total_Runs as Boundary_Weightage from 
(select batsman, sum(batsman_runs)as Total_Boundaries from balls where extras_type != 'wide' and batsman_runs>3 group by batsman order by 2 desc) as a
inner join
(select batsman, sum(batsman_runs) as Total_Runs from balls where extras_type != 'wide' group by batsman ) as b
on a.batsman=b.batsman
order by 2 desc,4 desc limit 10) as x
inner join 
(select c.batsman, count(*) as IPL_Played from (select a.batsman, sum(a.ball) as Total_Balls, sum(a.batsman_runs) as Total_runs, 
(sum(a.batsman_runs)*100/sum(a.ball)) as Strike_Rate, Extract (Year from b.date)
from balls as a left join matches as b
on a.id=b.id
group by 5,1
order by 5) as c group by batsman having count(*)>2) as y
on x.batsman=y.batsman
order by 2 desc;



---------------------------Bidding on Bowlers

select * from balls;

--Bowlers who have bowled atleast 500 balls in IPL so far
Select bowler, sum(ball/6) as total_overs from balls group by bowler having sum(ball)>=500;

--Top 10 players having a good economy who have bowled atleast 500 balls in IPL so far
select bowler, sum(total_runs) as Total_Runs_Conceeded , sum(ball/6) as Total_Overs, sum(total_runs)/sum(ball/6) as economy from balls
group by bowler having sum(ball)>=500
order by 4 desc limit 10;

--Top 10 Bowlers with Total wickets and best strike rate who have bowled 500 balls
select bowler, sum(ball) as Total_Balls, sum(is_wicket) as Total_wickets,sum(ball)/sum(is_wicket) as Strike_Rate  
from balls group by bowler having sum(is_wicket)>0 and sum(ball)>500
order by 4 asc limit 10;
 
-------------------------------All Rounders



--Top 10 Bowlers with Total wickets and best strike rate who have bowled 300 balls
select bowler, sum(ball) as Total_Balls, sum(is_wicket) as Total_wickets,sum(ball)/sum(is_wicket) as Strike_Rate  
from balls group by bowler having sum(is_wicket)>0 and sum(ball)>300
order by 4 asc limit 10;

--Top 10 Players who faced atleast 500 balls and high S.R 
select batsman, sum(ball) as total_balls ,sum(batsman_runs) as Total_runs, (sum(batsman_runs)*100/sum(ball)) as Strike_Rate from balls 
where extras_type !='wides'
group by batsman having sum(ball)>=500 order by 4 desc limit 10;



--Players who have faced atleast 500 balls and bowled at least 300 balls
select a.batsman as All_Rounders, a.Strike_rate as Batting_SR, b.Strike_rate as Bowling_SR from (
	select batsman, sum(ball) as total_balls ,sum(batsman_runs) as Total_runs, (sum(batsman_runs)*100/sum(ball)) as Strike_Rate from balls 
where extras_type !='wides'
group by batsman having sum(ball)>=500
) as a
inner join
(select bowler, sum(ball) as Total_Balls, sum(is_wicket) as Total_wickets,sum(ball)/sum(is_wicket) as Strike_Rate  
from balls group by bowler having sum(is_wicket)>0 and sum(ball)>300
) as b
on a.batsman = b.bowler
order by 2 desc,3 asc limit 10; 
--(1/2 orderness)

select a.batsman as All_Rounders, a.Strike_rate as Batting_SR, b.Strike_rate as Bowling_SR from (
	select batsman, sum(ball) as total_balls ,sum(batsman_runs) as Total_runs, (sum(batsman_runs)*100/sum(ball)) as Strike_Rate from balls 
where extras_type !='wides'
group by batsman having sum(ball)>=500
) as a
inner join
(select bowler, sum(ball) as Total_Balls, sum(is_wicket) as Total_wickets,sum(ball)/sum(is_wicket) as Strike_Rate  
from balls group by bowler having sum(is_wicket)>0 and sum(ball)>300
) as b
on a.batsman = b.bowler
order by 3 asc,2 desc limit 10; 
--(2/2 orderness)


-------------------------------------WicketKeeper

select * from balls;

--According to me, the best criteria could be the one who  can catch maximum time

--Top 10 players who caught balls maximum times
select fielder, count(*) as Catches from balls where fielder !='NA' group by fielder order by 2 desc limit 10;


----------------------------------------ADDITIONAL QUESTIONS---------------------------
--Count of cities that have hosted an IPL match
select city, count(city) as Total_Matches from matches group by city order by 2 desc;

--Creating Table deliveries_v02
create table deliveries_v02(
	id int,
	inning int,
	over int,
	ball int,
	batsman varchar,
	non_striker varchar,
	bowler varchar,
	batsman_runs int,
	extra_runs int,
	total_runs int,
	is_wicket int,
	dismissal_kind varchar,
	player_dismissed varchar,
	fielder varchar,
	extras_type varchar,
	batting_team varchar,
	bowling_team varchar,
	ball_result varchar GENERATED ALWAYS AS (
		case
		when total_runs >=4 then 'boundary'
		when total_runs= 0 then 'dot'
		else 'other'
		end
	) STORED
	);
	

--Inserting all the values from Balls Table
insert into deliveries_v02 select * from balls;

select * from deliveries_v02;

--query to fetch the total number of boundaries and dot balls from the deliveries_v02 tbale
select ball_result, count(*) from deliveries_v02 group by ball_result having ball_result='dot' or ball_result='boundary';

--query to fetch the total number of boundaries scored by each team (descending order)
select batting_team, count(*) from deliveries_v02 group by ball_result,batting_team having ball_result='boundary' order by 2 desc;

--query to fetch the total number of dot balls bowled by each team (descending order)
select batting_team, count(*) from deliveries_v02 group by ball_result,batting_team having ball_result='dot' order by 2 desc;

--query to fetch the total number of dismissals by dismissal kinds where dismissal kind is not NA
select dismissal_kind, count(*) from deliveries_v02 group by dismissal_kind having dismissal_kind !='NA';

--query to get the top 5 bowlers who conceded maximum extra runs from the deliveries table
select bowler, sum(extra_runs) as extra_runs from deliveries_v02 group by bowler order by 2 desc limit 5;


--Creating table deliveries_v03

create table deliveries_v03(
	id int,
	inning int,
	over int,
	ball int,
	batsman varchar,
	non_striker varchar,
	bowler varchar,
	batsman_runs int,
	extra_runs int,
	total_runs int,
	is_wicket int,
	dismissal_kind varchar,
	player_dismissed varchar,
	fielder varchar,
	extras_type varchar,
	batting_team varchar,
	bowling_team varchar,
	ball_result varchar,
	venue varchar,
	date date
	);

--Joins of the two tables
select a.*, b.venue, b.date from deliveries_v02 as a inner join matches as b
on a.id=b.id

--insertion of values into deliveries_v03 table
insert into deliveries_v03 select a.*, b.venue, b.date from 
deliveries_v02 as a inner join matches as b
on a.id=b.id;

--query to fetch the total runs scored for each venue and order it in the descending order of total runs scored
select venue,sum(total_runs) as Total_runs from deliveries_v03 group by venue order by 2 desc;

--query to fetch the year-wise total runs scored at Eden Garden and order it in descening order of total runs scored
select Extract(year from date) as year, venue, sum(total_runs) as Total_runs from deliveries_v03 where venue='Eden Gardens' group by year, venue order by 3 desc;




