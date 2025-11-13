USE Soccer_Team_DB;

--1. View the first 100 rows of the dataset to understand its structure. 
SELECT TOP 100 * FROM [dbo].[ketro_sa_soccer_dataset_advanced];

--2. Count the total number of players in the dataset. 
SELECT COUNT(*) AS TOTA_PLAYERS
FROM [dbo].[ketro_sa_soccer_dataset_advanced];

--3. List all unique teams in the league. 
SELECT DISTINCT(TEAM) AS TEAM_NAME
FROM [dbo].[ketro_sa_soccer_dataset_advanced];

--4. Count how many players are in each team.
SELECT COUNT(Player_Name) as team_player,
	   team
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team;
--5. Identify the top 10 players with the most goals. 
SELECT top 10 Player_name,
	          goals
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY goals DESC
--6. Find the average salary for players in each team. 
SELECT AVG(CAST(average_salary_zar AS float)) AS AVG_Salary_zar,
	   team
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team;

--7. Retrieve the top 10 players with the highest market value. 
SELECT TOP 10 Player_name,
              Market_value_zar
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY market_value_zar DESC

--8. Calculate the average passing accuracy for each position. 
SELECT AVG(CAST(passing_accuracy AS FLOAT)) AS average_value,
       POSITION
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
WHERE ISNUMERIC(passing_accuracy) = 1
GROUP BY POSITION
ORDER BY position;

--9. Compare shot accuracy with goals to find correlations. 
SELECT
      team,
      SUM(CAST(goals AS FLOAT)) AS total_goals,
      SUM(CAST(shot_accuracy AS FLOAT)) * 1.0 / NULLIF(SUM(CAST(goals AS FLOAT)), 0) AS shot_accuracy,
      COUNT(*) AS matches_played
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY shot_accuracy DESC;

--10. Compute total goals and assists for each team. 
SELECT SUM(CAST(goals AS FLOAT)) AS goals,
       SUM(CAST(assists AS FLOAT)) AS assist,
	   team
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY team;
--11. Count players by their marital status. 
SELECT COUNT(player_name) AS Count_Players,
       marital_status
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY marital_status;
--12. Count players by nationality. 
SELECT COUNT(Player_name) AS Players,
       nationality
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY nationality;
--13. Find average market value grouped by nationality. 
SELECT AVG(CAST(market_value_zar AS FLOAT)) as market_value,
       nationality
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY nationality;
--14. Determine how many player contracts end in each year. 
SELECT 
      contract_end_year,
      COUNT(Player_name) AS Player_Count,
      CASE 
          WHEN contract_end_year = YEAR(GETDATE()) THEN 'Ends This Year'
		  WHEN contract_end_year = YEAR(GETDATE()) + 1 THEN 'Ends Next Year'
          WHEN contract_end_year < YEAR(GETDATE()) THEN 'Expired'
          ELSE 'Active Beyond Next Year'
    END AS Contract_Status
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY contract_end_year
ORDER BY contract_end_year;

--15. Identify players whose contracts end next year. 
SELECT Player_name,contract_end_year
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
WHERE contract_end_year = 2026;
--16. Summarize the number of players by injury status. 
SELECT COUNT(Player_name),injury_status
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY injury_status;
--17. Calculate goals per match ratio for each player. 
SELECT
  player_name,
  TRY_CAST(goals AS FLOAT) / NULLIF(TRY_CAST(matches_played AS FLOAT), 0) AS goals_per_match
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
--18. Count how many players are managed by each agent. 
SELECT COUNT(player_name)as number_of_players,agent
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY agent;
--19. Calculate average height and weight by player position. 
SELECT AVG(height_cm) as avg_height, AVG(weight_kg) as avg_weight,position
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY position;
--20. Identify players with the highest combined goals and assists.
SELECT Player_name,(SUM(CAST(goals AS float)) + SUM(CAST(assists AS float))) AS highest_combined_goals_and_assists
FROM [dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY player_name
ORDER BY highest_combined_goals_and_assists DESC;