
# IPL Auction

New IPL is going to soon start off and I have been assigned as the data analyst to perform analysis with different analytics tool to provide the names of players to build a strong and balanced squad. The team's management would likely need to strike a balance
between all of these factors and come up with a well-thought-out auction strategy. This could involve targeting a few key players they consider to be game-changers, while also filling out the rest of the squad with more affordable players who can add value to the team. It could also involve making use of the various player retention and right-to-match options available to them.

I have used SQL mainly in order to provide the analysis and can be considered SQL-centric project. I have used PostgreSQL as the software to perform different operations.




## How to use the project
  You have to run the queries first which are necessary


```bash

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

```

### Importing the Data

```bash
Copy balls from '"Your Location"\IPL_Ball.csv' DELIMITER ',' CSV HEADER;
select * from balls;


Copy matches from '"Your Location"\IPL Dataset\IPL Dataset\IPL_matches.csv' DELIMITER ',' CSV HEADER;
select * from matches;


```

You are good to go to run other queries or even modify them according to your needs!  

## Project Highlights
![1](https://github.com/zeul22/IPL-Auction/assets/62982824/fe64f162-1dd2-460a-953d-aa71de9fd94f)
![2](https://github.com/zeul22/IPL-Auction/assets/62982824/c51619a4-5fcf-4290-b4df-b0505be97559)
![3](https://github.com/zeul22/IPL-Auction/assets/62982824/eab88ae4-dfe9-4c05-b32d-fa9cea3273d5)
![4](https://github.com/zeul22/IPL-Auction/assets/62982824/d57c0b36-3dfa-4e80-b396-3da35574ab75)
![5](https://github.com/zeul22/IPL-Auction/assets/62982824/7391ff9a-b7d9-407b-9362-fc5f1441150f)



## Badges

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)


## Feedback

If you have any feedback, please reach out to me at anandrahul044@gmail.com

