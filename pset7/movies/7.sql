SELECT movies.title, ratings.rating
FROM movies
JOIN ratings on id = movie_id
WHERE year = 2010
ORDER BY ratings.rating DESC, movies.title ASC;
