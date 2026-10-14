create database bollywood_project
use bollywood_project
CREATE TABLE movies(imdbId VARCHAR(20),title VARCHAR(255),releaseYear INT, releaseDate VARCHAR(30),genre VARCHAR(255),writers TEXT,actors TEXT,directors VARCHAR(255),sequel INT,hitFlop INT)
CREATE TABLE actors (actorId INT,actorName VARCHAR(100),movieCount INT,ratingSum INT,normalizedMovieRank DECIMAL(10,5),googleHits BIGINT,normalizedGoogleRank DECIMAL(10,5),normalizedRating DECIMAL(10,5))
CREATE TABLE directors (directorId INT,directorName VARCHAR(100),movieCount INT,ratingSum INT,normalizedMovieRank DECIMAL(10,5),googleHits INT,normalizedGoogleRank DECIMAL(10,5),normalizedRating DECIMAL(10,5))
SELECT * FROM movies
SELECT * FROM actors
SELECT * FROM directors
SELECT COUNT(*) FROM movies
#Display movie title and release year.
SELECT title, releaseYear FROM movies
#Find movies released in 2010.
SELECT title, releaseYear FROM movies WHERE releaseYear=2010
#Find movies released after 2010.
SELECT title, releaseYear FROM movies WHERE releaseYear > 2010
#Display movies in descending order of release year
SELECT title, releaseYear FROM movies ORDER BY releaseYear DESC
#Find the total number of movies in the dataset.
SELECT COUNT(*) AS total_movies FROM movies
#Find how many movies were released in each year
SELECT releaseYear, COUNT(*) AS total_movies FROM movies GROUP BY releaseYear ORDER BY releaseYear
#Find the top 10 actors based on movie count.
SELECT actorName, movieCount FROM actors ORDER BY movieCount DESC LIMIT 10
#Find actors who have acted in more than 20 movies
SELECT actorName, movieCount FROM actors WHERE movieCount > 20 ORDER BY movieCount DESC
#Find the top 10 actors based on normalized rating
SELECT actorName, normalizedRating FROM actors ORDER BY normalizedRating DESC LIMIT 10
#Find the number of movies released in each year and show only years having more than 20 movies.
SELECT releaseYear, COUNT(*) AS total_movies FROM movies GROUP BY releaseYear HAVING COUNT(*) > 20 ORDER BY total_movies DESC
#ind the average number of movies made by actors.
SELECT AVG(movieCount) AS average_movies FROM actors
#Find the average movie count for actors whose movie count is greater than 10.
SELECT AVG(movieCount) AS average_movie_count FROM actors WHERE movieCount > 10
#Find actors whose movie count occurs more than 5 times in the dataset.
SELECT movieCount, COUNT(*) AS number_of_actors FROM actors GROUP BY movieCount HAVING COUNT(*) > 5 ORDER BY movieCount DESC
#Find directors who have made more than 3 movies.
SELECT directorName, SUM(movieCount) AS total_movies FROM directors GROUP BY directorName HAVING SUM(movieCount) > 3 ORDER BY total_movies DESC
#Find actors whose movie count is greater than the average movie count of all actors.
SELECT actorName, movieCount FROM actors WHERE movieCount > (SELECT AVG(movieCount) FROM actors) ORDER BY movieCount DESC
#Find directors whose movie count is greater than the average movie count of all directors.
SELECT directorName, movieCount FROM directors WHERE movieCount > (SELECT AVG(movieCount) FROM directors)ORDER BY movieCount DESC
#Find actors whose normalized rating is greater than the average actor rating.
SELECT actorName, normalizedRating FROM actors WHERE normalizedRating > (SELECT AVG(normalizedRating) FROM actors)ORDER BY normalizedRating DESC
#Find movies released in the year that has the highest number of movies.
SELECT title, releaseYear FROM movies WHERE releaseYear = (SELECT releaseYear FROM movies GROUP BY releaseYear ORDER BY COUNT(*) DESC LIMIT 1)
#Find actors who have more movies than the average number of movies made by directors.
SELECT actorName, movieCount FROM actors WHERE movieCount > (SELECT AVG(movieCount)FROM directors)
#Display movies along with their director ranking information.
SELECT m.title,m.releaseYear,m.directors,d.movieCount,d.normalizedRating FROM movies m JOIN directors d ON m.directors = d.directorName
#Find the movies along with their directors and the director's movie count.
SELECT m.title,m.releaseYear,m.directors,d.movieCount FROM movies m JOIN directors d ON m.directors = d.directorName ORDER BY d.movieCount DESC
#Categorize movies based on their hitFlop rating
SELECT title,hitFlop,CASE WHEN hitFlop >= 7 THEN 'Hit'WHEN hitFlop >= 4 THEN 'Average'ELSE 'Flop'END AS movie_category FROM movies
#Categorize actors based on the number of movies they acted in
SELECT actorName,movieCount,CASE WHEN movieCount > 20 THEN 'Highly Active'WHEN movieCount >= 10 THEN 'Active' ELSE 'Less Active'END AS actor_category FROM actors
#Categorize directors based on their number of movies.
SELECT directorName,movieCount,CASE WHEN movieCount > 10 THEN 'Experienced'WHEN movieCount >= 5 THEN 'Regular'ELSE 'New' END AS director_category FROM directors
#Display movies along with their director's name, movie count and normalized rating for directors who have a normalized rating greater than 7.
SELECT m.title,m.releaseYear,d.directorName,d.movieCount,d.normalizedRating FROM movies m JOIN directors d ON m.directors = d.directorName WHERE d.normalizedRating > 7 ORDER BY d.normalizedRating DESC
#actors whose movie count is greater than the average movie count of both actors and directors.
SELECT actorName,movieCount FROM actors WHERE movieCount > (SELECT AVG(movieCount) FROM actors) AND movieCount > (SELECT AVG(movieCount)FROM directors)ORDER BY movieCount DESC
#The release year that has the highest number of movies and display the year, total movies and a category for the year.
SELECT releaseYear,COUNT(*) AS total_movies,CASE WHEN COUNT(*) > 50 THEN 'Very High Production'WHEN COUNT(*) >= 25 THEN 'High Production'ELSE 'Normal Production'END AS production_level FROM movies GROUP BY releaseYear 
HAVING COUNT(*) = (SELECT MAX(movie_count)FROM (SELECT COUNT(*) AS movie_count FROM movies GROUP BY releaseYear) AS yearly_movies)