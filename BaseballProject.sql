--Show table
SELECT *
FROM BaseballHits..PlayerHits

--Show how many Average At-bats Per Game a player has with each respective position
SELECT *, [At-bat]/Games AS 'Average At-bats Per Position' 
FROM BaseballHits..PlayerHits
ORDER BY [Player name]

--Show how many Average At-bats Per Game a player has regardless of position
SELECT [Player name], SUM([At-bat])/SUM(Games) AS 'Average At-bats Per Game' 
FROM BaseballHits..PlayerHits
GROUP BY [Player name]

--Show the Hitting Percentage and order by the new column descending
SELECT *, Hits/[At-bat]*100 AS 'Hitting Percentage' 
FROM BaseballHits..PlayerHits
ORDER BY 7 DESC

--Show how many Runs Per Hit where players had over 2100 hits
SELECT [Player name], Runs, Hits, Runs/Hits AS RunsPerHit
FROM BaseballHits..PlayerHits
WHERE Runs > 2100
ORDER BY RunsPerHit DESC

--Looking at Position with the Highest Hitting Percentage where the position is a fielder
SELECT Position, MAX(Hits/[At-bat]*100) AS 'Hitting Percentage' 
FROM BaseballHits..PlayerHits
WHERE Position LIKE '%F%'
GROUP BY Position
ORDER BY 2 DESC

--Showing players with the highest Hit Count per Game
SELECT [Player name], MAX(Hits/Games) AS HitCountPerGame
FROM BaseballHits..PlayerHits
GROUP BY [Player name]
ORDER BY HitCountPerGame DESC

--Looking at HitResults
SELECT *
FROM BaseballHits..HitResults

--Joining the two tables
SELECT *
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position

--Looking at percentage of At-bat's that resulted in Walks
SELECT pla.[Player name], pla.position, [At-bat], Walk, Walk/[At-bat]*100 AS WalksPerAtBat
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position
ORDER BY 5 DESC

--Looking at percentage of At-bat's that resulted in Walks regardless of Position
SELECT pla.[Player name], SUM([At-bat]) AS TotalAtBats, SUM(Walk) AS TotalWalks, SUM(Walk)/SUM([At-bat])*100 AS WalksPerAtBat
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position
GROUP BY pla.[Player name]
ORDER BY 4 DESC

--Showing Center Fielders with the highest HRPercentage with over 7000 At-bats
SELECT pla.[Player name], [At-bat], HR/[At-bat]*100 AS HRPercentage
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position
WHERE pla.Position LIKE 'CF' AND [At-bat] > 7000
ORDER BY 3 DESC

--Using a Case statement to display a title for players based on the amount of HRs they have
SELECT pla.[Player name], HR, [At-bat],
CASE 
	WHEN HR > 750 THEN 'Best of All Time'
	WHEN HR BETWEEN 500 AND 750 THEN 'Hall of Famer'
	WHEN HR BETWEEN 250 AND 500 THEN 'Honorary Mention'
	ELSE 'Better luck next time'
END AS Title
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position

--Using a Partition By to show the Average amount of Walks that each Position had
SELECT pla.[Player name], pla.Position, [At-bat], Walk, AVG(Walk) OVER (PARTITION BY pla.Position) AS AvgWalkOfPosition
FROM BaseballHits..PlayerHits pla
JOIN BaseballHits..HitResults res
	ON pla.[Player name] = res.[Player name]
	AND pla.Position = res.Position
ORDER BY Walk DESC









	

