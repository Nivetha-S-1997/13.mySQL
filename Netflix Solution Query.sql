USE Netflix_db;

-- 1. List all users subscribed to the Premium plan:
SELECT user_id, name, plan
FROM Users
where plan='Premium';

-- 2. Retrieve all movies in the Drama genre with a rating higher than 8.5:
SELECT title, genre, rating
FROM Movies
WHERE rating>8.5 AND genre='Drama';

-- 3. Find the average rating of all movies released after 2015:
SELECT AVG(rating) AS Average_rating
FROM Movies
WHERE release_year>2015;

-- 4. List the names of users who have watched the movie Stranger Things along with their completion percentage:
SELECT Users.name, Movies.title, Watch_history.completion_percentage
FROM Users
JOIN Watch_history ON Watch_history.user_id=Users.user_id
JOIN Movies ON Watch_history.movie_id=Movies.movie_id
WHERE title='Stranger Things';

-- 5. Find the name of the user(s) who rated a movie the highest among all reviews:
SELECT Users.name, Reviews.rating
FROM Reviews
JOIN Users ON Reviews.user_id=Users.user_id
WHERE Reviews.rating= (SELECT MAX(rating) FROM Reviews);

-- 6. Calculate the number of movies watched by each user and sort by the highest count:
SELECT Users.name,
COUNT(Watch_history.watch_id) AS total_movies_watched
FROM Watch_history
JOIN Users ON Watch_history.user_id=Users.user_id
GROUP BY Users.user_id
ORDER BY total_movies_watched DESC;

-- 7.List all movies watched by John Doe, including their genre, rating, and his completion percentage:
SELECT Movies.title, Movies.genre, Movies.rating, Watch_history.completion_percentage
FROM Watch_history
JOIN Movies ON Watch_history.movie_id=Movies.movie_id
WHERE Watch_history.user_id=1;

-- 8.Update the movie's rating for Stranger Things:
SET SQL_SAFE_UPDATES=0;

UPDATE Movies
SET rating=8.8
WHERE title='Stranger Things';

SELECT * FROM Movies;

-- 9.Remove all reviews for movies with a rating below 4.0:
DELETE FROM Reviews
WHERE rating<4;

SELECT * FROM Reviews;

-- 10. Fetch all users who have reviewed a movie but have not watched it completely (completion percentage < 100):
SELECT Users.name, Watch_history.completion_percentage
FROM Reviews
INNER JOIN Users ON Reviews.user_id=Users.user_id
JOIN Watch_history ON Users.user_id=Watch_history.user_id
HAVING Watch_history.completion_percentage<100;

-- 12.Retrieve all users who have reviewed the movie Stranger Things, including their review text and rating:
SELECT Users.name, Users.email_id, Movies.title, Reviews.review_text, Reviews.rating
FROM Users
JOIN Reviews ON Users.user_id=Reviews.user_id
JOIN Movies ON Reviews.movie_id=Movies.movie_id
HAVING Movies.title='Stranger Things';

-- 13. Fetch the watch history of all users, including their name, email, movie title, genre, watched date, and completion percentage:
SELECT Users.name, Users.email_id, Movies.title, Movies.genre, Watch_history.watched_date, Watch_history.completion_percentage
FROM Users
INNER JOIN Watch_history ON Watch_history.user_id=Users.user_id
JOIN Movies ON Watch_history.movie_id=Movies.movie_id;

-- 14.List all movies along with the total number of reviews and average rating for each movie, including only movies with at least two reviews:
SELECT Movies.title,
COUNT(Reviews.review_id) AS total_no_reviews,
AVG(Reviews.rating) AS Avg_rating
FROM Movies
INNER JOIN Reviews ON Movies.movie_id=Reviews.movie_id
GROUP BY Movies.title
HAVING total_no_reviews>=2;