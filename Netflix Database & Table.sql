CREATE DATABASE Netflix_db;
USE Netflix_db;

CREATE TABLE Users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email_id VARCHAR(150) NOT NULL UNIQUE,
registration_date DATE NOT NULL,
plan ENUM('Basic','Standard','Premium') DEFAULT 'Basic'
);

SELECT * FROM Users;

INSERT INTO Users (name, email_id, registration_date, plan)
VALUES
('John Doe', 'john.doe@example.com', '2024-01-10', 'Premium'),
('Jane Smith', 'jane.smith@example.com', '2024-01-15', 'Standard'),
('Alice Johnson', 'alice.johnson@example.com', '2024-02-01', 'Basic'),
('Bob Brown', 'bob.brown@example.com', '2024-02-20', 'Premium');

CREATE TABLE Movies (
movie_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(200) NOT NULL,
genre VARCHAR(100) NOT NULL,
release_year YEAR NOT NULL,
rating DECIMAL (3,2) NOT NULL
);

INSERT INTO Movies(title, genre, release_year, rating)
VALUES
('Stranger Things', 'Drama', 2016, 8.7),
('Breaking Bad', 'Crime', 2008, 9.5),
('The Crown', 'History', 2016, 8.6),
('The Witcher', 'Fantasy', 2019, 8.2),
('Black Mirror', 'Sci-Fi', 2011, 8.8);

SELECT * FROM Movies;

CREATE TABLE Watch_history(
watch_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
movie_id INT,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
watched_date DATE NOT NULL,
completion_percentage INT NOT NULL
);

INSERT INTO Watch_history (user_id, movie_id, watched_date, completion_percentage)
VALUES
(1, 1, '2024-02-05', 100),
(2, 2, '2024-02-06', 80),
(3, 3, '2024-02-10', 50),
(4, 4, '2024-02-15', 100),
(1, 5, '2024-02-18', 90);

SELECT * FROM Watch_history;

CREATE TABLE Reviews(
review_id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
movie_id INT,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
review_text TEXT,
rating DECIMAL(3,2) NOT NULL CHECK (rating>=0 AND rating<=5),
review_date DATE NOT NULL
);

INSERT INTO Reviews (user_id, movie_id, review_text, rating, review_date)
VALUES
(1, 1, 'Amazing storyline and great characters!', 4.5, '2024-02-07'),
(2, 2, 'Intense and thrilling!', 5.0, '2024-02-08'),
(3, 3, 'Good show, but slow at times.', 3.5, '2024-02-12'),
(4, 4, 'Fantastic visuals and acting.', 4.8, '2024-02-16');

SELECT * FROM Reviews;

TRUNCATE TABLE  Reviews;
