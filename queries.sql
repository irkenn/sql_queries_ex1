-- write your queries here

-- first table
SELECT * FROM owners o
	FULL JOIN vehicles v
	ON o.id = v.owner_id
	ORDER BY o.id;


-- second table
SELECT o.first_name, o.last_name, count(*) 
	FROM vehicles v 
	JOIN owners o
	ON o.id = v.owner_id
	GROUP BY o.first_name, o.last_name
	ORDER BY count;


-- third table

SELECT o.first_name, o.last_name, ROUND(AVG(CAST(v.price AS int)), 0) AS average_price, count(*)
	FROM vehicles v 
	JOIN owners o
	ON o.id = v.owner_id
	GROUP BY o.first_name, o.last_name
	HAVING AVG(v.price) > 10000
	ORDER BY count desc;

--JOIN exercises 6 https://sqlzoo.net/wiki/The_JOIN_operation

--1.-
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- 2.-
SELECT id,stadium,team1,team2
  FROM game
 WHERE game.id = 1012

-- 3.-
SELECT player,teamid, stadium, mdate 
  FROM game JOIN goal ON (id=matchid)
 WHERE goal.teamid = 'GER'

 -- 4.-
SELECT team1, team2, player 
  FROM game JOIN goal ON (id=matchid)
 WHERE goal.player LIKE  'Mario%'

 -- 5.-
SELECT player, teamid, coach, gtime
  FROM goal 
 JOIN eteam 
 ON teamid=id
 WHERE gtime<=10

 -- 6.-
SELECT mdate, teamname 
 FROM game
 JOIN eteam
 ON team1 = eteam.id
 WHERE eteam.coach = 'Fernando Santos' 


-- 7.-
SELECT player 
 FROM goal
 JOIN game
 ON goal.matchid = game.id
 WHERE stadium = 'National Stadium, Warsaw'

 -- 8.-
 SELECT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' AND goal.teamid != 'GER' OR   team2='GER' AND goal.teamid != 'GER')
 GROUP BY player
 ORDER BY player

 -- 9.-
 SELECT teamname, count(*)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname
 ORDER BY teamname

 -- 10.- 
 SELECT stadium, count(*) 
 FROM game
 JOIN goal ON game.id = goal.matchid
 GROUP BY stadium
 ORDER BY stadium

 -- 11.-
 SELECT matchid, mdate, count(*)
  FROM game JOIN goal ON matchid = id 
GROUP BY mdate, matchid, team1, team2
 HAVING (team1 = 'POL' OR team2 = 'POL')

 -- 12.-
SELECT matchid, mdate, count(*) 
 FROM goal
 JOIN game ON id=matchid
 GROUP BY matchid, mdate, teamid
 HAVING (goal.teamid = 'GER')

 -- 13.-
 SELECT mdate,
  team1,
   SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
 team2,
 SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
 FROM game JOIN goal ON matchid = id
 GROUP BY mdate, matchid, team1, team2
 ORDER BY mdate, matchid

-- JOIN excercise 7: https://sqlzoo.net/wiki/More_JOIN_operations

-- 1.-
SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2.-
SELECT yr FROM movie
WHERE title LIKE 'Citizen Kane'

-- 3.-
SELECT id, title, yr 
 FROM movie
 WHERE title LIKE '%Star Trek%'

-- 4.-
SELECT id 
FROM actor
WHERE name LIKE 'Glenn Close'

-- 5.-
SELECT id
FROM movie
WHERE title LIKE 'Casablanca'

-- 6.-
SELECT actor.name 
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 27

-- 7.-
SELECT actor.name
 FROM actor
 JOIN casting ON actor.id = casting.actorid
 JOIN movie ON movie.id = casting.movieid
 WHERE movie.title = 'Alien'

-- 8.-
SELECT movie.title 
 FROM movie
 JOIN casting ON movie.id = casting.movieid
 JOIN actor ON casting.actorid = actor.id
 WHERE actor.name = 'Harrison Ford'

-- 9.-
SELECT movie.title 
 FROM movie
 JOIN casting ON movie.id = casting.movieid
 JOIN actor ON casting.actorid = actor.id
 WHERE actor.name = 'Harrison Ford' AND casting.ord != 1

-- 10.-
SELECT movie.title, actor.name
 FROM movie
 JOIN casting ON movie.id = casting.movieid
 JOIN actor ON casting.actorid = actor.id
  WHERE movie.yr = 1962 AND casting.ord = 1

-- 11.-
SELECT yr, COUNT(title) 
 FROM movie 
 JOIN casting ON movie.id=movieid
 JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1

-- 12.-
SELECT movie.title, actor.name
 FROM movie
  JOIN casting ON (movie.id = casting.movieid AND casting.ord = 1)
  JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN( 
           SELECT movieid FROM casting
                WHERE actorid IN (
                SELECT id FROM actor
                WHERE name='Julie Andrews'))

-- 13 .-
SELECT actor.name 
 FROM actor
  JOIN casting ON (actor.id = casting.actorid AND casting.ord = 1)
  JOIN movie ON (movie.id = actor.id)
GROUP BY actor.name 
 HAVING COUNT(actor.id) >= 15
ORDER BY actor.name

-- 14.-
SELECT movie.title, COUNT(*)
 FROM casting
 JOIN movie ON (movie.id = casting.movieid AND movie.yr = 1978)
 GROUP BY movie.title
 ORDER BY COUNT(casting.actorid) desc, movie.title

--15.-
SELECT actor.name
 FROM casting
     JOIN actor ON (actor.id = casting.actorid AND actor.name != 'Art Garfunkel')
     JOIN movie ON (movie.id = casting.movieid)
WHERE casting.movieid IN(
        SELECT movie.id FROM casting
            JOIN actor ON (actor.id = casting.actorid)
            JOIN movie ON (movie.id = casting.movieid)
                WHERE actor.name = 'Art Garfunkel')









